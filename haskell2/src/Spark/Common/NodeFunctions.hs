{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Spark.Common.NodeFunctions(
  -- nodeOp,
  -- nodeParents,
  -- nodeLogicalParents,
  -- nodeLogicalDependencies,
  -- nodeName,
  -- nodeUntypedLocality,
  -- nodeLocality,
  -- nodePath,
  -- nodeType,
  -- nodeShape,
  -- untyped,
  -- untypedLoc,
  -- untypedType,
  -- logicalParents,
  -- depends,
  -- nodeId,
  -- updateNode,
  buildOpNode,
  buildOpNodeInScope,
  -- nodeFromContext,
  updateOpNodeOp,
  filterParentNodes,
  updateOpNode
  -- parents,
  -- emptyNodeTyped,
  -- castType
) where


import qualified Crypto.Hash.SHA256 as SHA
import qualified Data.Text as T
import qualified Data.Text.Format as TF
import qualified Data.Vector as V
import Data.Text.Encoding(decodeUtf8, encodeUtf8)
import Data.ByteString.Base16(encode)
import Data.Maybe(fromMaybe, listToMaybe)
import Data.Text.Lazy(toStrict)
import Data.String(IsString(fromString))
import Formatting

import Spark.Common.NodeStructures
import Spark.Common.OpStructures
import Spark.Common.OpFunctions
import Spark.Common.StructuresInternal
import Spark.Common.Try
import Spark.Common.TypesFunctions
import Spark.Common.TypesStructures
import Spark.Common.Utilities
import Spark.Common.RowStructures(Cell)

-- -- | (developer) The operation performed by this node.
-- nodeOp :: ComputeNode loc a -> NodeOp
-- nodeOp = _cnOp
--
-- -- | The nodes this node depends on directly.
-- nodeParents :: ComputeNode loc a -> [UntypedNode]
-- nodeParents = V.toList . _cnParents
--
-- -- | (developer) Returns the logical parenst of a node.
-- nodeLogicalParents :: ComputeNode loc a -> Maybe [UntypedNode]
-- nodeLogicalParents = (V.toList <$>) . _cnLogicalParents
--
-- -- | Returns the logical dependencies of a node.
-- nodeLogicalDependencies :: ComputeNode loc a -> [UntypedNode]
-- nodeLogicalDependencies = V.toList . _cnLogicalDeps
--
-- -- | The name of a node.
-- -- TODO: should be a NodePath
-- nodeName :: ComputeNode loc a -> NodeName
-- nodeName node = fromMaybe (_defaultNodeName node) (_cnName node)
--
-- nodeUntypedLocality :: ComputeNode loc a -> Locality
-- nodeUntypedLocality = _cnLocality
--
-- -- The locality of the node
-- nodeLocality :: ComputeNode loc a -> TypedLocality loc
-- nodeLocality = TypedLocality . _cnLocality
--
--
-- {-| The path of a node, as resolved.
--
-- This path includes information about the logical parents (after resolution).
-- -}
-- nodePath :: ComputeNode loc a -> NodePath
-- nodePath node =
--   if V.null . unNodePath . _cnPath $ node
--     then NodePath . V.singleton . nodeName $ node
--     else _cnPath node
--
-- -- | The type of the node
-- -- TODO have nodeType' for dynamic types as well
-- nodeType :: ComputeNode loc a -> SQLType a
-- nodeType = SQLType . _cnType
--
-- {-| INTERNAL -}
-- nodeShape :: ComputeNode loc a -> NodeShape
-- nodeShape node = NodeShape (unSQLType . nodeType $ node) (nodeUntypedLocality node)
--
-- -- | Converts any node to an untyped node
-- untyped :: ComputeNode loc a -> UntypedNode
-- untyped = untypedLoc . untypedType
--
-- untypedLoc :: ComputeNode loc a -> ComputeNode LocUnknown a
-- untypedLoc = _unsafeCastNode
--
-- untypedType :: ComputeNode loc a -> ComputeNode loc Cell
-- untypedType = _unsafeCastNode
--
-- {-| Establishes a naming convention on this node: the path of this node will be
-- determined as if the parents of this node were the list provided (and without
-- any effect from the direct parents of this node).
--
-- For this to work, the logical parents should split the nodes between internal
-- nodes, logical parents, and the rest. In other words, for any ancestor of this node,
-- and for any valid path to reach this ancestor, this path should include at least one
-- node from the logical dependencies.
--
-- This set can be a super set of the actual logical parents.
--
-- The check is lazy (done during the analysis phase). An error (if any) will
-- only be reported during analysis.
-- -}
-- logicalParents :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
-- logicalParents node l = updateNode node $ \n ->
--   n { _cnLogicalParents = pure . V.fromList $ l }
--
-- {-| Sets the logical dependencies on this node.
--
-- All the nodes given will be guaranteed to be executed before the current node.
--
-- If there are any failures, this node will also be treated as a failure (even
-- if the parents are all successes).
-- -}
-- depends :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
-- depends node l = updateNode node $ \n ->
--   n { _cnLogicalDeps = V.fromList l }
--
-- -- (internal)
-- -- The id of a node. If it is not set in the node, it will be
-- -- computed from scratch.
-- -- This is a potentially long operation.
-- nodeId :: ComputeNode loc a -> NodeId
-- nodeId = _cnNodeId

-- buildOpNode :: CoreNodeInfo -> NodePath -> NodeContext -> OperatorNode
-- buildOpNode cni np nc = updateOpNode on nc id where
--   on = OperatorNode {
--     onId = error "buildOpNode",
--     onPath = np,
--     onNodeInfo = cni
--   }

{-| Builds an operator and fills in the name and the id. The name is selected
to be roughly unique with high probability.
-}
buildOpNodeInScope ::
  CoreNodeInfo ->
  NodePath ->
  [NodeId] -> -- Parents
  [NodeId] -> -- Deps
  OperatorNode
buildOpNodeInScope cni scope_path parent_ids dep_ids =
  OperatorNode {
    onId = id2,
    onPath = xpath,
    onNodeInfo = cni
  } where s1 = SHA.init
          s2 = SHA.updates s1 ["parents"]
          s3 = SHA.updates s2 $ unNodeId <$> parent_ids
          s4 = SHA.updates s3 ["deps"]
          s5 = SHA.updates s4 $ unNodeId <$> dep_ids
          s6 = _updateCNI s5 cni
          id2 = NodeId . encode . SHA.finalize $ s6
          xname = _defaultName "FIXME" id2
          xpath = appendPath scope_path xname

buildOpNode ::
  CoreNodeInfo ->
  NodePath ->
  [NodeId] -> -- Parents
  [NodeId] -> -- Deps
  OperatorNode
buildOpNode cni path parent_ids dep_ids =
  (buildOpNodeInScope cni path parent_ids dep_ids) { onPath = path }

_defaultName :: OperatorName -> NodeId -> NodeName
_defaultName (OperatorName ndn) nid = NodeName n where
      namePieces = T.splitOn (".") ndn
      lastOpt = (listToMaybe . reverse) namePieces
      l = fromMaybe ("???") lastOpt
      idt = T.take 6 . decodeUtf8 . unNodeId $ nid
      n = T.concat [T.toLower l, T.pack "_", idt]


_updateCNI :: SHA.Ctx -> CoreNodeInfo -> SHA.Ctx
_updateCNI ctx (CoreNodeInfo ns extra) =
  -- TODO: it is missing the actual content of the op!!
  SHA.updates ctx ["ns", bs_shape, "extra"] where
    bs_shape = encodeUtf8 $ show' ns -- TODO: could be optimized
    --(OpExtra bs_extra _ _) = extra

-- --
-- nodeFromContext :: OperatorNode -> [UntypedNode] -> [UntypedNode] -> UntypedNode
-- nodeFromContext on parents' dependencies = updateNode n id where
--   n = ComputeNode {
--     _cnNodeId = undefined,
--     _cnOp = cniOp (onNodeInfo on),
--     _cnType = nsType . cniShape . onNodeInfo $ on,
--     _cnParents = V.fromList parents',
--     _cnLogicalDeps = V.fromList dependencies,
--     _cnLocality = nsLocality . cniShape . onNodeInfo $ on,
--     _cnName = Nothing,
--     _cnLogicalParents = Nothing,
--     _cnPath = onPath on
--   }


updateOpNodeOp :: OperatorNode -> NodeContext -> NodeOp -> OperatorNode
updateOpNodeOp n nc no = updateOpNode n nc $ \n' ->
      n' {
        onNodeInfo = (onNodeInfo n') {
          cniOp = no
        }
      }

