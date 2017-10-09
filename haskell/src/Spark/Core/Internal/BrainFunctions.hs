{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TupleSections #-}
{-# OPTIONS_GHC -fno-warn-orphans #-} -- not sure if this is a good idea.

{-| This file is the major entry point for the Karps compiler.

This part of the computation is stateless and does not depend on the
DSL or on the server.
-}
module Spark.Core.Internal.BrainFunctions(
  TransformReturn,
  performTransform) where

import qualified Data.Map.Strict as M
import qualified Data.List.NonEmpty as N
import qualified Data.Text as T
import qualified Data.Vector as V
import qualified Data.Set as S
import Data.List(elemIndex)
import Data.Maybe(catMaybes)
import Data.Default
import Formatting
import GHC.Stack(prettyCallStack)
import Lens.Family2((&), (.~))

import Spark.Core.Internal.BrainStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Internal.ComputeDag
import Spark.Core.Internal.DatasetStd(localityToProto)
import Spark.Core.Internal.DAGStructures
import Spark.Core.Internal.DatasetFunctions(buildOpNode', filterParentNodes)
import Spark.Core.Internal.OpFunctions(simpleShowOp, extraNodeOpData)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.Caching(opnameAutocache)
import Spark.Core.Internal.DatasetStructures(StructureEdge(..), OperatorNode(..), onLocality, onType, onOp, onShape)
import Spark.Core.Internal.Display(displayGraph)
import Spark.Core.InternalStd.Observable(localPackBuilder)
import Spark.Core.Internal.TypesFunctions(structTypeTuple')
import Spark.Core.StructuresInternal(NodeId, NodePath, FieldName(..), FieldPath(..), nodePathAppendSuffix, emptyFieldPath, fieldPath', unsafeFieldName, emptyNodeId)
import Spark.Core.Internal.StructuredFlattening
import Spark.Core.Try
import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.ApiInternal as PAI


type TransformReturn = Either GraphTransformFailure GraphTransformSuccess

{-| The main function that calls mos of the functions in the background.

This function adopts the nanopass design, in which each step performs at most
a couple of graph traversals (typically one).

For a list of all the steps done, look at the list of the steps in api_internal.proto
-}
performTransform ::
  CompilerConf ->
  NodeMap ->
  ResourceList ->
  ComputeGraph ->
  TransformReturn
performTransform conf cache resources = _transform phases where
  _m f x = if f conf then Just x else Nothing
  phases = catMaybes [
    _m ccUseNodePruning (PAI.REMOVE_UNREACHABLE, transPruneGraph),
    pure (PAI.REMOVE_OBSERVABLE_BROADCASTS, removeObservableBroadcasts),
    pure (PAI.MERGE_PREAGG_AGGREGATIONS, mergePreStructuredAggregators),
    pure (PAI.MERGE_AGGREGATIONS, mergeStructuredAggregators),
    pure (PAI.DATA_SOURCE_INSERTION, transInsertResource resources),
    pure (PAI.POINTER_SWAP_1, transSwapCache cache),
    -- TODO: the flattening should be split into smaller passes:
    {- The following passes should be done:
     - basic structural checks for the functions
     - scoping analysis: all the functional units are self contained
     - recursive optimization of the functional units (merge what can be merged)
     - do the flattening.
     - remove identity nodes.
    -}
    pure (PAI.FUNCTIONAL_FLATTENING, structuredFlatten),
    -- TODO: this is another pass.
    pure (PAI.AUTOCACHE_FULLFILL, removeAutocache),
    pure (PAI.FINAL, pure)
    ]


_transform :: [(PAI.CompilingPhase, ComputeGraph -> Try ComputeGraph)] -> ComputeGraph -> TransformReturn
_transform l cg = f l [(PAI.INITIAL, cg)] cg where
  f :: [(PAI.CompilingPhase, ComputeGraph -> Try ComputeGraph)] -> [(PAI.CompilingPhase, ComputeGraph)] -> ComputeGraph -> TransformReturn
  f [] [] _ = error "should not have zero phase"
  f [] l' cg' = Right $ GraphTransformSuccess cg' M.empty (reverse l')
  f ((phase, fun):t) l' cg' =
    case fun cg' of
      Right cg2 ->
        -- Success at applying this phase, moving on to the next one.
        f t l2 cg2 where l2 = (phase, cg2) : l'
      Left err ->
        -- This phase failed, we stop here.
        Left $ GraphTransformFailure err (reverse l')


transSwapCache :: NodeMap -> ComputeGraph -> Try ComputeGraph
transSwapCache _ = pure

transInsertResource :: ResourceList -> ComputeGraph -> Try ComputeGraph
transInsertResource _ = pure

transPruneGraph :: ComputeGraph -> Try ComputeGraph
transPruneGraph = pure

-- transFillAutoCache :: ComputeGraph -> Try ComputeGraph
-- transFillAutoCache = pure

data MergeAggTrans =
    MATNormal OperatorNode -- A normal node
  | MATAgg OperatorNode AggOp -- A node that contains a structured aggregation.
  | MATSingle OperatorNode -- A node that leads to a single aggregation
  | MATMulti OperatorNode OperatorNode [NodePath] -- A node that fans out in multiple aggregations
  deriving (Show)

{-| Merges structured aggregators together.
-}
mergeStructuredAggregators :: ComputeGraph -> Try ComputeGraph
mergeStructuredAggregators cg = do
    cg1 <- cg1t
    let cg2 = computeGraphMapVerticesI cg1 $ \mat _ -> opNode mat
    cg3 <- tryEither $ graphAdd cg2 (extraVxs cg1) (extraEdges1 cg1 ++ extraEdges2 cg1)
    let cg4 = graphFilterEdges' cg3 (edgeFilter cg1)
    return cg4
  where
    -- The reverse graph
    rcg = reverseGraph cg
    -- From the descendants, the list of nodes that are aggregators.
    childAggs :: [(MergeAggTrans, StructureEdge)] -> [(OperatorNode, AggOp)]
    childAggs [] = []
    childAggs ((MATAgg on ao, ParentEdge):t) = (on, ao) : childAggs t
    childAggs (_:t) = childAggs t
    -- This graph indicates which nodes are merging material.
    rcg0 = computeGraphMapVerticesI rcg f where
      f on l = case (onOp on, childAggs l) of
        (NodeReduction ao, _) -> MATAgg on ao
        (_, []) -> MATNormal on -- A regular node, no special aggregation
        (_, [_]) -> MATSingle on -- A node that get aggregated by a single op, nothing to do.
        (_, x : t) -> -- A node that gets aggregated more than once -> transform.
          MATMulti on aggOn childPaths where
            aggs = x : t
            aggs' = x :| t
            childPaths = onPath . fst <$> aggs
            childDts = onType . fst <$> aggs'
            -- Build the combined structured aggregate.
            aos = snd <$> aggs
            fnames = f' <$> zip [(1::Int)..] aos where
              f' (idx, _) = unsafeFieldName (sformat ("_"%sh) idx)
            ao = AggStruct . V.fromList $ uncurry AggField <$> zip fnames aos
            dt = structTypeTuple' childDts
            npath = nodePathAppendSuffix (onPath on) "_karps_merged_agg"
            cni = coreNodeInfo dt Local (NodeReduction ao)
            aggOn = OperatorNode emptyNodeId npath cni
    -- Reverse the graph again and this time replace the mergeable aggregators
    -- by the identity nodes.
    g1 = reverseGraph rcg0
    opNode :: MergeAggTrans -> OperatorNode
    opNode (MATSingle on) = on
    opNode (MATNormal on) = on
    opNode (MATAgg on _) = on
    opNode (MATMulti on _ _) = on
    -- This will be a compute graph. This is the base graph before adding
    -- the extra nodes and vertices.
    cg1t = computeGraphMapVertices g1 f' where
      f' (x @ MATSingle {}) _ = pure x
      f' (x @ MATNormal {}) _ = pure x
      f' (x @ MATMulti {}) _ = pure x
      f' (x @ (MATAgg on aggOn)) l = case filterParentNodes l of
        -- This node is the unique aggregation, nothing to do.
        [MATSingle _] -> pure x
        -- This node is one of multiple other aggregations.
        [MATMulti _ _ paths] -> do
            -- Find the index of this node into the paths.
            idx <- tryMaybe (elemIndex (onPath on) paths) "mergeStructuredAggregators: Could not find element"
            -- Account for the 1-based indexing for the fields.
            let co = _extractFromTuple (idx + 1)
            let cni' = coreNodeInfo (onType on) Local (NodeLocalStructuredTransform co)
            let on' = on { onNodeInfo = cni' }
            return $ MATAgg on' aggOn
        l' ->
          -- This is a programming error
          tryError $ sformat ("Expected a single MATMulti node but got "%sh%". This happend whil processing node MatAGG"%sh) (l', l) (on, aggOn)
    -- The extra vertices.
    extraVxs cg' = concatMap f' (graphVertexData cg') where
      f' (MATMulti _ aggOn _) = [nodeAsVertex aggOn]
      f' _ = []
    -- The new edges between the dataset and the composite aggregator
    extraEdges1 cg' = concatMap f' (graphVertexData cg') where
      f' (MATMulti on aggOn _) = [makeParentEdge (onPath on) (onPath aggOn)]
      f' _ = []
    extraEdges2 cg' = concatMap f' (graphVertexData cg') where
      f' (MATMulti _ aggOn ps) = makeParentEdge (onPath aggOn) <$> ps
      f' _ = []
    deletedEdges cg' = S.fromList $ concatMap f' (graphVertexData cg') where
      f' (MATMulti on _ ps) = (,onPath on) <$> ps
      f' _ = []
    edgeFilter cg' onFrom _ onTo =
      not $ S.member (onPath onFrom, onPath onTo) (deletedEdges cg')

{-| Identifies pre-transforms that are done prior to aggregations.

These pretransforms are then merged together.
-}
data MergePreAggTrans =
    MPTNormal OperatorNode -- A normal node
    -- A node that contains a structured aggregation.
    -- TODO: add aggregation, we need to transform it too.
  | MPTAgg OperatorNode AggOp
    -- A structured transform that is the direct parent of an agg.
    -- Arguments:
    --  - the node
    --  - the path to the previous agg node
    --  - the col op performed in this node
    --  - the index of this operation in the fanning node (if any.)
    --    This is filled during the forward pass.
  | MPTPre OperatorNode NodePath ColOp (Maybe Int)
    -- A node that fans out in multiple aggregations.
    -- The paths are (maybe the structured trans, app node)
    -- Some agg nodes may be directly connected to the fan.
    -- First node is the original node, second node is the new combined node.
    -- First list is the paths to the op structures that have been merged
    -- Second list is the list of all the aggregations that are reached from
    -- this fan.
  | MPTFan OperatorNode OperatorNode [NodePath] [NodePath]
  deriving (Show)


{-| Merges structured aggregators together.
-}
mergePreStructuredAggregators :: ComputeGraph -> Try ComputeGraph
mergePreStructuredAggregators cg = do
    cg1 <- cg1t
    let cg2 = computeGraphMapVerticesI cg1 $ \mat _ -> opNode mat
    cg3 <- tryEither $ graphAdd cg2 (extraVxs cg1) (extraEdges1 cg1 ++ extraEdges2 cg1)
    let cg4 = graphFilterEdges' cg3 (edgeFilter cg1)
    let cleaned = pruneUnreachable cg4
    return cleaned
  where
    -- The reverse graph
    rcg = reverseGraph cg
    -- From the descendants, the list of nodes that are aggregation sources.
    -- the node itself, the path to the actual aggregator, the optional column transform.
    childAggs :: [(MergePreAggTrans, StructureEdge)] ->
                 [(OperatorNode, NodePath, Maybe ColOp)]
    childAggs = concatMap f where
      f (MPTAgg on _, ParentEdge) = [(on, onPath on, Nothing)]
      f (MPTPre on np co _, ParentEdge) = [(on, np, Just co)]
      f _ = []
    -- This graph indicates which nodes are merging material.
    rcg0 = computeGraphMapVerticesI rcg f0 where
      f0 on l = traceHint ("mergePreStructuredAggregators:rcg0:on="<>show' on<>" \nmergePreStructuredAggregators:rcg0:l="<>show' l<>"\nmergePreStructuredAggregators:rcg0:res=") (f on l)
      f on l = case (onOp on, childAggs l) of
        (NodeReduction ao, _) -> MPTAgg on ao
        -- A regular node, no special aggregation
        (_, []) -> MPTNormal on
        -- A structured reduction that directly follows an aggregation.
        (NodeStructuredTransform co, [(on', _, Nothing)]) ->
            MPTPre on (onPath on') co Nothing
        -- A node that gets aggregated by a single op, nothing to do.
        (_, [_]) -> MPTNormal on
        -- A node that gets aggregated more than once -> transform.
        (_, x : t) ->
          makeMPTFan on directAggs pres where
            l' = x : t
            directAggs = concatMap f' l' where
              f' (_, aggPath, Nothing) = [aggPath]
              f' _ = []
            pres = concatMap f' l' where
              f' (on', aggPath, Just co) = [(on', aggPath, co)]
              f' _ = []
      makeMPTFan :: OperatorNode -> [NodePath] -> [(OperatorNode, NodePath, ColOp)] -> MergePreAggTrans
      -- That should not happen, but not a problem
      makeMPTFan on [] [] = MPTNormal on
      -- Only direct aggregations. No need to insert a transform.
      makeMPTFan on (_:_) [] = MPTNormal on
      -- Some pre-transforms, and maybe some direct aggregations.
      -- Note that we have lost the ordering, but this is not a problem here.
      makeMPTFan on directAggPaths (x:t) =
        MPTFan on transOn prePaths childAggPaths where
          pres = x : t
          childAggPaths = directAggPaths ++ (f' <$> pres) where
            f' (_, aggPath, _) = aggPath
          prePaths = f' <$> pres where
            f' (on', _, _) = onPath on'
          -- For now, this is not going to be optimal: the structure has a
          -- special _0 field that maps the identity (pass-through field).
          -- Used by the fields that directly call the aggregation.
          -- It can be removed subsequently through analysis.
          colOps = directCo : (f' <$> pres) where
            f' (_, _, co') = co'
            directCo = ColExtraction emptyFieldPath
          -- Note: the indexes are shifted: the first index refers to the
          -- start element.
          fnames = f' <$> zip [(1::Int)..] colOps where
            f' (idx, _) = unsafeFieldName (sformat ("_"%sh) idx)
          co = ColStruct . V.fromList $ uncurry TransformField <$> zip fnames colOps
          childDts = f' <$> pres where f' (parentOn, _, _) = onType parentOn
          dt = structTypeTuple' (onType on :| childDts)
          npath = nodePathAppendSuffix (onPath on) "_ks_aggstruct"
          cni = coreNodeInfo dt Distributed (NodeStructuredTransform co)
          transOn = OperatorNode emptyNodeId npath cni

    -- Reverse the graph again and this time replace the mergeable aggregators
    -- by the identity nodes.
    g1 = reverseGraph rcg0
    opNode :: MergePreAggTrans -> OperatorNode
    opNode (MPTNormal on) = on
    opNode (MPTAgg on _) = on
    opNode (MPTPre on _ _ _) = on
    opNode (MPTFan on _ _ _) = on
    -- This will be a compute graph. This is the base graph before adding
    -- the extra nodes and vertices.
    cg1t = computeGraphMapVertices g1 f' where
      f' x l = f0 x (filterParentNodes l)
      f0 (x @ MPTNormal {}) _ = pure x
      f0 (x @ MPTFan {}) _ = pure x
      -- A pre node that has a single parent, which is a fan.
      -- Look up the index of the node in the combined paths.
      -- This index is then used to rewrite the aggregator extraction.
      f0 (MPTPre on np co _) [MPTFan _ _ combinedPaths _] = do
          idx <- tryMaybe (elemIndex (onPath on) combinedPaths) $ sformat ("mergePreStructuredAggregators: Could not find element "%sh%" in the combined paths "%sh) on combinedPaths
          return $ MPTPre on np co (Just idx)
      -- A pre node for which we could not deduce interesting things after that.
      -- Nothing to do.
      f0 (x @ MPTPre {}) _ = pure x
      -- An aggregator node with a known fan at the top.
      -- This is a direct aggregation, so it should use the first field (_1).
      f0 (MPTAgg on ao) [MPTFan{}] = pure $ MPTAgg on' ao' where
        fn = FieldName "_1"
        ao' = _wrapAgg fn ao
        cni = coreNodeInfo (onType on) Local (NodeReduction ao')
        on' = OperatorNode emptyNodeId (onPath on) cni
      -- An aggregator node with a pre-transform and a known aggregator.
      -- It should refer to one of the other fields (_2...)
      f0 (MPTAgg on ao) [MPTPre _ _ _ (Just idx)] = pure $ MPTAgg on' ao' where
        -- The _1 index is reserved to the id.
        fn = FieldName $ "_"<>show' (idx+2)
        ao' = _wrapAgg fn ao
        cni = coreNodeInfo (onType on) Local (NodeReduction ao')
        on' = OperatorNode emptyNodeId (onPath on) cni
      -- An aggregator node for which we could not infer anything particular
      -- Nothing to do.
      f0 (x @ MPTAgg {}) _ = pure x
    -- The extra vertices (the combined nodes).
    extraVxs cg' = concatMap f' (graphVertexData cg') where
      f' (MPTFan _ combinedOn _ _) = [nodeAsVertex combinedOn]
      f' _ = []
    -- The new edges between the original fanning node and the new combined
    -- transform.
    extraEdges1 cg' = concatMap f' (graphVertexData cg') where
      f' (MPTFan on combinedOn _ _) =
        [makeParentEdge (onPath on) (onPath combinedOn)]
      f' _ = []
    -- The edges between the combined node its descendant aggregators.
    extraEdges2 cg' = concatMap f' (graphVertexData cg') where
      f' (MPTFan _ combinedOn _ aggPaths) =
        makeParentEdge (onPath combinedOn) <$> aggPaths
      f' _ = []
    -- The nodes that get removed: only the nodes for which we could confirm
    -- they were linked to a fan.
    removedNodePaths cg' = S.fromList $ concatMap f' (graphVertexData cg') where
      f' (MPTPre on _ _ (Just _)) = [onPath on]
      f' _ = []
    -- Also remove the direct edges between aggregator nodes and the original
    -- fanning node.
    deletedEdges cg' = S.fromList $ concatMap f' (graphVertexData cg') where
      f' (MPTFan on _ _ aggPaths) = (,onPath on) <$> aggPaths
      f' _ = []
    edgeFilter cg' onFrom _ = f' onFrom where
      s = removedNodePaths cg'
      es = deletedEdges cg'
      f' onFrom' onTo' =
          not ((onPath onFrom', onPath onTo') `S.member` es) &&
          not (onPath onFrom' `S.member` s) &&
          not (onPath onTo' `S.member` s)

{-| Takes an agg and wraps the extraction patterns so that it accesses inside
the group instead of the top-level field path.
-}
_wrapAgg :: FieldName -> AggOp -> AggOp
_wrapAgg fn (AggUdaf ua ucn fp) = AggUdaf ua ucn (_wrapFieldPath fn fp)
_wrapAgg fn (AggFunction sfn fp t) = AggFunction sfn (_wrapFieldPath fn fp) t
_wrapAgg fn' (AggStruct v) = AggStruct (f <$> v) where
  f (AggField fn v') = AggField fn (_wrapAgg fn' v')

_wrapFieldPath :: FieldName -> FieldPath -> FieldPath
_wrapFieldPath fn (FieldPath v) = FieldPath v' where
  v' = V.fromList (fn : V.toList v)


{-| For local transforms, removes the broadcasting references by either
directly pointing to the single input, or packing the inputs and then
refering to the packed inputs.
-}
removeObservableBroadcasts :: ComputeGraph -> Try ComputeGraph
removeObservableBroadcasts cg = do
    -- Look at nodes that contain observable broadcast and make a map of the
    -- input.
    cg2 <- tryEither $ graphAdd cgUpdated extraVertices extraEdges
    let cg3 = graphFilterEdges' cg2 edgeFilter
    return cg3
  where
    -- Replaces broadcast indices by reference to a tuple field.
    replaceIndices :: Bool -> ColOp -> ColOp
    replaceIndices _ (ce @ ColExtraction {}) = ce
    replaceIndices b (ColFunction sqln v t) = ColFunction sqln v' t where
      v' = replaceIndices b <$> v
    replaceIndices _ (cl @ ColLit {}) = cl
    replaceIndices b (ColStruct v) = ColStruct (f <$> v) where
      f (TransformField n val) = TransformField n (replaceIndices b val)
    replaceIndices True (ColBroadcast _) =
      -- TODO: check idx == 0
      ColExtraction emptyFieldPath
    replaceIndices False (ColBroadcast idx) = _extractFromTuple (idx + 1)
    origNode :: LocalPackTrans -> OperatorNode
    origNode (ThroughNode on) = on
    origNode (AddPack on _ _) = on
    cg' :: ComputeDag LocalPackTrans StructureEdge
    cg' = computeGraphMapVerticesI cg f where
      f on l = case onOp on of
        NodeLocalStructuredTransform co -> res where
          singleIndex = length l == 1
          no' = NodeLocalStructuredTransform (replaceIndices singleIndex co)
          cni' = (onNodeInfo on) { cniOp = no' }
          on' = on { onNodeInfo = cni' }
          res = case l of
            -- Just one parent -> no need to insert a pack
            [_] -> ThroughNode on'
            -- Multiple inputs -> need to insert a pack
            _ -> AddPack on' packOn ps where
              ps = onPath . origNode . fst <$> l
              parentOps = f' <$> l where
                f' (lpt, e) = (origNode lpt, e)
              npath = nodePathAppendSuffix (onPath on) "_karps_localpack"
              packOn' = buildOpNode' localPackBuilder emptyExtra npath parentOps
              packOn = forceRight packOn'
        -- Normal node -> let it through
        _ -> ThroughNode on
    -- The graph with the updated structured transforms.
    cgUpdated :: ComputeGraph
    cgUpdated = computeGraphMapVerticesI cg' f where
      f lpt _ = origNode lpt
    extraVertices = concat $ f' <$> graphVertexData cg' where
      f' (ThroughNode _) = []
      f' (AddPack _ packOn _) = [nodeAsVertex packOn]
    -- The edges coming flowing from parents -> local pack
    extraEdges1 = concat $ f' <$> graphVertexData cg' where
      f' (ThroughNode _) = []
      f' (AddPack _ packOn parents) = f'' <$> parents where
        f'' np = makeParentEdge np (onPath packOn)
    -- The edges flowing from pack -> local structure
    extraEdges2 = concatMap f' (graphVertexData cg') where
      f' (ThroughNode _) = []
      f' (AddPack on packOn _) = [makeParentEdge (onPath packOn) (onPath on)]
    extraEdges = extraEdges1 ++ extraEdges2
    deletedEdges = S.fromList $ concatMap f' (graphVertexData cg') where
      f' (AddPack on _ ps) = (onPath on,) <$> ps
      f' _ = []
    edgeFilter onFrom _ onTo =
      not $ S.member (onPath onFrom, onPath onTo) deletedEdges

data LocalPackTrans =
    ThroughNode OperatorNode
    -- node, local pack node, nodes that get merged.
  | AddPack OperatorNode OperatorNode [NodePath] deriving (Eq, Show)


{-| Identifies and removes the autocache nodes that are no-op given the current
graph of computation.

These are the nodes that only have one aggregation to follow.

Should be run after MERGE_AGGREGATIONS, since that pass will merge aggregations
together.
-}
removeAutocache :: ComputeGraph -> Try ComputeGraph
removeAutocache cg = do
    -- Look at nodes that contain observable broadcast and make a map of the
    -- input.
    cg2 <- tryEither $ graphAdd cg [] ac1Edges
    let cg3 = graphFilterEdges' cg2 edgeFilter
    let cg4 = pruneUnreachable cg3
    return cg4
  where
    -- The reverse graph
    rcg = reverseGraph cg
    isAgg on = case onOp on of
      NodeReduction _ -> True
      NodeOpaqueAggregator _ -> True
      -- TODO: how about shuffles? Not sure how the impact the cache.
      _ -> False
    isAutocache on = case onOp on of
      NodeDistributedOp so | soName so == opnameAutocache -> True
      _ -> False
    rcg0 = computeGraphMapVerticesI rcg f where
      f :: OperatorNode -> [(AutocacheRemove, StructureEdge)] -> AutocacheRemove
      f on _ | isAgg on = ACRAggregation (onPath on)
      f on _ | nsLocality (onShape on) == Local = ACRLocal
      f on l | isAutocache on = case filterParentNodes l of
        [ACRAggregation childPath] -> ACRAutocache1 (onPath on) childPath
        [ACRDistributed1 childPath] -> ACRAutocache1 (onPath on) childPath
        _ -> ACRDistributed
      -- If there is a unique parent info, keep it, otherwise it is just a
      -- regular node.
      f on l = case filterParentNodes l of
        [ACRAggregation _] -> ACRDistributed1 (onPath on)
        [ACRDistributed1 _] -> ACRDistributed1 (onPath on)
        [ACRAutocache1 acPath childPath] -> ACRAutoParent1 (onPath on) acPath childPath
        _ -> ACRDistributed
    -- All the node paths that need to be deleted.
    ac1Paths = S.fromList $ concatMap f (graphVertexData rcg0) where
      f (ACRAutoParent1 _ p _) = [p]
      f _ = []
    ac1Edges = concatMap f (graphVertexData rcg0) where
      f (ACRAutoParent1 parentPath _ childPath) = [makeParentEdge parentPath childPath]
      f _ = []
    -- Remove all the references to autocache nodes that we remove.
    -- This should be enough to make it drop from the list of nodes.
    edgeFilter onFrom _ onTo =
      not $ (onPath onFrom `S.member` ac1Paths) || (onPath onTo `S.member` ac1Paths)




data AutocacheRemove =
    ACRLocal -- An observable, nothing to do here.
  | ACRAggregation NodePath -- An aggregation, which would trigger an evaluation
  | ACRDistributed1 NodePath -- A dataframe that is aggregated through 1 aggregator.
  -- An autocache node which has only one descendant DF or aggregator
  -- First path is the path of the current autocache node
  -- Second path is the path of the direct child.
  | ACRAutocache1 NodePath NodePath
  -- The parent of an autocache node that is susceptible to be removed.
  -- This parent should be distributed.
  -- Content is: path of the parent, path of autocache, path of subsequent node.
  | ACRAutoParent1 NodePath NodePath NodePath
  | ACRDistributed -- Just a regular distributed node.
  deriving (Show)

{-| Builds an extractor from a tuple, given the index of the field of the tuple.
Does NOT do off-by-1 corrections. -}
_extractFromTuple :: Int -> ColOp
_extractFromTuple idx = ColExtraction . fieldPath' . (:[]) . unsafeFieldName $ sformat ("_"%sh) idx

_traceGraph :: forall v e. (Show v, Show e) => T.Text -> ComputeDag v e -> ComputeDag v e
_traceGraph txt cg = traceHint (txt <> txt') cg where
  txt1 = V.foldl (<>) "" $ f <$> cdVertices cg where
    f v = "vertex: " <> show' v <> "\n"
  txt2 = foldl (<>) "" $ f <$> M.toList (cdEdges cg) where
    f :: (VertexId, V.Vector (VertexEdge e v)) -> T.Text
    f (k, v) = "edge group: " <> show' k <> " -> " <> V.foldl (<>) "" (f' <$> v) <> "\n" where
        f' :: VertexEdge e v -> T.Text
        f' (VertexEdge (Vertex vid _) (Edge fromId toId x)) = "(" <> show' fromId <> "->"<>show' x<>"->"<>show' toId<>":"<>show' vid<>"), "
  txt' = txt1 <> txt2

-- {-| Exposed for debugging -}
-- updateSourceInfo :: ComputeGraph -> SparkState (Try ComputeGraph)
-- updateSourceInfo cg = do
--   let sources = inputSourcesRead cg
--   if null sources
--   then return (pure cg)
--   else do
--     logDebugN $ "updateSourceInfo: found sources " <> show' sources
--     -- Get the source stamps. Any error at this point is considered fatal.
--     stampsRet <- checkDataStamps sources
--     logDebugN $ "updateSourceInfo: retrieved stamps " <> show' stampsRet
--     let stampst = sequence $ _f <$> stampsRet
--     let cgt = insertSourceInfo cg =<< stampst
--     return cgt


-- _parseStamp :: StampReturn -> Maybe (HdfsPath, Try DataInputStamp)
-- _parseStamp sr = case (stampReturn sr, stampReturnError sr) of
--   (Just s, _) -> pure (HdfsPath (stampReturnPath sr), pure (DataInputStamp s))
--   (Nothing, Just err) -> pure (HdfsPath (stampReturnPath sr), tryError err)
--   _ -> Nothing -- No error being returned for now, we just discard it.

-- ********* INSTANCES ***********

instance ToProto PAI.AnalysisMessage NodeError where
  toProto ne = (def :: PAI.AnalysisMessage)
      & PAI.content .~ eMessage ne
      & PAI.stackTracePretty .~ (T.pack . prettyCallStack . eCallStack $ ne)

instance FromProto PAI.NodeMapItem (NodeId, GlobalPath) where
  fromProto nmi = do
    nid <- extractMaybe' nmi PAI.maybe'node "node"
    np <- extractMaybe' nmi PAI.maybe'path "path"
    cid <- extractMaybe' nmi PAI.maybe'computation "computation"
    sid <- extractMaybe' nmi PAI.maybe'session "session"
    return (nid, GlobalPath sid cid np)

instance ToProto PAI.NodeMapItem (NodeId, GlobalPath) where
  toProto (nid, gp) = (def :: PAI.NodeMapItem)
      & PAI.node .~ toProto nid
      & PAI.path .~ toProto (gpLocalPath gp)
      & PAI.computation .~ toProto (gpComputationId gp)
      & PAI.session .~ toProto (gpSessionId gp)

instance ToProto PAI.CompilerStep (PAI.CompilingPhase, ComputeGraph) where
  toProto (phase, cg) = (def :: PAI.CompilerStep)
      & PAI.phase .~ phase
      & PAI.graph .~ toProto cg
      & PAI.graphDef .~ displayGraph cg

instance ToProto PAI.GraphTransformResponse GraphTransformSuccess where
  toProto gts = (def :: PAI.GraphTransformResponse)
    & PAI.pinnedGraph .~ toProto (gtsNodes gts)
    & PAI.nodeMap .~ (toProto <$> l)
    & PAI.steps .~ (toProto <$> gtsCompilerSteps gts) where
      l' = M.toList . M.map N.toList . gtsNodeMapUpdate $ gts
      l = [(nid, gp) | (nid, gps) <- l', gp <- gps ]

instance ToProto PAI.GraphTransformResponse GraphTransformFailure where
  toProto gtf = (def :: PAI.GraphTransformResponse)
    & PAI.steps .~ (toProto <$> gtfCompilerSteps gtf)
    & PAI.messages .~ [toProto (gtfMessage gtf)]

instance ToProto PG.Graph ComputeGraph where
  toProto cg = (def :: PG.Graph) & PG.nodes .~ l where
    f :: OperatorNode -> [((OperatorNode, PG.Node), StructureEdge)] -> (OperatorNode, PG.Node)
    f on l' = (on, (def :: PG.Node)
                & PG.locality .~ localityToProto (onLocality on)
                & PG.path .~ toProto (onPath on)
                & PG.opName .~ simpleShowOp (onOp on)
                & PG.opExtra .~ toProto (extraNodeOpData (onOp on))
                & PG.parents .~ lparents
                & PG.logicalDependencies .~ ldeps
                & PG.inferedType .~ toProto (onType on)) where
                  f' edgeType = toProto . onPath . fst . fst <$> filter ((edgeType ==) . snd) l'
                  lparents = f' ParentEdge
                  ldeps = f' LogicalEdge
    nodes = computeGraphMapVerticesI cg f
    l = snd <$> graphVertexData nodes
