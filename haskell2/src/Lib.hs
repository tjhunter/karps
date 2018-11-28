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
import Spark.Common.NodeBuilder(NodeBuilderRegistry, registryNode, nbBuilder)
import Spark.Common.OpStructures(CoreNodeInfo(..), OpExtra, OperatorName, Locality(..), NodeShape(..), localityToProto)
import Spark.Common.ProtoUtils(FromProto(..), ToProto(..), extractMaybe, extractMaybe')
import Spark.Common.StructuresInternal(NodePath(..))
import Spark.Common.TypesStructures(DataType)
import Spark.Common.Try(Try(..), tryError)
import Spark.Common.Utilities(sh, show')

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

data ParsedNode = ParsedNode {
  pnLocality :: !Locality,
  pnPath :: !NodePath,
  pnOpName :: !OperatorName,
  pnExtra :: !OpExtra,
  pnParents :: ![NodePath],
  pnDeps :: ![NodePath],
  pnType :: !DataType
} deriving (Show)

data NodeBuilderRequest = NodeBuilderRequest !OperatorName !OpExtra [ParsedNode]

instance FromProto PI.NodeBuilderRequest NodeBuilderRequest where
  fromProto nbr = do
    let on = nbr ^. PI.opName
    oe <- fromProto (nbr ^. PI.extra)
    let z = nbr ^. PI.parents
    ps <- sequence $ fromProto <$> (nbr ^. PI.parents) :: Try [ParsedNode]
    return $ NodeBuilderRequest on oe []


instance FromProto PG.Node ParsedNode where
  fromProto pn = do
    p <- extractMaybe' pn PG.maybe'path "path"
    extra <- extractMaybe' pn PG.maybe'opExtra "op_extra"
    parents' <- sequence $ fromProto <$> (pn ^. PG.parents)
    deps <- sequence $ fromProto <$> (pn ^. PG.logicalDependencies)
    dt <- extractMaybe' pn PG.maybe'inferedType "infered_type"
    let loc = case pn ^. PG.locality of
          PG.DISTRIBUTED -> Distributed
          PG.LOCAL -> Local
    return ParsedNode {
      pnLocality = loc,
      pnPath = p,
      pnOpName = pn ^. PG.opName,
      pnExtra = extra,
      pnParents = parents',
      pnDeps = deps,
      pnType = dt
    }

instance ToProto PG.Node ParsedNode where
  toProto pn = (def :: PG.Node)
     & PG.locality .~ localityToProto (pnLocality pn)
     & PG.path .~ toProto (pnPath pn)
     & PG.opName .~ pnOpName pn
     & PG.opExtra .~ toProto (pnExtra pn)
     & PG.parents .~ (toProto <$> pnParents pn)
     & PG.logicalDependencies .~ (toProto <$> pnDeps pn)
     & PG.inferedType .~ toProto (pnType pn)

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
    let out = case decodeMessage bs of
          Left txt -> error_msg (pack txt)
          Right (nbr :: PI.NodeBuilderRequest) -> case fromProto nbr >>= _build_node registry of
            Left ne -> error_msg' ne
            Right (pn :: ParsedNode) ->
                (def :: PI.NodeBuilderResponse) & PI.success .~ toProto pn
    return $ encodeMessage out

_build_node :: NodeBuilderRegistry -> NodeBuilderRequest -> Try ParsedNode
_build_node registry (NodeBuilderRequest op_name extras parents) = do
  builder <- case registry `registryNode` op_name of
        Nothing -> tryError $ sformat ("_buildNode: could not find op name '"%sh%"' in the registry") op_name
        Just nb' -> pure nb'
  let parent_shapes = f <$> parents where f pn = NodeShape (pnType pn) (pnLocality pn)
  cni <- nbBuilder builder extras parent_shapes
  let ns = cniShape cni
  return $ ParsedNode {
      pnLocality = nsLocality ns,
      pnPath = NodePath V.empty,
      pnOpName = op_name,
      pnExtra = extras,
      pnParents = pnPath <$> parents,
      pnDeps = [],
      pnType = nsType ns
    }
--build_node_internal :: StructuredNodeBuilderRegistry -> OpName -> OpExtra -> [NodeShape] -> Try Node

foreign export ccall fibonacci_hs :: CInt -> CInt

foreign export ccall input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

foreign export ccall my_transform1 :: CTrans

foreign export ccall build_node :: CTrans
