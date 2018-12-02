{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Spark.Common.NodeStructures where

import Data.ProtoLens(def)
import Data.Vector(Vector)
import qualified Data.Vector as V
import qualified Data.Text as T
import Lens.Micro

import Spark.Common.ProtoUtils
import Spark.Common.RowStructures
import Spark.Common.OpStructures
import Spark.Common.StructuresInternal
import Spark.Common.Try(Try)
import Spark.Common.TypesStructures
import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.Graph_Fields as PG

-- (internal) Phantom type tags for the locality
-- data LocUnknown

{-| (internal/developer)
The core data structure that represents an operator.
This contains all the information that is required in
the compute graph (except topological info), which is
expected to be stored in the edges.

These nodes are meant to be used after path resolution.
-}
data OperatorNode = OperatorNode {
  {-| The ID of the node.
  Lazy because it may be expensive to compute.
  -- TODO: it should not be here?
  -}
  onId :: NodeId,
  {-| The fully resolved path of the node.
  Lazy because it may depend on the ID.
  -}
  onPath :: NodePath,
  {-| The core node information. -}
  onNodeInfo :: !CoreNodeInfo,
  {-| The name of the associated operator -}
  onOpName :: !OperatorName,
  {-| The extra data associated to this node -}
  onExtra :: !OpExtra
} deriving (Eq)

onShape :: OperatorNode -> NodeShape
onShape = cniShape . onNodeInfo

onOp :: OperatorNode -> NodeOp
onOp = cniOp . onNodeInfo

onType :: OperatorNode -> DataType
onType = nsType . cniShape . onNodeInfo

onLocality :: OperatorNode -> Locality
onLocality = nsLocality . cniShape . onNodeInfo

{-| A node and some information about the parents of this node.

This information is enough to calculate most information relative
to a node.

This is the local context of the compute DAG.

TODO: remove?
-}
data NodeContext = NodeContext {
  ncParents :: ![OperatorNode],
  ncLogicalDeps :: ![OperatorNode]
}

-- -- (developer) The type for which we drop all the information expressed in
-- -- types.
-- --
-- -- This is useful to express parent dependencies (pending a more type-safe
-- -- interface)
-- type UntypedNode = ComputeNode LocUnknown Cell


{-| The different paths of edges in the compute DAG of nodes, at the
start of computations.

 - scope edges specify the scope of a node for naming. They are not included in
   the id.

-}
-- data NodeEdge = ScopeEdge | DataStructureEdge StructureEdge deriving (Show, Eq)

{-| The edges in a compute DAG, after name resolution (which is where most of
the checks and computations are being done)

- parent edges are the direct parents of a node, the only ones required for
  defining computations. They are included in the id.
- logical edges define logical dependencies between nodes to force a specific
  ordering of the nodes. They are included in the id.
-}
data StructureEdge = ParentEdge | LogicalEdge deriving (Show, Eq)

-- {-| A typed wrapper around the locality.
-- -}
-- data TypedLocality loc = TypedLocality { unTypedLocality :: !Locality } deriving (Eq, Show)

-- The parsing representation of a node.
-- This is what comes in and out of protobuf.
data ParsedNode = ParsedNode {
  pnLocality :: !Locality,
  pnPath :: !NodePath,
  pnOpName :: !OperatorName,
  pnExtra :: !OpExtra,
  pnParents :: ![NodePath],
  pnDeps :: ![NodePath],
  pnType :: !DataType,
  -- It is not required by the standard.
  -- Returned when constructing nodes.
  pnId :: !(Maybe NodeId)
} deriving (Show)

instance FromProto PG.Node ParsedNode where
  fromProto pn = do
    p <- extractMaybe' pn PG.maybe'path "path"
    extra <- extractMaybe' pn PG.maybe'opExtra "op_extra"
    parents' <- sequence $ fromProto <$> (pn ^. PG.parents)
    deps <- sequence $ fromProto <$> (pn ^. PG.logicalDependencies)
    dt <- extractMaybe' pn PG.maybe'inferedType "infered_type"
    oname <- fromProto $ pn ^. PG.opName
    nid <- case fromProto <$> (pn ^. PG.maybe'nodeId) of
      Nothing -> pure Nothing
      Just (Right x) -> pure (Just x)
      Just (Left e) -> Left e
    loc <- fromProto $ pn ^. PG.locality
    return ParsedNode {
      pnLocality = loc,
      pnPath = p,
      pnOpName = oname,
      pnExtra = extra,
      pnParents = parents',
      pnDeps = deps,
      pnType = dt,
      pnId = nid
    }

instance ToProto PG.Node ParsedNode where
  toProto pn = x where
    base = (def :: PG.Node)
         & PG.locality .~ toProto (pnLocality pn)
         & PG.path .~ toProto (pnPath pn)
         & PG.opName .~ toProto (pnOpName pn)
         & PG.opExtra .~ toProto (pnExtra pn)
         & PG.parents .~ (toProto <$> pnParents pn)
         & PG.logicalDependencies .~ (toProto <$> pnDeps pn)
         & PG.inferedType .~ toProto (pnType pn)
    x = case pnId pn of
      Just nid -> base & PG.nodeId .~ toProto nid
      Nothing -> base

instance Show OperatorNode where
  show (OperatorNode _ np _ _ _) = "OperatorNode[" ++ T.unpack (prettyNodePath np) ++ "]"
