{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}

{-| A set of utility functions to build and transform DAGs.

Because I could not find a public library for such transforms.

Most Karps manipulations are converted into graph manipulations.
-}
module Spark.Core.Internal.DAGFunctions(
  FilterOp(..),
  -- Building
  buildGraph,
  buildVertexList,
  buildGraphFromList,
  buildGraphFromList',
  -- Queries
  graphSinks,
  graphSources,
  -- Transforms
  graphMapVertices,
  graphMapVertices',
  graphMapVerticesI,
  graphAdd,
  vertexMap,
  -- graphFlatMapEdges,
  graphMapEdges,
  reverseGraph,
  verticesAndEdges,
  graphFilterVertices,
  -- pruneLexicographic,
  completeVertices,
  graphFilterEdges
) where

import qualified Data.Set as S
import qualified Data.Map.Strict as M
import qualified Data.Vector as V
import qualified Data.List.NonEmpty as N
import Data.List(sortBy)
import Data.Function(on)
import Data.Maybe
import Data.Foldable(toList)
import Control.Arrow((&&&))
import Control.Monad.Except
import Formatting
import Control.Monad.Identity

import Spark.Core.Internal.DAGStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Try

{-| The different filter modes when pruning a graph.

Keep: keep the current node.
CutChildren: keep the current node, but do not consider the children.
Remove: remove the current node, do not consider the children.
-}
data FilterOp = Keep | Remove | CutChildren

{-| Builds a graph from a list of vertices and edges. The edges and vertices
need not be sorted or correct, it will be checked.
All indices have to be distinct at each node, but they need not be consecutive.

They are updated to be consecutive at the outcome.
-}
buildGraphFromList' :: forall v e. (HasCallStack, Show v, Show e) =>
  [Vertex v] -> [IndexedEdge e] -> DagTry (Graph v e)
