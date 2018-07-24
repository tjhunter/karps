{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{-| Data structures to represent Directed Acyclic Graphs (DAGs).

-}
module Spark.Core.Internal.DAGStructures where

import qualified Data.Map.Strict as M
import qualified Data.Text as T
import qualified Data.List.NonEmpty as N
import qualified Data.Vector as V
import Data.ByteString(ByteString)
import Data.Vector(Vector)
import Data.Foldable(toList)
import Data.Hashable(Hashable)
import GHC.Generics(Generic)
import Formatting

import Spark.Core.Internal.Utilities
import Spark.Core.Try

-- | Separate type of error to make it more general and easier
-- to test.
type DagTry a = Either T.Text a


-- | The unique ID of a vertex.
newtype VertexId = VertexId { unVertexId :: ByteString } deriving (Eq, Ord, Generic)


-- | An edge in a graph, parametrized by some payload.
data Edge e = Edge {
  edgeFrom :: !VertexId,
  edgeTo :: !VertexId,
  edgeData :: !e
}

{-| An edge in the graph that also contains some slot information about the
start and the end of the edge.

This is critical for computing accurate graph reverses, and this is used as
a cheap way to check the integrity of the graph.
-}
data IndexedEdge e = IndexedEdge {
  iedgeFromIndex :: !Int,
  iedgeFrom :: !VertexId,
  iedgeToIndex :: !Int,
  iedgeTo :: !VertexId,
  iedgeData :: !e
} deriving (Show)

-- | A vertex in a graph, parametrized by some payload.
data Vertex v = Vertex {
  vertexId :: !VertexId,
  vertexData :: !v
}

{-| An edge, along with its end node.
-}
data VertexEdge e v = VertexEdge {
    veEndVertex :: !(Vertex v),
    veEdge :: !(Edge e) }

{-| The adjacency map of a graph.

The node Id corresponds to the start node, the pairs are the end node and
and the edge to reach to the node. There may be multiple edges leading to the
same node.
-}
type AdjacencyMap v e = M.Map VertexId (Vector (VertexEdge e v))

-- The starting index is implicit in the list.
type InternalAdjMap e = M.Map VertexId [(e, VertexId, Int)]

-- | The representation of a graph.
--
-- In all the project, it is considered as a DAG.
data Graph v e = Graph {
  _gAdjMap :: !(InternalAdjMap e),
  -- _gEdges :: !(AdjacencyMap v e),
  _gVertices :: !(Vector (Vertex v))
}

gEdges :: forall v e. Graph v e -> AdjacencyMap v e
gEdges g = m where
  vIdx :: M.Map VertexId v
  vIdx = M.map N.head $ myGroupBy $ f <$> V.toList (_gVertices g) where
    f (Vertex vid x) = (vid, x)
  lup vid = forceRight $ tryMaybe (M.lookup vid vIdx) "gEdges: failure"
  m = M.mapWithKey f (_gAdjMap g) where
    f fromVid v = V.fromList $ f' fromVid <$> v
    f' fromVid (e, toVid, _) = VertexEdge {
            veEndVertex = Vertex { vertexId = toVid, vertexData = lup toVid },
            veEdge = Edge {
              edgeFrom = fromVid,
              edgeTo = toVid,
              edgeData = e
            }
          }

gIndexedEdges :: Graph v e -> [IndexedEdge e]
gIndexedEdges g = concat l' where
  l = M.mapWithKey f (_gAdjMap g)
  l' = M.elems l
  f vidFrom v = g' <$> zip [(0::Int)..] v where
    g' (idxFrom, (e, vidTo, idxTo)) = IndexedEdge idxFrom vidFrom idxTo vidTo e

gVertices :: Graph v e -> Vector (Vertex v)
gVertices = _gVertices

-- | Graph operations on types that are supposed to
-- represent vertices.
class GraphVertexOperations v where
  vertexToId :: v -> VertexId
  expandVertexAsVertices :: v -> [v]

-- | Graph operations on types that are supposed to represent
-- edges.
class (GraphVertexOperations v) => GraphOperations v e where
  expandVertex :: v -> [(e,v)]

instance Functor Vertex where
  fmap f vx = vx { vertexData = f (vertexData vx) }

instance Functor Edge where
  fmap f ed = ed { edgeData = f (edgeData ed) }

instance (Show v) => Show (Vertex v) where
  show vx = "Vertex(vId=" ++ show (vertexId vx) ++ " v=" ++ show (vertexData vx) ++ ")"

instance (Show e) => Show (Edge e) where
  show ed = "Edge(from=" ++ show (edgeFrom ed) ++ " to=" ++ show (edgeTo ed) ++ " e=" ++ show (edgeData ed) ++ ")"

instance (Show v, Show e) => Show (VertexEdge e v) where
  show (VertexEdge v e) = "(" ++ show v ++ ", " ++ show e ++ ")"

instance (Show v, Show e) => Show (Graph v e) where
  show g =
    let vxs = toList $ gVertices g <&> \(Vertex vid x) ->
          sformat (sh%":"%sh) vid x
        edges = f <$> gIndexedEdges g where
          f (IndexedEdge fromIdx fromVid toIdx toVid e) =
            sformat (sh%":"%sh%"->"%sh%"->"%sh%":"%sh) fromVid fromIdx e toIdx toVid
        vxs' = T.intercalate "," vxs
        eds' = T.intercalate " " edges
        str = T.concat ["Graph{", vxs', ", ", eds', "}"]
    in T.unpack str

instance Hashable VertexId

instance Show VertexId where
  show (VertexId bs) = let s = show bs in
    if length s > 9 then
      (drop 1 . take 6) s ++ ".."
    else
      s