filterParentNodes :: [(v, StructureEdge)] -> [v]
filterParentNodes [] = []
filterParentNodes ((v, ParentEdge):t) = v : filterParentNodes t
filterParentNodes (_ : t) = filterParentNodes t


-- (internal)
-- This operation should always be used to make sure that the
-- various caches inside the compute node are maintained.
updateOpNode :: OperatorNode -> NodeContext -> (OperatorNode -> OperatorNode) -> OperatorNode
updateOpNode on nc f = on2 { onId = id2 } where
  on2 = f on
  id2 = _opNodeId on2 nc

-- -- (internal)
-- -- This operation should always be used to make sure that the
-- -- various caches inside the compute node are maintained.
-- {-# DEPRECATED #-}
-- updateNode :: ComputeNode loc a -> (ComputeNode loc a -> ComputeNode loc' b) -> ComputeNode loc' b
-- updateNode ds f = ds2 { _cnNodeId = id2 } where
--   ds2 = f ds
--   id2 = _nodeId ds2

-- -- Performs an unsafe type recast.
-- -- This is useful for internal code that knows whether
-- -- this operation is legal or not through some other means.
-- -- This may still throw an error if the cast is illegal.
-- _unsafeCastNode :: ComputeNode loc1 a -> ComputeNode loc2 b
-- _unsafeCastNode x = x {
--     _cnType = _cnType x,
--     _cnLocality = nodeUntypedLocality x
--   }

--


-- _nodeId :: ComputeNode loc a -> NodeId
-- _nodeId node = _opNodeId (nodeOpNode node) (nodeContext node)

-- Computes the ID of a node.
-- Since this is a complex operation, it should be cached by each node.
_opNodeId :: OperatorNode -> NodeContext -> NodeId
_opNodeId node nc =
  let c1 = SHA.init
      f2 = unNodeId . onId
      c2 = hashUpdateNodeOp c1 (onOp node)
      c3 = SHA.updates c2 $ f2 <$> ncParents nc
      c4 = SHA.updates c3 $ f2 <$> ncLogicalDeps nc
  in
    -- Using base16 encoding to make sure it is readable.
    -- Not sure if it is a good idea in general.
    (NodeId . encode . SHA.finalize) c4


--
-- _defaultNodeName :: ComputeNode loc a -> NodeName
-- _defaultNodeName node =
--   let opName = (prettyShowOp . nodeOp) node
--       namePieces = T.splitOn (T.pack ".") opName
--       lastOpt = (listToMaybe . reverse) namePieces
--       l = fromMaybe (T.pack "???") lastOpt
--       idbs = nodeId node
--       idt = (T.take 6 . decodeUtf8 . unNodeId) idbs
--       n = T.concat [T.toLower l, T.pack "_", idt]
--   in NodeName n

--
-- castType :: SQLType a -> ComputeNode loc b -> Try (ComputeNode loc a)
-- castType sqlt n = do
--   let dt = unSQLType sqlt
--   let dt' = unSQLType (nodeType n)
--   if dt `compatibleTypes` dt'
--     then let n' = updateNode n (\node -> node { _cnType = dt }) in
--       pure (_unsafeCastNode n')
--     else tryError $ sformat ("castType: Casting error: dataframe has type "%sh%" incompatible with type "%sh) dt' dt

-- {-| Adds parents to the node.
-- It is assumed the parents are the unique set of nodes required
-- by the operation defined in this node.
-- If you want to set parents for the sake of organizing computation
-- use logicalParents.
-- If you want to add some timing dependencies between nodes,
-- use depends.
-- -}
-- parents :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
-- parents node l = updateNode node $ \n ->
--   n { _cnParents = V.fromList l V.++ _cnParents n }
--
-- --
-- emptyNodeTyped :: forall loc a.
--   TypedLocality loc -> SQLType a -> NodeOp -> ComputeNode loc a
-- emptyNodeTyped tloc (SQLType dt) op = updateNode ds id where
--   ds :: ComputeNode loc a
--   ds = ComputeNode {
--     _cnName = Nothing,
--     _cnOp = op,
--     _cnType = dt,
--     _cnParents = V.empty,
--     _cnLogicalParents = Nothing,
--     _cnLogicalDeps = V.empty,
--     _cnLocality = unTypedLocality tloc,
--     _cnNodeId = error "_emptyNode: _cnNodeId",
--     _cnPath = NodePath V.empty
--   }

--
-- -- ******* INSTANCES *********
--
-- -- Put here because it depends on some private functions.
-- instance forall loc a. Show (ComputeNode loc a) where
--   show ld = let
--     txt = fromString "{}@{}{}{}" :: TF.Format
--     loc :: T.Text
--     loc = case nodeUntypedLocality ld of
--       Local -> "!"
--       Distributed -> ":"
--     np = prettyNodePath . nodePath $ ld
--     no = prettyShowOp . nodeOp $ ld
--     fields = T.pack . show . nodeType $ ld in
--       T.unpack $ toStrict $ TF.format txt (np, no, loc, fields)