buildGraphFromList' vxs ies = do
    -- Verify and compact the indices.
    ies' <- _reindexEdges ies
    -- Build the vertex map and check for duplicates.
    vxById <- _vertexById vxs
    -- Check that the edge vertex ids match the list of given vertices.
    edgeMap' <- sequence $ edgeMap vxById <$> ies'
    let edgeMap0 = M.map N.toList (myGroupBy edgeMap')
    -- Merge the edge information with the sequence of vertices.
    -- This way, we keep the order of the vertices when building the graph.
    let vxs' = mergeWithEdge edgeMap0 <$> vxs
    let indexedVxs = [(idx, vx, l) | (idx, (vx, l)) <- _zipWithIndex vxs']
    lexico' <- _lexicographic vertexId indexedVxs
    return $ _buildGraphFromListUnsafe lexico' ies'
  where
    -- The id of the first vertex and then the second vertex.
    edgeMap :: M.Map VertexId (Vertex v) -> IndexedEdge e -> DagTry (VertexId, Vertex v)
    edgeMap m ie = case (M.lookup (iedgeFrom ie) m, M.lookup (iedgeTo ie) m) of
      (Just v1, Just v2) -> pure (vertexId v1, v2)
      _ -> throwError' $ "Edge has vertices not present in the list of vertices: " <> show' ()
    mergeWithEdge :: M.Map VertexId [Vertex v] -> Vertex v -> (Vertex v, [Vertex v])
    mergeWithEdge m v = case M.lookup (vertexId v) m of
        Nothing -> (v, [])
        Just l -> (v, l)

{-| Reindexs the edges to make sure that the indexes of each element make
a compact segment. Also checks that all the indices are distinct for each
sink and output.
-}
_reindexEdges :: forall e. (HasCallStack, Show e) => [IndexedEdge e] -> DagTry [IndexedEdge e]
_reindexEdges l = do
  l1 <- _doPass iedgeFrom iedgeFromIndex (\ie idx -> ie {iedgeFromIndex = idx}) l
  l2 <- _doPass iedgeTo iedgeToIndex (\ie idx -> ie {iedgeToIndex = idx}) l1
  return l2

    -- Group edges by start vertex
_doPass :: forall e. (HasCallStack, Show e) =>
  (IndexedEdge e -> VertexId) -> -- The grouping vertex
  (IndexedEdge e -> Int) -> -- The slot to compact
  (IndexedEdge e -> Int -> IndexedEdge e) -> -- The update of the slot.
  [IndexedEdge e] -> -- The list to manipulate
  DagTry [IndexedEdge e]
_doPass getVertexId getSlot updateSlot l = l2t where
  -- Sorts by the first int, checks that there is no duplicate
  reorganize :: [(Int, Int, IndexedEdge e)] -> DagTry [(Int, IndexedEdge e)]
  reorganize l' =
    let getIdx (idx, _, _) = idx
        f2 (_, pos, ie) = (pos, ie)
        s = S.fromList (getIdx <$> l')
    in if length s == length l'
        then pure $ f2 <$> sortBy (compare `on` getIdx) l'
        else throwError' $ "_reindexEdges: Duplicate positions in " <> show' l' <> " with l=" <> show' l
  -- If we succeed, we need to return the edges in the same order.
  -- Associate them with an index.
  lIdx = _zipWithIndex l
  -- First index is slot, second is pos.
  m1 :: [[(Int, Int, IndexedEdge e)]]
  m1 = fmap N.toList . M.elems . myGroupBy $ f <$> lIdx where
    f (pos, ie) = (getVertexId ie, (getSlot ie, pos, ie))
  m1t = sequence $ reorganize <$> m1
  l1t = concatMap f <$> m1t where
    f l0 = g <$> _zipWithIndex l0 where
      g (newFromIdx, (pos, ie)) = (pos, updateSlot ie newFromIdx)
  l2t = (fmap snd . sortBy (compare `on` fst)) <$> l1t

{-| Starts from a vertex and expands the vertex to reach all the transitive
closure of the vertex.

Returns a list in lexicographic order of dependencies: the graph corresponding
to this list of elements has one sink (the start element) and potentially
multiple sources. The nodes are ordered so that all the parents are visited
before the node itself.
-}
buildVertexList :: (GraphVertexOperations v, Show v) => v -> DagTry [v]
buildVertexList x = _lexicographic vertexToId traversals where
  traversals = toList $ _buildList S.empty [x] M.empty

-- | Builds a graph by expanding a start vertex.
buildGraph :: forall v e. (GraphOperations v e, Show v, Show e) =>
  v -> DagTry (Graph v e)
buildGraph start = do
    vxs <- buildVertexList start
    iedges <- edgeList vxs
    buildGraphFromList' (f <$> vxs) iedges
  where
    f v = Vertex (vertexToId v) v
    edgeList1 :: v -> [IndexedEdge e]
    edgeList1 vx = g <$> expandVertex vx where
      vidFrom = vertexToId vx
      g (e, vTo) = IndexedEdge {
              iedgeFromIndex = -1,
              iedgeFrom = vidFrom,
              iedgeToIndex = -1,
              iedgeTo = vertexToId vTo,
              iedgeData = e
            }
    -- Give a unique index for each slot at the end.
    edgeList vxs = pure . fmap g . _zipWithIndex . concat $ edgeList1 <$> vxs where
      g (idx, ie) = ie { iedgeFromIndex = idx, iedgeToIndex = idx }

{-| Attempts to build a graph from a collection of vertices and edges.

This collection may be invalid (cycles, etc.) and the vertices need not
be in topological order.

All the vertices referred by edges must be present in the list of vertices.
-}
buildGraphFromList :: forall v e. (Show e, Show v) =>
  [Vertex v] -> [Edge e] -> DagTry (Graph v e)
buildGraphFromList vxs eds =
  buildGraphFromList' vxs eds' where
    eds' = f <$> _zipWithIndex eds where
      f (idx, e) = _indexEdge idx e

{-| This function builds the graph but does not check crucial elements such as
the absence of loops.

It should be used only when the graph is 'known to be correct'.
-}
_buildGraphFromListUnsafe :: forall v e.
  [Vertex v] -> [IndexedEdge e] -> Graph v e
_buildGraphFromListUnsafe vxs ieds = Graph adjMap (V.fromList vxs) where
  gs = myGroupBy $ f <$> ieds where
    f ied = (iedgeFrom ied, ied)
  adjMap = M.map f gs where
    f (h :| t) = f' <$> l where
      -- IMPORTANT: do not forget to reorganize the vertices in order of
      -- indices, we rely on it for the completion of algorithms.
      l = sortBy (compare `on` iedgeFromIndex) (h : t)
      f' ied = (iedgeData ied, iedgeTo ied, iedgeToIndex ied)

_vertexById :: (Show v) => [Vertex v] -> DagTry (M.Map VertexId (Vertex v))
_vertexById vxs =
  -- This is probably not the most pretty, but it works.
  let vxById = M.map N.toList $ myGroupBy $ (vertexId &&& id) <$> vxs
      f (vid, [vx]) = pure (vid, vx)
      f (vid, l) = throwError $ sformat ("_VertexById: Multiple vertices with the same id: "%sh%" in "%sh) vid l
  in M.fromList <$> sequence (f <$> M.toList vxById)

-- This implementation is not very efficient and is probably a performance
-- bottleneck.
-- Int is the traversal order. It is just used to break the ties.
-- VertexId is the node id of the vertex.
_lexicographic :: (v -> VertexId) -> [(Int, v, [v])] -> DagTry [v]
_lexicographic _ [] = return []
_lexicographic f m =
  -- We use the traversal ordering to separate the ties.
  -- The first nodes traversed get priority.
  let fcmp (idx, _, []) (idx', _, []) = compare idx idx'
      fcmp (_, _, []) (_, _, _) = LT
      fcmp (_, _, _) (_, _, []) = GT
      fcmp (_, _, _) (_, _, _) = EQ -- This one does not matter
  in case sortBy fcmp m of
    [] -> throwError "_lexicographic: there is a cycle"
    ((_, v, _) : t) ->
      let currentId = f v
          removeCurrentId l = [v' | v' <- l, f v' /= currentId]
          m' = t <&> \(idx, v', l) -> (idx, v', removeCurrentId l)
          tl = _lexicographic f m'
      in (v :) <$> tl

_indexEdge :: Int -> Edge e -> IndexedEdge e
_indexEdge idx e = IndexedEdge {
        iedgeFromIndex = idx,
        iedgeFrom = edgeFrom e,
        iedgeToIndex = idx,
        iedgeTo = edgeTo e,
        iedgeData = edgeData e
      }

_zipWithIndex :: [a] -> [(Int, a)]
_zipWithIndex = zip [0..]

_buildList :: (Show v, GraphVertexOperations v) =>
  S.Set VertexId -> -- boundary ids, they will not be traversed
  [v] -> -- fringe ids
  M.Map VertexId (Int, v, [v]) -> -- all seen ids so far (the intermediate result)
  M.Map VertexId (Int, v, [v])
_buildList boundary fringe =
  _buildListGeneral boundary fringe expandVertexAsVertices

-- (internal)
-- Gathers the list of all the nodes connected through this graph
--
-- The expansion function in that case can be controlled.
--
-- The expansion is done in a DFS manner (the order of the node is unique).
_buildListGeneral :: (Show v, GraphVertexOperations v) =>
  S.Set VertexId -> -- boundary ids, they will not be traversed
  [v] -> -- fringe ids: the nodes that have been touched but not expanded.
  (v -> [v]) -> -- The expansion function. They will be the next nodes to expand.
  -- all seen ids so far (the intermediate result)
  -- along with the index of the node during the traversal, and the
  -- node itself.
  M.Map VertexId (Int, v, [v]) ->
  M.Map VertexId (Int, v, [v])
_buildListGeneral _ [] _ allSeen = allSeen
_buildListGeneral boundaryIds (x : t) expand allSeen =
  let vid = vertexToId x in
  if M.member vid allSeen || S.member vid boundaryIds then
    _buildListGeneral boundaryIds t expand allSeen
  else
    let nextVertices = expand x
        currIdx = M.size allSeen
        allSeen2 = M.insert vid (currIdx, x, nextVertices) allSeen
        filterFun y = not $ M.member (vertexToId y) allSeen2
        nextVertices2 = filter filterFun nextVertices
    in _buildListGeneral boundaryIds (nextVertices2 ++ t) expand allSeen2

{-| The sources of a DAG (nodes with no parent).
-}
graphSources :: Graph v e -> [Vertex v]
graphSources g =
  let hasParent = do
        vedges <- toList (gEdges g)
        edge <- toList vedges
        return . vertexId . veEndVertex $ edge
      hasPSet = S.fromList hasParent
      -- false iff the vertex has an incoming edge
      filt vx = not (S.member (vertexId vx) hasPSet)
  in filter filt (toList (gVertices g))

{-| The sinks of a graph (nodes with no descendant).
-}
graphSinks :: Graph v e -> [Vertex v]
graphSinks g =
  let f vx = V.null (M.findWithDefault V.empty (vertexId vx) (gEdges g))
  in filter f (toList (gVertices g))

-- | Flips the edges of this graph (it is also a DAG)
reverseGraph :: forall v e. (Show e, Show v) => Graph v e -> Graph v e
-- For safety, fully rebuild the graph from scratch.
reverseGraph g = forceRight . tryEither $ buildGraphFromList' vxs ieds where
  vxs = V.toList (gVertices g)
  ieds = f <$> gIndexedEdges g where
    f ie = IndexedEdge {
          iedgeFromIndex = iedgeToIndex ie,
          iedgeFrom = iedgeTo ie,
          iedgeToIndex = iedgeFromIndex ie,
          iedgeTo = iedgeFrom ie,
          iedgeData = iedgeData ie
        }

-- | A generic transform over the graph that may account for potential failures
-- in the process.
graphMapVertices :: forall m v e v2. (HasCallStack, Show v2, Monad m) =>
  Graph v e -> -- The start graph
  (v -> [(v2,e)] -> m v2) -> -- The transform
  m (Graph v2 e)
graphMapVertices g f =
  let
    fun :: M.Map VertexId v2 -> [Vertex v] -> m [Vertex v2]
    fun _ [] = return []
    fun done (vx : t) =
      let
        vid = vertexId vx
        parents = V.toList $ fromMaybe V.empty $ M.lookup vid (gEdges g)
        parentEdges = veEdge <$> parents
        getPairs :: Edge e -> (v2, e)
        getPairs ed =
          let vidTo = edgeTo ed
              msg = sformat ("graphMapVertices: Could not locate "%shown%" in "%shown)vidTo done
              -- The edges are flowing from child -> parent so
              -- to == parent
              vert = fromMaybe (failure msg) (M.lookup vidTo done)
            in (vert, edgeData ed)
        parents2 = [getPairs ed | ed <- parentEdges]
        -- parents2 = [fromJust $ M.lookup vidFrom done | vidFrom <- parentVids]
        merge0 :: v2 -> m [Vertex v2]
        merge0 vx2Data =
          let done2 = M.insert vid vx2Data done
              vx2 = vx { vertexData = vx2Data }
              rest = fun done2 t in
            (vx2 : ) <$> rest
      in
        f (vertexData vx) parents2 >>= merge0
  in do
    verts2 <- fun M.empty (toList (gVertices g))
    return g { _gVertices = V.fromList verts2 }
    -- let
    --   -- idxs2 = M.fromList [(vertexId vx2, vx2) | vx2 <- verts2]
    --   -- trans :: Vertex v -> Vertex v2
    --   -- trans vx = fromJust $ M.lookup (vertexId vx) idxs2
    --   -- conv :: VertexEdge e v -> VertexEdge e v2
    --   -- conv (VertexEdge vx1 e1) = VertexEdge (trans vx1) e1
    --   -- adj2 = M.map (conv <$>) (gEdges g)
    -- return

{-| Maps the graph, taking the edges into account.

This is the non-monadic version of graphMapVertices.
-}
graphMapVerticesI :: forall v e v2. (HasCallStack, Show v2) =>
  Graph v e -> -- The start graph
  (v -> [(v2,e)] -> v2) -> -- The transform
  Graph v2 e
graphMapVerticesI g f = runIdentity (graphMapVertices g f') where
  f' x l = pure (f x l)

{-| Attempts to add some extra edges and vertices to the graph.

Here are the rules:
 - new edges on existing nodes: new ones are appended to the list of parents.

No cycle are allowed.
-}
graphAdd :: forall v e. (Show e, Show v) =>
  Graph v e -> -- The start graph
  [Vertex v] -> -- The vertices to add
  [Edge e] -> -- The edges to add
  DagTry (Graph v e)
graphAdd g vs es = buildGraphFromList' (oldVs ++ vs) (oldEs ++ ies)
  where
    oldVs = V.toList (gVertices g)
    oldEs = gIndexedEdges g
    numOldEs = length oldEs
    -- The indexes are starting after everything else so that there is no
    -- collision and so that the edges get added at the end.
    ies = uncurry _indexEdge <$> zip [numOldEs..] es

{-| Filters the edges, taking into account the values of the origin and
destination vertices too.

-}
graphFilterEdges :: forall v e e'. (HasCallStack, Show v, Show e') =>
  Graph v e -> -- The start DAG
  (v -> e -> v -> Maybe e') -> -- The filtering function: vertex from -> edge -> vertex to -> maybe a new edge data
  Graph v e'
-- This transform should always work.
graphFilterEdges g f = forceTry . tryEither $ (buildGraphFromList' vs =<< iest) where
  -- The vertices are the same.
  vs = V.toList (gVertices g)
  indexed = M.fromList $ f' <$> vs where
    f' v = (vertexId v, vertexData v)
  -- This function is unsafe because it should work by construction
  lookup' :: VertexId -> DagTry v
  lookup' vid = case vid `M.lookup` indexed of
    Just x -> pure x
    Nothing -> throwError' $ "graphFilterEdges: construction failure: could not find vertex id " <> show' vid
  iest = fmap catMaybes . sequence $ f' <$> gIndexedEdges g where
    f' ie = do
      xFrom <- lookup' (iedgeFrom ie)
      xTo <- lookup' (iedgeTo ie)
      return $ (\e' -> ie { iedgeData = e' }) <$> f xFrom (iedgeData ie) xTo


-- | (internal) Maps the edges
graphMapEdges :: Graph v e -> (e -> e') -> Graph v e'
graphMapEdges g f = g { _gAdjMap = m' } where
  m' = M.map (f' <$> ) (_gAdjMap g) where
    f' (e, vidTo, idxTo) = (f e, vidTo, idxTo)

-- | (internal) Maps the vertices.
graphMapVertices' :: (Show v, Show e, Show v') => (v -> v') -> Graph v e -> Graph v' e
graphMapVertices' f g =
  runIdentity (graphMapVertices g f') where
    f' v _ = return $ f v

{-| Given a graph, prunes out a subset of vertices.

All the corresponding edges and the unreachable chunks of the graph are removed.
-}
graphFilterVertices :: (Show v, Show e) =>
  (v -> FilterOp) -> Graph v e -> Graph v e
graphFilterVertices f g = forceRight . tryEither $ buildGraphFromList' vxs eds where
  g' = graphMapVerticesI g (_transFilter f)
  vxs = mapMaybe _filt (V.toList (gVertices g'))
  keptIds = S.fromList $ vertexId <$> vxs
  eds = filter f' (gIndexedEdges g') where
    f' ie = S.member (iedgeFrom ie) keptIds && S.member (iedgeTo ie) keptIds


-- | The map of vertices, by vertex id.
vertexMap :: Graph v e -> M.Map VertexId v
vertexMap g =
  M.fromList . toList $ gVertices g <&> (vertexId &&& vertexData)

-- (internal)
-- The vertices in lexicographic order, and the originating edges for these
-- vertices.
verticesAndEdges :: Graph v e -> [([(v, e)],v)]
verticesAndEdges g =
  toList (gVertices g) <&> \vx ->
    let n = vertexData vx
        l = V.toList $ M.findWithDefault V.empty (vertexId vx) (gEdges g)
        lres = [(vertexData vx', edgeData e') | (VertexEdge vx' e') <- l]
    in (lres, n)

-- {-| Given a list of elements with vertex/edge information and a start vertex,
-- builds the graph from all the reachable vertices in the list.
--
-- It returns the vertices in a DAG traversal order.
--
-- Note that this function is robust and silently drops the missing vertices.
-- -}
-- pruneLexicographic :: VertexId -> [(VertexId, [VertexId], a)] -> [a]
-- pruneLexicographic hvid l =
--   let f (vid, l', a) = (vid, (l', a))
--       allVertices = myGroupBy (f <$> l)
--       allVertices' = M.map N.head allVertices
--   in reverse $ _pruneLexicographic allVertices' S.empty [hvid]

{-| Makes the vertex information (including node id) available as part of the
vertex data.
-}
completeVertices :: forall e v. Graph v e -> Graph (Vertex v) e
completeVertices g = g { _gVertices = v } where -- Graph edges vertices where
  f1 vx = vx {vertexData=vx}
  v = f1 <$> gVertices g

-- Recursive traversal of the graph, dropping everything that looks suspiscious.
_pruneLexicographic ::
  M.Map VertexId ([VertexId], a) -> -- The complete topology
  S.Set VertexId -> -- The set of visited vertices
  [VertexId] -> -- The fringe to visit
  [a]
_pruneLexicographic _ _ [] = []
_pruneLexicographic vertices visited (hvid : t) =
  if S.member hvid visited
  then _pruneLexicographic vertices visited t
  else case M.lookup hvid vertices of
    Just (l, x) ->
      x : _pruneLexicographic vertices (S.insert hvid visited) (l ++ t)
    Nothing ->
      _pruneLexicographic vertices visited t

_transFilter :: (v -> FilterOp) -> v -> [(FilterVertex v, e)] -> FilterVertex v
_transFilter filt vx l =
  let f (KeepVertex _, _) = True
      f (DropChildren _, _) = False
      f (RemoveVertex _, _) = False
      -- If the current node is reachable:
      -- If the node has no child, we do not make checks on the parents.
      -- (it is considered to be reachable)
      reachableChildren = null l || or (f <$> l)
  in if reachableChildren
      then case filt vx of
          Keep -> KeepVertex vx
          CutChildren -> DropChildren vx
          Remove -> RemoveVertex vx
      -- The node is unreachable, just drop
     else RemoveVertex vx

_filt :: Vertex (FilterVertex v) -> Maybe (Vertex v)
_filt (Vertex vid (KeepVertex v)) = Just (Vertex vid v)
_filt (Vertex vid (DropChildren v)) = Just (Vertex vid v)
_filt (Vertex _ (RemoveVertex _)) = Nothing


_filtEdge :: S.Set VertexId -> VertexId -> V.Vector (VertexEdge e v) -> Maybe (V.Vector (VertexEdge e v))
-- The start vertex has been pruned out.
_filtEdge s vid _ | not (S.member vid s) = Nothing
_filtEdge s _ v =
  let f ve = S.member (vertexId . veEndVertex $ ve) s
      v' = V.filter f v
  in if V.null v'
     then Nothing
     else Just v'

data FilterVertex v = KeepVertex !v | DropChildren !v | RemoveVertex !v deriving (Show)
