{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-| The data structures for the server part -}
module Spark.Server.Transform(
  transform,
  loadGraph
) where


import qualified Data.HashMap.Strict as HM
import qualified Data.Map.Strict as M
import qualified Data.Vector as V
import qualified Data.Map.Strict as Map
import qualified Data.Vector as V
import Data.Text(Text)
import Debug.Trace
import Control.Arrow((&&&))
import Control.Monad(when)
import Data.Map.Strict(Map)
import Data.Maybe(fromMaybe)
import Data.ProtoLens.Message(Message)
import Lens.Family2 ((&), (.~), (^.), FoldLike)
import Formatting
import Debug.Trace

import Spark.Core.Internal.TypesFunctions()
import Spark.Core.Try
import Spark.Core.Internal.ContextInternal
import Spark.Core.Context(defaultConf)
import Spark.Core.Internal.ContextStructures
import Spark.Core.Internal.Utilities(show')
import Spark.Core.Internal.DAGStructures
-- Required to import the instances.
import Spark.Core.Internal.Paths()
-- import Spark.Server.StructureParsing(parseInput, protoResponse)
import Spark.Core.Internal.BrainStructures
import Spark.Core.Internal.BrainFunctions
import Spark.Core.Internal.StructuredBuilder
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Try
import qualified Proto.Karps.Proto.ApiInternal as PAI
import qualified Proto.Karps.Proto.Graph as PG
import Spark.Core.StructuresInternal
import Spark.Core.Dataset(UntypedNode)
import Spark.Core.Internal.TypesFunctions()
import Spark.Core.Try
import Spark.Core.Internal.BrainStructures
import Spark.Core.Internal.Utilities(myGroupBy, sh, traceHint)
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.DatasetStructures(ComputeNode(..), NodeContext(..), unTypedLocality, StructureEdge(..), OperatorNode(..), onShape)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.OpFunctions
import Spark.Core.Internal.ComputeDag
import Spark.Core.Internal.DAGStructures
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Internal.DatasetStd(literalBuilderD)
import Spark.Server.Registry(nodeRegistry)
import Spark.Core.Types
import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.ApiInternal as PAI


{-| This function deserializes the data, performs a few sanity checks, and then
calls the compiler. -}
transform :: CompilerConf -> PAI.PerformGraphTransform -> PAI.GraphTransformResponse
transform conf pgt = case _transform conf pgt of
  Right x -> x
  Left ne ->
    -- We did not even get to constructing the graph, just return that error.
    toProto GraphTransformFailure {
        gtfMessage = ne,
        gtfCompilerSteps = []
      }

loadGraph ::
  NodeBuilderRegistry ->
  PG.Graph ->
  [PG.Path] ->
  Try ComputeGraph
loadGraph reg g requestedPaths = do
  -- Parse the nodes
  nodes <- sequence $ fromProto <$> (g ^. PG.nodes)
  -- Build the edges from the nodes.
  let edges = concatMap f nodes where
       f node = f' ParentEdge (pnPath node) (pnParents node)
            ++ f' LogicalEdge (pnPath node) (pnDeps node)
       f' :: StructureEdge -> NodePath -> [NodePath] -> [Edge StructureEdge]
       f' et p ps = [Edge (parseNodeId p) (parseNodeId p') et | p' <- ps]
  let vertices = f <$> nodes where
        f n = Vertex (parseNodeId (pnPath n)) n
  requestedPaths' <- sequence $ fromProto <$> requestedPaths
  let requestedIds = parseNodeId <$> requestedPaths'
  -- Make a first graph with the parsed nodes
  -- TODO: what should the inputs be?
  cg' <- traceHint ("loadGraph: cg'=") $ tryEither $ buildCGraphFromList vertices edges [] requestedIds
  -- Transform this graph to load the content of the nodes.
  cg <- traceHint ("loadGraph: cg=") $ computeGraphMapVertices cg' (_buildNode reg)
  return cg

data ParsedNode = ParsedNode {
  pnLocality :: !Locality,
  pnPath :: !NodePath,
  pnOpName :: !Text,
  pnExtra :: !OpExtra,
  pnParents :: ![NodePath],
  pnDeps :: ![NodePath],
  pnType :: !(Maybe DataType)
} deriving (Show)

instance FromProto PG.Node ParsedNode where
  fromProto pn = do
    p <- extractMaybe' pn PG.maybe'path "path"
    extra <- extractMaybe' pn PG.maybe'opExtra "op_extra"
    parents' <- sequence $ fromProto <$> (pn ^. PG.parents)
    deps <- sequence $ fromProto <$> (pn ^. PG.logicalDependencies)
    dt <- case pn ^. PG.maybe'inferedType of
      Nothing -> pure Nothing
      _ ->
        pure <$> extractMaybe' pn PG.maybe'inferedType "infered_type"
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

_transform :: CompilerConf -> PAI.PerformGraphTransform -> Try PAI.GraphTransformResponse
_transform conf pgt = do
  g <- extractMaybe pgt PAI.maybe'functionalGraph "functional_graph"
  let paths = pgt ^. PAI.requestedPaths
  nm <- traceHint ("_transform: nm=") $ _buildMap $ pgt ^. PAI.availableNodes
  cg <- traceHint ("_transform: cg=") $ loadGraph nodeRegistry g paths
  -- TODO add the resource list eventually.
  let trans = traceHint ("_transform: trans=") $ performTransform conf nm [] cg
  return $ traceHint ("_transform: res=") $ case trans of
    Left err -> toProto err
    Right suc -> toProto suc

_buildMap :: [PAI.NodeMapItem] -> Try NodeMap
_buildMap l = do
  l' <- sequence $ fromProto <$> l
  return $ myGroupBy l'

_buildNode :: NodeBuilderRegistry -> ParsedNode -> [(OperatorNode, StructureEdge)] -> Try OperatorNode
_buildNode reg pn l = do
  nb <- case reg `registryNode` pnOpName ((traceHint "_buildNode: pn=") pn) of
    Nothing -> tryError $ sformat ("_buildNode: could not find op name '"%sh%"' in the registry") (pnOpName pn)
    Just nb' -> pure nb'
  let shapes = fmap (onShape . fst) . filter ((ParentEdge==) . snd) $ l
  cni <- traceHint "_buildNode: cni=" $ nbBuilder nb (pnExtra pn) shapes
  let c = NodeContext {
        ncParents = f ParentEdge,
        ncLogicalDeps = f LogicalEdge
      } where f et = fmap fst . filter ((et==) . snd) $ l
  return $ buildOpNode cni (pnPath pn) c
