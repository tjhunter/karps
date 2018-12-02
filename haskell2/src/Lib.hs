{-# LANGUAGE ForeignFunctionInterface #-}


module Lib
    ( someFunc
    ) where

import Foreign.C.Types
import Foreign.C.String
import Foreign
import Data.String
import Data.ByteString(packCStringLen, ByteString)
import Data.Text.Encoding(decodeUtf8, encodeUtf8)
import qualified Data.ByteString as BS
import qualified Data.Vector as V
import Foreign.Marshal.Array(mallocArray, copyArray)
import Formatting
import Data.Text(pack, Text)
import Data.ProtoLens.Encoding(decodeMessage, encodeMessage)
import Data.ProtoLens.Message(Message)
import Data.ProtoLens.TextFormat(showMessage)
import Data.ProtoLens(def)
import Lens.Micro((&), (.~), (^.))

import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.Graph_Fields as PG
import qualified Proto.Karps.Proto.ApiInternal as PI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PI
import Spark.Common.ComputeDag(buildCGraphFromList, computeGraphMapVertices, mapVertexData, cdVertices, computeGraphMapVerticesI)
import Spark.Common.NodeBuilder(NodeBuilderRegistry, registryNode, nbBuilder)
import Spark.Common.NodeFunctions(buildOpNodeInScope, buildOpNode)
import Spark.Common.NodeStructures
import Spark.Common.OpStructures
import Spark.Common.ProtoUtils(FromProto(..), ToProto(..), extractMaybe, extractMaybe')
import Spark.Common.StructuresInternal(NodePath(..), NodeId)
import Spark.Common.TypesStructures(DataType)
import Spark.Common.Try
import Spark.Common.Utilities(sh, show', traceHint)
import Spark.Compiler.Compiler
import Spark.Common.DAGStructures(Vertex(..), VertexId(..), Edge(..))
import Spark.Common.StructuresInternal(NodeId, ComputationID, NodePath, prettyNodePath)

import Lib3

someFunc :: IO ()
someFunc = putStrLn "someFunc"

fibonacci_hs :: CInt -> CInt
fibonacci_hs = fromIntegral . fibonacci . fromIntegral

input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)
input_hs l p l_out = do
  let len = (fromIntegral l) :: Int
  putStrLn $ "len=" ++ (show len)
  putStrLn $ "p=" ++ (show p)
  bs <- packCStringLen((p, len))
  putStrLn $ "bs=" ++ (show bs)
  let txt = decodeUtf8 bs
  putStrLn $ "txt=" ++ (show txt)
  poke l_out l
  putStrLn $ "l_out=" ++ (show l_out)
  let out = (pack "Hi there ") <> txt
  let out_bs = encodeUtf8 out
  BS.useAsCStringLen out_bs $ \(cs, cl) -> do
    let out_len = (fromIntegral cl) :: Int
    poke l_out (fromIntegral out_len)
    -- poke l_out (fromIntegral out_len)
    out_p <- mallocArray out_len
    copyArray out_p cs out_len
    return out_p

type CTrans = CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

transform_simple :: (ByteString -> ByteString) -> CTrans
transform_simple f l p l_out = do
  let len = (fromIntegral l) :: Int
  bs <- packCStringLen((p, len))
  let out_bs = f bs
  _return out_bs l_out

transform_io :: (ByteString -> IO ByteString) -> CTrans
transform_io f l p l_out = do
  let len = (fromIntegral l) :: Int
  bs <- packCStringLen((p, len))
  out_bs <- f bs
  _return out_bs l_out

_return :: ByteString -> Ptr CInt -> IO (Ptr CChar)
_return out_bs l_out = do
  BS.useAsCStringLen out_bs $ \(cs, cl) -> do
    let out_len = (fromIntegral cl) :: Int
    poke l_out (fromIntegral out_len)
    out_p <- mallocArray out_len
    copyArray out_p cs out_len
    return out_p

-- TODO: add a free function for the pointers that we return, they cannot be deallocated
-- on the other side.

my_transform1 :: CTrans
my_transform1 = transform_simple f where
  f bs = out_bs where
    txt = decodeUtf8 bs
    out = (pack "Hi there ") <> txt
    out_bs = encodeUtf8 out


-- Node building

data PathRequest = UseScope !NodePath | UsePath !NodePath

data NIdRequest = RecomputeId | ReuseId NodeId

data NodeBuilderRequest = NodeBuilderRequest !OperatorName !OpExtra [ParsedNode] PathRequest NIdRequest

data GraphTransformRequest = GraphTransformRequest !PG.Graph ![NodePath]

instance FromProto PI.NodeBuilderRequest NodeBuilderRequest where
  fromProto nbr = do
    on <- fromProto $ nbr ^. PI.opName
    oe <- fromProto (nbr ^. PI.extra)
    let z = nbr ^. PI.parents
    ps <- sequence $ fromProto <$> (nbr ^. PI.parents) :: Try [ParsedNode]
    p <- fromProto $ nbr ^. PI.requestedScope
    return $ NodeBuilderRequest on oe ps (UseScope p) RecomputeId

instance FromProto PI.GraphTransformRequest GraphTransformRequest where
  fromProto gtr = do
    let g = gtr ^. PI.functionalGraph
    paths <- sequence $ fromProto <$> (gtr ^. PI.requestedPaths)
    return $ GraphTransformRequest g paths


build_node :: CTrans
build_node = transform_io f where
  error_msg :: Text -> PI.NodeBuilderResponse
  error_msg ne = out_msg where
      err_msg = (def :: PI.ErrorMessage) & PI.message .~ (pack "error message:" <> show' ne)
      out_msg = (def :: PI.NodeBuilderResponse) & PI.error .~ err_msg
  error_msg' ne = out_msg where
      out_msg = (def :: PI.NodeBuilderResponse) & PI.error .~ toProto ne

  f :: ByteString -> IO ByteString
  f bs = do
    registry <- accessRegistry
    let out = case traceHint "build_node:decode_out" (decodeMessage bs) of
          Left txt -> error_msg (pack txt)
          Right (nbr :: PI.NodeBuilderRequest) -> case snd <$> (fromProto nbr >>= (_buildNode registry)) of
            Left ne -> error_msg' ne
            Right (pn :: ParsedNode) ->
                (def :: PI.NodeBuilderResponse) & PI.success .~ toProto pn
    return $ encodeMessage out

_buildNode :: NodeBuilderRegistry -> NodeBuilderRequest -> Try (OperatorNode, ParsedNode)
_buildNode registry (NodeBuilderRequest op_name extras parents pathpol nidpol) = do
  builder <- case registry `registryNode` op_name of
        Nothing -> tryError $ sformat ("_buildNode: could not find op name '"%sh%"' in the registry") op_name
        Just nb' -> pure nb'
  let parent_shapes = f <$> parents where f pn = NodeShape (pnType pn) (pnLocality pn)
  cni <- nbBuilder builder extras parent_shapes
  let ns = cniShape cni
  parent_nids <- _extractNid parents
  let dep_nids = [] -- TODO: deps
  let on' = case pathpol of
              UseScope scope -> buildOpNodeInScope cni scope parent_nids dep_nids
              UsePath p -> buildOpNode cni p parent_nids dep_nids
  let on = case nidpol of
              ReuseId nid' -> on' { onId = nid' }
              RecomputeId -> on'
  return $ (on, ParsedNode {
      pnLocality = nsLocality ns,
      pnPath = onPath on,
      pnOpName = op_name,
      pnExtra = extras,
      pnParents = pnPath <$> parents,
      pnDeps = [],
      pnType = nsType ns,
      pnId = pure $ onId on
    })

_opNodeToParseNode :: OperatorNode -> [NodePath] -> [NodePath] -> ParsedNode
_opNodeToParseNode on parents deps = ParsedNode {
    pnLocality = nsLocality . onShape $ on,
    pnPath = onPath on,
    pnOpName = "!!!",
    pnExtra = emptyExtra, -- FIXME
    pnParents = parents,
    pnDeps = deps,
    pnType = nsType . onShape $ on,
    pnId = pure $ onId on
  }

_extractNid :: [ParsedNode] -> Try [NodeId]
_extractNid l = x
  where
    f :: Maybe NodeId -> Try NodeId
    f Nothing = tryError $ sformat ("_buildNode: some node IDs are missing")
    f (Just nid) = pure nid
    x = sequence $ f . pnId <$> l


compile_graph :: CTrans
compile_graph = transform_io f where
  error_msg :: Text -> PI.GraphTransformResponse
  error_msg ne = out_msg where
      err_msg = (def :: PI.ErrorMessage) & PI.message .~ (pack "error message:" <> show' ne)
      out_msg = (def :: PI.GraphTransformResponse) & PI.error .~ err_msg
  error_msg' ne = out_msg where
      out_msg = (def :: PI.GraphTransformResponse) & PI.error .~ toProto ne

  f :: ByteString -> IO ByteString
  f bs = do
    registry <- accessRegistry
    let out = case decodeMessage bs of
          Left txt -> error_msg (pack txt)
          Right (nbr :: PI.GraphTransformRequest) -> case fromProto nbr >>= _transformGraphFast registry of
            Left ne -> error_msg' ne
            Right (r :: PI.GraphTransformResponse) -> r
    return $ encodeMessage out

-- Parses the compute graph.
-- It relies on the fact that the IDs have already been computed
-- The final graph may be malformed.
_transformGraphFast ::
  NodeBuilderRegistry -> GraphTransformRequest -> Try PI.GraphTransformResponse
_transformGraphFast reg (GraphTransformRequest g requestedPaths) = do
  -- Parse the nodes
  nodes <- sequence $ fromProto <$> (g ^. PG.nodes)
  -- Build the edges from the nodes.
  let edges = concatMap f nodes where
       f node = f' ParentEdge (pnPath node) (pnParents node)
            ++ f' LogicalEdge (pnPath node) (pnDeps node)
       f' :: StructureEdge -> NodePath -> [NodePath] -> [Edge StructureEdge]
       f' et p ps = [Edge (pathToVId p) (pathToVId p') et | p' <- ps]
  let vertices = f <$> nodes where
        f n = Vertex (pathToVId (pnPath n)) n
  let requestedVIds = pathToVId <$> requestedPaths
  -- Make a first graph with the parsed nodes
  -- TODO: what should the inputs be?
  cg' <- traceHint ("_loadGraphFast: cg'=") $ tryEither $ buildCGraphFromList vertices edges [] requestedVIds
  -- Transform this graph to load the content of the nodes.
  cg'' <- traceHint ("_loadGraphFast: cg=") $ computeGraphMapVertices cg' (_buildNodeInGraph reg)
  let cg = mapVertexData fst cg''
  return $ _transformResponse cg


_transformResponse :: ComputeGraph -> PI.GraphTransformResponse
_transformResponse cg =
  (def :: PI.GraphTransformResponse)
    & PI.pinnedGraph .~ ((def :: PG.Graph)
        & PG.nodes .~ l) where
          cg2 = computeGraphMapVerticesI cg f where
            f :: OperatorNode -> [(ParsedNode, StructureEdge)] -> ParsedNode
            f on l2 = _opNodeToParseNode on parents deps where
              parents = [pnPath pn | (pn, ParentEdge) <- l2]
              deps = [pnPath pn | (pn, LogicalEdge) <- l2]
          l = toProto . vertexData <$> V.toList (cdVertices cg2)

_buildNodeInGraph :: NodeBuilderRegistry -> ParsedNode -> [((OperatorNode, ParsedNode), StructureEdge)] -> Try (OperatorNode, ParsedNode)
_buildNodeInGraph reg pn l = case (pnId pn) of
  Nothing -> tryError $ "_buildNodeInGraph: missing node id for node " <> (show' pn)
  Just nid -> _buildNode reg nbr where
        nbr = NodeBuilderRequest (pnOpName pn) (pnExtra pn) (snd . fst <$> l) (UsePath (pnPath pn)) (ReuseId nid)

foreign export ccall fibonacci_hs :: CInt -> CInt

foreign export ccall input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

foreign export ccall my_transform1 :: CTrans

foreign export ccall build_node :: CTrans

foreign export ccall compile_graph :: CTrans
