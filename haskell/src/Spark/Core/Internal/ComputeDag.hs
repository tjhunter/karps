{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}


{-| A data structure that is more oriented towards expressing graphs of
computations.

The difference with a generic DAG lies in the tables of inputs and outputs
of the graph, which express the idea of inputs and outputs.
-}
module Spark.Core.Internal.ComputeDag(
  -- TODO: hide the constructor.
  ComputeDag(cdInputs, cdOutputs),
  cdEdges,
  cdVertices,
  updateGraph,
  buildGraphFromList',
  computeGraphToGraph,
  graphToComputeGraph,
  graphVertexData,
  mapVertices,
  mapVertexData,
  buildCGraph,
  graphDataLexico,
  buildCGraphFromList,
  computeGraphMapVertices,
  computeGraphMapVerticesI,
  graphAdd,
  graphFilterEdges,
  graphFilterEdges',
  reverseGraph,
  pruneUnreachable
) where

import Data.Foldable(toList)
import qualified Data.Set as S
import qualified Data.Map.Strict as M
import qualified Data.Vector as V
import qualified Data.Text as T
import Data.List(any)
import Data.Vector(Vector)
import Control.Arrow((&&&))
import Control.Monad.Except
import Control.Monad.Identity
import Formatting

import qualified Spark.Core.Internal.DAGFunctions as DAG
import Spark.Core.Internal.DAGStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Try

{-| A DAG of computation nodes.

At a high level, it is a total function with a number of inputs and a number
of outputs.

Note about the edges: the edges flow along the path of dependencies:
the inputs are the start points, and the outputs are the end points of the
graph.

-}
-- TODO: hide the constructor
data ComputeDag v e = ComputeDag {
  _cdGraph :: !(Graph v e),
  -- -- The edges that make up the DAG
  -- cdEdges :: !(AdjacencyMap v e),
  -- -- All the vertices of the graph
  -- -- Sorted by lexicographic order + node id for uniqueness
  -- cdVertices :: !(Vector (Vertex v)),
  -- The inputs of the computation graph. These correspond to the
  -- sinks of the dependency graph.
  cdInputs :: !(Vector (Vertex v)),
  -- The outputs of the computation graph. These correspond to the
  -- sources of the dependency graph.
  cdOutputs :: !(Vector (Vertex v))
} deriving (Show)

cdEdges :: ComputeDag v e -> AdjacencyMap v e
cdEdges = gEdges . _cdGraph

cdVertices :: ComputeDag v e -> (Vector (Vertex v))
cdVertices = gVertices . _cdGraph

-- | Conversion
computeGraphToGraph :: ComputeDag v e -> Graph v e
computeGraphToGraph = _cdGraph

reverseGraph :: (Show e, Show v) => ComputeDag v e -> ComputeDag v e
reverseGraph cg =
  cg {
    _cdGraph = DAG.reverseGraph (computeGraphToGraph cg),
    cdInputs = cdOutputs cg,
    cdOutputs = cdInputs cg
  }

-- | Conversion
graphToComputeGraph :: Graph v e -> ComputeDag v e
graphToComputeGraph g =
  ComputeDag {
    _cdGraph = g,
    -- We work on the graph of dependencies (not flows)
    -- The sources correspond to the outputs.
    cdInputs = V.fromList $ DAG.graphSinks g,
    cdOutputs = V.fromList $ DAG.graphSources g
  }

mapVertices :: (Show v', Show v, Show e) => (Vertex v -> v') -> ComputeDag v e -> ComputeDag v' e
mapVertices f cd = ComputeDag {
    _cdGraph = g',
    cdInputs = f' <$> cdInputs cd,
    cdOutputs = f' <$> cdOutputs cd
  } where
    f' vx = vx { vertexData = f vx }
    g' = DAG.graphMapVertices' f (DAG.completeVertices (_cdGraph cd))

mapVertexData :: (Show v, Show v', Show e) => (v -> v') -> ComputeDag v e -> ComputeDag v' e
mapVertexData f = mapVertices (f . vertexData)

