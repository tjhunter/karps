{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TupleSections #-}

-- Functions to build the graph of computations.
-- The following steps are performed:
--  - typing checking
--  - caching checks
--  - building the final json
--
-- All the functions in this module are pure and use SparkStatePure for transforms.

module Spark.Core.Internal.ContextInternal(
  FinalResult,
  inputSourcesRead,
  -- prepareComputation,
  buildComputationGraph,
  performGraphTransforms,
  getObservables,
  insertSourceInfo,
  updateCache,
  convertToTiedGraph,
  currentCacheNodes,
  compileComputation
) where

import qualified Data.List.NonEmpty as N
import Control.Monad.State(get, put)
import Control.Monad(when)
import Data.Functor.Identity(runIdentity)
import qualified Data.Vector as V
import Data.Text(pack)
import Data.Maybe(mapMaybe, catMaybes)
import Data.Either(isRight)
import Data.Foldable(toList)
import Data.List(nub)
import Formatting
import qualified Data.Map.Strict as M
import qualified Data.HashMap.Strict as HM

import Spark.Core.Dataset
import Spark.Core.Try
import Spark.Core.Row
import Spark.Core.Types
import Spark.Core.Internal.BrainStructures
import Spark.Core.Internal.BrainFunctions
import Spark.Core.StructuresInternal(NodeId, NodePath, ComputationID(..))
import Spark.Core.Internal.Caching
import Spark.Core.Internal.CachingUntyped
import Spark.Core.Internal.ContextStructures
import Spark.Core.Internal.Client
import Spark.Core.Internal.ComputeDag
import Spark.Core.Internal.PathsUntyped
import Spark.Core.Internal.Pruning
import Spark.Core.Internal.OpStructures(NodeShape(..), Locality(..))
-- Required to import the instances.
import Spark.Core.Internal.Paths()
import Spark.Core.Internal.DAGFunctions(buildVertexList, graphMapVertices)
import Spark.Core.Internal.DAGStructures
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.Utilities
import Spark.IO.Internal.InputStructures(extractResourcePath)

-- The result from querying the status of a computation
type FinalResult = Either NodeComputationFailure NodeComputationSuccess


{-| Given a context for the computation, transforms a graph into a
computation that can be executed by the backend.

Increments counters if necessary.
-}
compileComputation ::
  ResourceList ->
  ComputeGraph ->
  SparkStatePure (TransformReturn, Try Computation)
compileComputation resources cg = do
  session <- get
  cache <- currentCacheNodes
  let conf = confCompiler (ssConf session)
  let t = performTransform conf cache resources cg
  -- If the transform is successful, try to convert it to a computation.
  let compt = case t of
        Right gts ->
            -- TODO: this is dropping all extra cache info
            _buildComputation session (gtsNodes gts)
        Left gtf -> Left (gtfMessage gtf)
  when (isRight compt) _increaseCompCounter
  return (t, compt)

{-| Exposed for debugging

Inserts the source information into the graph.

Note: after that, the node IDs may be different. The names and the paths
will be kept though.
-}
-- TODO: move to the compiler
insertSourceInfo :: ComputeGraph -> [(ResourcePath, ResourceStamp)] -> Try ComputeGraph
insertSourceInfo cg l = do
  let m = M.fromList l
  let g = computeGraphToGraph cg
  g2 <- graphMapVertices g (_updateVertex2 m)
  let cg2 = graphToComputeGraph g2
  return cg2

{-| A list of file sources that are being requested by the compute graph -}
-- This function hardcodes the IO nodes.
-- There is currently no way to specify other nodes.
inputSourcesRead :: ComputeGraph -> [ResourcePath]
inputSourcesRead = nub . mapMaybe (extractResourcePath . onOp) . graphVertexData

-- Here are the steps being run
--  - node collection + cycle detection
--  - naming:
--    -> everything after that can be done with names, and on server
--    -> for convenience, the vertex ids will be still the hash ids

currentCacheNodes :: SparkStatePure NodeMap
currentCacheNodes = do
  session <- get
  return . f session . ssNodeCache $ session where
    f s' nc = M.fromList . HM.toList $ HM.mapMaybe g nc where
        g nci | nciStatus nci == NodeCacheSuccess = Just (g' :| []) where
          g' = GlobalPath {
                gpSessionId = ssId s',
                gpComputationId = nciComputation nci,
                gpLocalPath = nciPath nci
              }
        g _ = Nothing

{-| Builds the computation graph by expanding a single node until a transitive
closure is reached.

It performs the naming, node deduplication and cycle detection.

TODO(kps) use the caching information to have a correct fringe
-}
buildComputationGraph :: ComputeNode loc a -> Try ComputeGraph
buildComputationGraph ld = do
  cg <- tryEither $ buildCGraph (untyped ld)
  dagWithPaths <- assignPathsUntyped cg
  _usePathsForIds dagWithPaths
  -- let cg' = mapVertexData nodeOpNode dagWithCorrectIds

{-| Performs all the operations that are done on the compute graph:

- fullfilling autocache requests
- checking the cache/uncache pairs
- pruning of observed successful computations
- deconstructions of the unions (in the future)

This could all be done on the server side at this point.
-}
performGraphTransforms :: SparkSession -> ComputeGraph -> Try ComputeGraph
performGraphTransforms session cg = do
  -- The paths are used as vertex ids, so there is no need to tied the nodes.
  let g = computeGraphToGraph cg
  let conf = ssConf session
  let pruned = if ccUseNodePruning . confCompiler $ conf
               then pruneGraphDefault (ssNodeCache session) g
               else g
  -- Autocache + caching pass pass
  -- TODO: separate in a function
  let tiedPruned = convertToTiedGraph (graphToComputeGraph pruned)
  let acg = fillAutoCache cachingType autocacheGen tiedPruned
  g' <- tryEither acg
  failures <- tryEither $ checkCaching g' cachingType
  case failures of
    [] -> return g'' where
           g'' = _convertToUntiedGraph g'
    _ -> tryError $ sformat ("Found some caching errors: "%sh) failures
  -- TODO: we could add an extra pruning pass here

convertToTiedGraph :: ComputeGraph -> TiedComputeGraph
convertToTiedGraph cg =
  computeGraphToGraph $ runIdentity (computeGraphMapVertices cg f) where
    f on l = return n where
          parents' = fst <$> filter (\(_, e) -> e == ParentEdge) l
          logicalDeps = fst <$> filter (\(_, e) -> e == LogicalEdge) l
          n = nodeFromContext on parents' logicalDeps

{-| Switches the IDs of the graph from node ids to paths (which should be available and computed at that point) -}
-- TODO: it should be able to do all that with just graph traversals.
_usePathsForIds :: ComputeDag UntypedNode StructureEdge -> Try ComputeGraph
_usePathsForIds d = tryEither $
    buildGraphFromList' vxs ieds inputs outputs
  where
    g = computeGraphToGraph d
    -- Collect the ids and the corresponding paths
    m :: M.Map VertexId VertexId
    m = M.map N.head . myGroupBy $ f <$> V.toList (gVertices g) where
        f (Vertex vid n) = (vid, parseNodeId (nodePath n))
    -- This function uses unsafe functions because it should always succeed.
    replaceVid vid = case M.lookup vid m of
        Just vid' -> vid'
        _ -> error' $ "_usePathsForIds: programming error: cannot find id " <> show' vid <> " in map " <> show' m
    changeVertex :: Vertex UntypedNode -> Vertex OperatorNode
    changeVertex vx = Vertex {
          vertexId = parseNodeId . nodePath . vertexData $ vx,
          vertexData = nodeOpNode (vertexData vx)
        }
    vxs = changeVertex <$> V.toList (cdVertices d)
    ieds = f <$> gIndexedEdges g where
      f ie = ie {
        iedgeFrom = replaceVid (iedgeFrom ie),
        iedgeTo = replaceVid (iedgeTo ie)
      }
    inputs :: [VertexId]
    inputs = replaceVid . vertexId <$> V.toList (cdInputs d)
    outputs :: [VertexId]
    outputs = replaceVid . vertexId <$> V.toList (cdOutputs d)

_convertToUntiedGraph :: TiedComputeGraph -> ComputeGraph
_convertToUntiedGraph tcg =
  graphToComputeGraph $ runIdentity (graphMapVertices tcg f) where
    f n _ = pure (nodeOpNode n)


_buildComputation :: SparkSession -> ComputeGraph -> Try Computation
_buildComputation session cg =
  let sid = ssId session
      cid = (ComputationID . pack . show . ssCommandCounter) session
      terminalNodes = vertexData <$> toList (cdOutputs cg)
      terminalNodePaths = onPath <$> terminalNodes
      terminalNodeIds = onId <$> terminalNodes
  -- TODO it is missing the first node here, hoping it is the first one.
  in case terminalNodePaths of
    [p] ->
      return $ Computation sid cid cg [p] p terminalNodeIds
    _ -> tryError $ sformat ("Programming error in _build1: cg="%sh) cg

_updateVertex :: M.Map ResourcePath ResourceStamp -> OperatorNode -> Try OperatorNode
_updateVertex = undefined
  -- let no = onOp un in case hdfsPath no of
  --   Just p -> case M.lookup p m of
  --     Just dis ->
  --       -- TODO this is incorrect, the node ID should not contain dummy
  --       -- information
  --       updateSourceStamp no dis <&> updateOpNodeOp un (NodeContext [] [])
  --     -- TODO: this is for debugging, but it could be eventually relaxed.
  --     Nothing -> tryError $ "_updateVertex: Expected to find path " <> show' p
  --   Nothing -> pure un

_updateVertex2 ::
  M.Map ResourcePath ResourceStamp ->
  OperatorNode ->
  [(OperatorNode, StructureEdge)] ->
  Try OperatorNode
_updateVertex2 m un _ =
  _updateVertex m un

_increaseCompCounter :: SparkStatePure ()
_increaseCompCounter = get >>= \session ->
  let
    curr = ssCommandCounter session
    session2 = session { ssCommandCounter =  curr + 1 }
  in put session2

-- Given an end point, gathers all the nodes reachable from there.
_gatherNodes :: LocalData a -> Try [UntypedNode]
_gatherNodes = tryEither . buildVertexList . untyped

-- Given a result, tries to build the corresponding object out of it
_extract1 :: FinalResult -> DataType -> Try Cell
_extract1 (Left nf) _ = tryError $ sformat ("got an error "%shown) nf
_extract1 (Right ncs) _ = pure $ ncsData ncs

{-| Retrieves all the observables from a computation.
-}
getObservables :: Computation -> [OperatorNode]
getObservables comp = filter f (graphVertexData . cNodes $ comp) where
  f = (Local ==) . nsLocality . onShape

{-| Updates the cache, and returns the updates if there are any.

The updates are split into final results, and general update status (scheduled,
running, etc.)
-}
updateCache :: ComputationID -> [(NodeId, NodePath, NodeShape, PossibleNodeStatus)] -> SparkStatePure ([(NodeId, Try Cell)], [(NodePath, NodeCacheStatus)])
updateCache c l = do
  l' <- sequence $ _updateCache1 c <$> l
  return (catMaybes (fst <$> l'), catMaybes (snd <$> l'))

_updateCache1 :: ComputationID -> (NodeId, NodePath, NodeShape, PossibleNodeStatus) -> SparkStatePure (Maybe (NodeId, Try Cell), Maybe (NodePath, NodeCacheStatus))
_updateCache1 cid (nid, p, ns @ (NodeShape dt _), status) =
  case status of
    (NodeFinishedSuccess (Just s) _) -> do
      updated <- _insertCacheUpdate cid nid p ns NodeCacheSuccess
      let res2 = _extract1 (pure s) dt
      return (Just (nid, res2), (p, ) <$> updated)
    (NodeFinishedFailure e) -> do
      updated <- _insertCacheUpdate cid nid p ns NodeCacheError
      let res2 = _extract1 (Left e) dt
      return (Just (nid, res2), (p, ) <$> updated)
    NodeRunning -> do
      updated <- _insertCacheUpdate cid nid p ns NodeCacheRunning
      return (Nothing, (p, ) <$> updated)
    _ -> return (Nothing, Nothing)

-- Returns true if the cache is updated
_insertCacheUpdate :: ComputationID -> NodeId -> NodePath -> NodeShape -> NodeCacheStatus -> SparkStatePure (Maybe NodeCacheStatus)
_insertCacheUpdate cid nid p ns s = do
  session <- get
  let m = ssNodeCache session
  let currentStatus = nciStatus <$> HM.lookup nid m
  if currentStatus == Just s
  then return Nothing
  else do
    let v = NodeCacheInfo {
              nciStatus = s,
              nciComputation = cid,
              nciPath = p,
              nciShape = ns }
    let m' = HM.insert nid v m
    let session' = session { ssNodeCache = m' }
    put session'
    return $ Just s