{-| Updates the inner graph of a compute graph.
-}
updateGraph :: (Graph v e -> DagTry (Graph v e')) -> ComputeDag v e -> DagTry (ComputeDag v e')
updateGraph f cg = do
  g' <- f (computeGraphToGraph cg)
  -- TODO: check that the inputs and outputs still make sense.
  return $ cg { _cdGraph = g' }

buildCGraph :: (GraphOperations v e, Show v, Show e) =>
  v -> DagTry (ComputeDag v e)
buildCGraph n = graphToComputeGraph <$> DAG.buildGraph n

graphVertexData :: ComputeDag v e -> [v]
graphVertexData cg = vertexData <$> V.toList (cdVertices cg)

graphAdd :: forall v e. (Show e, Show v) =>
  ComputeDag v e -> -- The start graph
  [Vertex v] -> -- The vertices to add
  [Edge e] -> -- The edges to add
  DagTry (ComputeDag v e)
graphAdd cg vxs eds = do
  g' <- DAG.graphAdd (computeGraphToGraph cg) vxs eds
  -- Do not change the sinks and the sources, they should stay the same.
  return cg { _cdGraph = g' }


graphFilterEdges :: (HasCallStack, Show v, Show e') =>
  ComputeDag v e -> -- The start DAG
  (v -> e -> v -> Maybe e') -> -- The filtering function: vertex from -> edge -> vertex to -> should keep
  ComputeDag v e'
graphFilterEdges cg f = cg { _cdGraph = g' } where
    g' = DAG.graphFilterEdges (computeGraphToGraph cg) f

graphFilterEdges' :: (HasCallStack, Show v, Show e) =>
  ComputeDag v e -> -- The start DAG
  (v -> e -> v -> Bool) -> -- The filtering function: vertex from -> edge -> vertex to -> should keep
  ComputeDag v e
graphFilterEdges' cg f = cg { _cdGraph = g' } where
    g' = DAG.graphFilterEdges (computeGraphToGraph cg) f' where
      f' v1 e v2 = if f v1 e v2 then Just e else Nothing

buildGraphFromList' :: forall v e. (Show e, Show v) =>
  [Vertex v] -> -- The vertices
  [IndexedEdge e] -> -- The indexed edges
  [VertexId] -> -- The ids of the inputs
  [VertexId] -> -- The ids of the outputs
  DagTry (ComputeDag v e)
buildGraphFromList' vxs eds inputs outputs = do
    g <- DAG.buildGraphFromList' vxs eds
    inputs' <- sequence $ f <$> V.fromList inputs
    outputs' <- sequence $ f <$> V.fromList outputs
    return ComputeDag {
        _cdGraph = g,
        cdInputs = inputs',
        cdOutputs = outputs'
      }
  where
    vertexById = myGroupBy $ (vertexId &&& id) <$> vxs
    f :: VertexId -> DagTry (Vertex v)
    f vid = case M.lookup vid vertexById of
      Just (vx :| _) -> pure vx
      _ -> throwError $ sformat ("buildCGraphFromList': a vertex id:"%sh%" is not part of the graph.") vid


{-| Builds a compute graph from a list of vertex and edge informations.

If it succeeds, the graph is correct.
-}
buildCGraphFromList :: forall v e. (Show e, Show v) =>
  [Vertex v] -> -- The vertices
  [Edge e] -> -- The edges
  [VertexId] -> -- The ids of the inputs
  [VertexId] -> -- The ids of the outputs
  DagTry (ComputeDag v e)
buildCGraphFromList vxs eds =
  buildGraphFromList' vxs eds' where
    f (idx, e) = IndexedEdge {
          iedgeFromIndex = idx,
          iedgeFrom = edgeFrom e,
          iedgeToIndex = idx,
          iedgeTo = edgeTo e,
          iedgeData = edgeData e
        }
    eds' = f <$> zip [0..] eds

{-| The content of a compute graph, returned in lexicograph order.
-}
graphDataLexico :: ComputeDag v e -> [v]
graphDataLexico cd = vertexData <$> toList (cdVertices cd)


computeGraphMapVertices :: forall m v e v2. (HasCallStack, Show v2, Monad m) =>
  ComputeDag v e -> -- The start graph
  (v -> [(v2,e)] -> m v2) -> -- The transform
  m (ComputeDag v2 e)
computeGraphMapVertices cd fun = do
  let g = computeGraphToGraph cd
  g' <- DAG.graphMapVertices g fun
  let vxs = gVertices g'
  inputs <- _getSubsetVertex vxs (vertexId <$> cdInputs cd)
  outputs <- _getSubsetVertex vxs (vertexId <$> cdOutputs cd)
  return ComputeDag {
    _cdGraph = g',
    cdInputs = inputs,
    cdOutputs = outputs
  }

computeGraphMapVerticesI :: forall v e v2. (HasCallStack, Show v2) =>
  ComputeDag v e ->
  (v -> [(v2, e)] -> v2) ->
  ComputeDag v2 e
computeGraphMapVerticesI cd f = runIdentity $ computeGraphMapVertices cd f' where
  f' v l = pure (f v l)

{-| Removes all the nodes from the graph that do not link to the outputs of
the graph. Keeps the inputs and the outputs in all circumstances.
-}
pruneUnreachable :: forall e v. (Show e, Show v) => ComputeDag v e -> ComputeDag v e
pruneUnreachable cg = forceTry . tryEither $ updateGraph up cg where
  up :: Graph v e -> DagTry (Graph v e)
  up g' = DAG.buildGraphFromList' vxs ies where
    rg' = DAG.reverseGraph (DAG.completeVertices g')
    startSet :: S.Set VertexId -- The vertices to start from
    startSet = S.fromList $ vertexId <$> (V.toList (cdOutputs cg))
    isReachable (PUOutside _ _, _) = False
    isReachable (PUReachable _ _, _) = True
    annotated :: Graph (PUNode v) e
    annotated = DAG.graphMapVerticesI rg' f where
      f :: Vertex v -> [(PUNode v, e)] -> PUNode v
      f (Vertex vid v) _ | vid `S.member` startSet = PUReachable vid v
      f (Vertex vid v) l | any isReachable l = PUReachable vid v
      f (Vertex vid v) _ = PUOutside vid v
    vxs :: [Vertex v]
    vxs = concatMap f (V.toList (gVertices annotated)) where
      f (Vertex _ (PUReachable vid v)) = [Vertex vid v]
      f _ = []
    reachableSet = S.fromList $ vertexId <$> vxs
    ies :: [IndexedEdge e]
    ies = filter f (gIndexedEdges g') where
      f ie = (iedgeFrom ie) `S.member` reachableSet && (iedgeTo ie) `S.member` reachableSet


data PUNode v = PUReachable VertexId v | PUOutside VertexId v deriving (Show)

-- Tries to get a subset of the vertices (by vertex id), and fails if
-- one is missing.
_getSubsetVertex :: forall v m. (Monad m) => Vector (Vertex v) -> Vector VertexId -> m (Vector (Vertex v))
_getSubsetVertex vxs vids =
  let vertexById = myGroupBy $ (vertexId &&& id) <$> V.toList vxs
      f :: VertexId -> m (Vertex v)
      f vid = case M.lookup vid vertexById of
        Just (vx :| _) -> pure vx
        -- A failure here is a construction error of the graph.
        _ -> fail . T.unpack $ sformat ("buildCGraphFromList: a vertex id:"%sh%" is not part of the graph.") vid
  in sequence $ f <$> vids

_mapVerticesAdj :: (Vertex v -> v') -> AdjacencyMap v e -> AdjacencyMap v' e
_mapVerticesAdj f m =
  let f1 ve =
        let vx = veEndVertex ve
            d' = f vx in
          ve { veEndVertex = vx { vertexData = d' } }
      f' v = f1 <$> v
  in M.map f' m
