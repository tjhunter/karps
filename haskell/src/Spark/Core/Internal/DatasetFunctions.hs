{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Spark.Core.Internal.DatasetFunctions(
  parents,
  untyped,
  untyped',
  logicalParents,
  logicalParents',
  depends,
  --dataframe,
  asDF,
  asDS,
  asObs',
  obsTry,
  asLocalObservable,
  asObservable,
  -- Standard functions
  --identity,
  --union,
  -- Developer
  fromBuilder0Extra,
  fromBuilder0Extra',
  fromBuilder1Extra,
  fromBuilder1,
  fromBuilder2Extra,
  fromBuilder2,
  filterParentNodes,
  -- builderDistributedLiteral,
  castLocality,
  emptyDataset,
  emptyLocalData,
  emptyNodeStandard,
  nodeFromContext,
  nodeId,
  nodeLogicalDependencies,
  nodeLogicalParents,
  nodeLocality,
  nodeName,
  nodePath,
  nodeOp,
  nodeParents,
  nodeShape,
  nodeType,
  untypedDataset,
  untypedLocalData,
  updateNode,
  updateNodeOp,
  -- Developer conversions
  unsafeCastDataset,
  --placeholder,
  castType,
  castType',
  -- Operator node functions
  updateOpNode,
  updateOpNodeOp,
  buildOpNode,
  buildOpNode'
) where

import qualified Crypto.Hash.SHA256 as SHA
import qualified Data.Text as T
import qualified Data.Text.Format as TF
import qualified Data.Vector as V
import Data.Text.Encoding(decodeUtf8)
import Data.ByteString.Base16(encode)
import Data.Maybe(fromMaybe, listToMaybe)
import Data.Text.Lazy(toStrict)
import Data.String(IsString(fromString))
import Control.Monad(when)
import Formatting
import Data.ProtoLens.Message(Message)

import Spark.Core.StructuresInternal
import Spark.Core.Try
import Spark.Core.Row
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.OpFunctions
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.TypesGenerics
import Spark.Core.Internal.TypesFunctions

-- | (developer) The operation performed by this node.
nodeOp :: ComputeNode loc a -> NodeOp
nodeOp = _cnOp

-- | The nodes this node depends on directly.
nodeParents :: ComputeNode loc a -> [UntypedNode]
nodeParents = V.toList . _cnParents

-- | (developer) Returns the logical parenst of a node.
nodeLogicalParents :: ComputeNode loc a -> Maybe [UntypedNode]
nodeLogicalParents = (V.toList <$>) . _cnLogicalParents

-- | Returns the logical dependencies of a node.
nodeLogicalDependencies :: ComputeNode loc a -> [UntypedNode]
nodeLogicalDependencies = V.toList . _cnLogicalDeps

-- | The name of a node.
-- TODO: should be a NodePath
nodeName :: ComputeNode loc a -> NodeName
nodeName node = fromMaybe (_defaultNodeName node) (_cnName node)

{-| The path of a node, as resolved.

This path includes information about the logical parents (after resolution).
-}
nodePath :: ComputeNode loc a -> NodePath
nodePath node =
  if V.null . unNodePath . _cnPath $ node
    then NodePath . V.singleton . nodeName $ node
    else _cnPath node

-- | The type of the node
-- TODO have nodeType' for dynamic types as well
nodeType :: ComputeNode loc a -> SQLType a
nodeType = SQLType . _cnType

{-| INTERNAL -}
nodeShape :: ComputeNode loc a -> NodeShape
nodeShape node = NodeShape (unSQLType . nodeType $ node) (unTypedLocality . nodeLocality $ node)


-- | Converts to a dataframe and drops the type info.
-- This always works.
asDF :: ComputeNode LocDistributed a -> DataFrame
asDF = pure . _unsafeCastNode

-- | Attempts to convert a dataframe into a (typed) dataset.
--
-- This will fail if the dataframe itself is a failure, of if the casting
-- operation is not correct.
-- This operation assumes that both field names and types are correct.
asDS :: forall a. (SQLTypeable a) => DataFrame -> Try (Dataset a)
asDS = _asTyped

asObs' :: Try (ComputeNode LocLocal a) -> Observable'
asObs' (Left x) = Observable' (Left x)
asObs' (Right x) = asLocalObservable x

obsTry :: Try Observable' -> Observable'
obsTry (Left x) = Observable' (Left x)
obsTry (Right x) = x

-- | Converts a local node to a local frame.
-- This always works.
asLocalObservable :: ComputeNode LocLocal a -> LocalFrame
asLocalObservable = Observable' . pure . _unsafeCastNode

asObservable :: forall a. (SQLTypeable a) => LocalFrame -> Try (LocalData a)
asObservable = _asTyped . unObservable'

-- | Converts any node to an untyped node
untyped :: ComputeNode loc a -> UntypedNode
untyped = _unsafeCastNode

untyped' :: Try (ComputeNode loc a) -> UntypedNode'
untyped' = fmap untyped


untypedDataset :: ComputeNode LocDistributed a -> UntypedDataset
untypedDataset = _unsafeCastNode

{-| Removes type informatino from an observable. -}
untypedLocalData :: ComputeNode LocLocal a -> UntypedLocalData
untypedLocalData = _unsafeCastNode

{-| Adds parents to the node.
It is assumed the parents are the unique set of nodes required
by the operation defined in this node.
If you want to set parents for the sake of organizing computation
use logicalParents.
If you want to add some timing dependencies between nodes,
use depends.
-}
parents :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
parents node l = updateNode node $ \n ->
  n { _cnParents = V.fromList l V.++ _cnParents n }

{-| Establishes a naming convention on this node: the path of this node will be
determined as if the parents of this node were the list provided (and without
any effect from the direct parents of this node).

For this to work, the logical parents should split the nodes between internal
nodes, logical parents, and the rest. In other words, for any ancestor of this node,
and for any valid path to reach this ancestor, this path should include at least one
node from the logical dependencies.

This set can be a super set of the actual logical parents.

The check is lazy (done during the analysis phase). An error (if any) will
only be reported during analysis.
-}
logicalParents :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
logicalParents node l = updateNode node $ \n ->
  n { _cnLogicalParents = pure . V.fromList $ l }

logicalParents' :: Try (ComputeNode loc a) -> [UntypedNode'] -> Try (ComputeNode loc a)
logicalParents' n' l' = do
  n <- n'
  l <- sequence l'
  return (logicalParents n l)

{-| Sets the logical dependencies on this node.

All the nodes given will be guaranteed to be executed before the current node.

If there are any failures, this node will also be treated as a failure (even
if the parents are all successes).
-}
depends :: ComputeNode loc a -> [UntypedNode] -> ComputeNode loc a
depends node l = updateNode node $ \n ->
  n { _cnLogicalDeps = V.fromList l }


-- (internal)
-- Tries to update the locality of a node. This is a checked cast.
-- TODO: remove, it is only used to cast to local frame
castLocality :: forall a loc loc'. (CheckedLocalityCast loc') =>
    ComputeNode loc a -> Try (ComputeNode loc' a)
castLocality node =
  let
    loc2 = _cnLocality node
    locs = unTypedLocality <$> (_validLocalityValues :: [TypedLocality loc'])
  in if locs == [loc2] then
    pure $ node { _cnLocality = loc2 }
  else
    tryError $ sformat ("Wrong locality :"%shown%", expected: "%shown) loc2 locs

-- (internal)
-- The id of a node. If it is not set in the node, it will be
-- computed from scratch.
-- This is a potentially long operation.
nodeId :: ComputeNode loc a -> NodeId
nodeId = _cnNodeId

buildOpNode :: CoreNodeInfo -> NodePath -> NodeContext -> OperatorNode
buildOpNode cni np nc = updateOpNode on nc id where
  on = OperatorNode {
    onId = error "buildOpNode",
    onPath = np,
    onNodeInfo = cni
  }

buildOpNode' :: NodeBuilder -> OpExtra -> NodePath -> [(OperatorNode, StructureEdge)] -> Try OperatorNode
buildOpNode' nb extra np l = do
  let shapes = fmap (onShape . fst) . filter ((ParentEdge==) . snd) $ l
  cni <- nbBuilder nb extra shapes
  let c = NodeContext {
        ncParents = f ParentEdge,
        ncLogicalDeps = f LogicalEdge
      } where f et = fmap fst . filter ((et==) . snd) $ l
  return $ buildOpNode cni np c

-- (internal)
-- This operation should always be used to make sure that the
-- various caches inside the compute node are maintained.
{-# DEPRECATED #-}
updateNode :: ComputeNode loc a -> (ComputeNode loc a -> ComputeNode loc' b) -> ComputeNode loc' b
updateNode ds f = ds2 { _cnNodeId = id2 } where
  ds2 = f ds
  id2 = _nodeId ds2

-- (internal)
-- This operation should always be used to make sure that the
-- various caches inside the compute node are maintained.
updateOpNode :: OperatorNode -> NodeContext -> (OperatorNode -> OperatorNode) -> OperatorNode
updateOpNode on nc f = on2 { onId = id2 } where
  on2 = f on
  id2 = _opNodeId on2 nc

{-# DEPRECATED #-}
updateNodeOp :: ComputeNode loc a -> NodeOp -> ComputeNode loc a
updateNodeOp n no = updateNode n (\n' -> n' { _cnOp = no })

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
-- The locality of the node
nodeLocality :: ComputeNode loc a -> TypedLocality loc
nodeLocality = TypedLocality . _cnLocality

-- (internal)
emptyDataset :: NodeOp -> SQLType a -> Dataset a
emptyDataset = _emptyNode

-- (internal)
emptyLocalData :: NodeOp -> SQLType a -> LocalData a
emptyLocalData = _emptyNode

nodeFromContext :: OperatorNode -> [UntypedNode] -> [UntypedNode] -> UntypedNode
nodeFromContext on parents' dependencies = updateNode n id where
  n = ComputeNode {
    _cnNodeId = undefined,
    _cnOp = cniOp (onNodeInfo on),
    _cnType = nsType . cniShape . onNodeInfo $ on,
    _cnParents = V.fromList parents',
    _cnLogicalDeps = V.fromList dependencies,
    _cnLocality = nsLocality . cniShape . onNodeInfo $ on,
    _cnName = Nothing,
    _cnLogicalParents = Nothing,
    _cnPath = onPath on
  }

-- *********** function / object conversions *******

fromBuilder0Extra :: Message x => NodeBuilder -> x -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
fromBuilder0Extra = _fromBuilderExtra []

fromBuilder0Extra' :: forall x loc. (Message x, IsLocality loc) => NodeBuilder -> x -> Try (ComputeNode loc Cell)
fromBuilder0Extra' nb x = _fromBuilder' [] nb x loc where
  loc = _getTypedLocality :: TypedLocality loc

fromBuilder1Extra :: Message x => ComputeNode loc1 a1 -> NodeBuilder -> x -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
fromBuilder1Extra cn = _fromBuilderExtra [untyped cn]

fromBuilder1 :: ComputeNode loc1 a1 -> NodeBuilder -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
fromBuilder1 cn = _fromBuilder [untyped cn]

fromBuilder2Extra :: Message x => ComputeNode loc1 a1 -> ComputeNode loc2 a2 -> NodeBuilder -> x -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
fromBuilder2Extra cn1 cn2 = _fromBuilderExtra [untyped cn1, untyped cn2]

fromBuilder2 :: ComputeNode loc1 a1 -> ComputeNode loc2 a2 -> NodeBuilder -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
fromBuilder2 cn1 cn2 = _fromBuilder [untyped cn1, untyped cn2]

_fromBuilder :: [UntypedNode] -> NodeBuilder -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
_fromBuilder l nb = _fromBuilder'' l nb emptyExtra

_fromBuilder'' :: [UntypedNode] -> NodeBuilder -> OpExtra -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
_fromBuilder'' l nb opExtra tl sqlt = do
  let shapes = (cniShape . onNodeInfo . nodeOpNode) <$> l
  cni <- nbBuilder nb opExtra shapes
  let builtLocality = nsLocality (cniShape cni)
  let expectedLocality = unTypedLocality tl
  let builtType = nsType (cniShape cni)
  let expectedType = unSQLType sqlt
  -- Check that the final shape from the builder matches the shape provided.
  when (builtLocality /= expectedLocality) $
    tryError $ "_fromBuilder: "<>show' (nbName nb)<>": built locality ("<>show' builtLocality<>") does not match expected locality ("<>show' expectedLocality<>")"
  when (builtType /= expectedType) $
    tryError $ "_fromBuilder: "<>show' (nbName nb)<>": built type ("<>show' builtType<>") does not match expected type ("<>show' expectedType<>")"
  let n = _emptyNodeTyped tl sqlt (cniOp cni)
  let n2 = n `parents` l
  return n2

_fromBuilderExtra :: Message x => [UntypedNode] -> NodeBuilder -> x -> TypedLocality loc -> SQLType a -> Try (ComputeNode loc a)
_fromBuilderExtra l nb x = _fromBuilder'' l nb (convertToExtra x)

-- TODO: code duplication with above
_fromBuilder' :: Message x => [UntypedNode] -> NodeBuilder -> x -> TypedLocality loc -> Try (ComputeNode loc Cell)
_fromBuilder' l nb x tl = do
  let opExtra = convertToExtra x
  let shapes = (cniShape . onNodeInfo . nodeOpNode) <$> l
  cni <- nbBuilder nb opExtra shapes
  let builtLocality = nsLocality (cniShape cni)
  let expectedLocality = unTypedLocality tl
  let builtType = nsType (cniShape cni)
  -- Check that the final shape from the builder matches the shape provided.
  when (builtLocality /= expectedLocality) $
    tryError $ "_fromBuilder: "<>show' (nbName nb)<>": built locality ("<>show' builtLocality<>") does not match expected locality ("<>show' expectedLocality<>")"
  let n = _emptyNodeTyped tl (SQLType builtType) (cniOp cni)
  let n2 = n `parents` l
  return n2

emptyNodeStandard :: forall loc a.
  TypedLocality loc -> SQLType a -> T.Text -> ComputeNode loc a
emptyNodeStandard tloc sqlt name = _emptyNodeTyped tloc sqlt op where
  so = StandardOperator {
         soName = name,
         soOutputType = unSQLType sqlt,
         soExtra = emptyExtra
       }
  op = if unTypedLocality tloc == Local
          then NodeLocalOp so
          else NodeDistributedOp so



-- ******* INSTANCES *********

-- Put here because it depends on some private functions.
instance forall loc a. Show (ComputeNode loc a) where
  show ld = let
    txt = fromString "{}@{}{}{}" :: TF.Format
    loc :: T.Text
    loc = case nodeLocality ld of
      TypedLocality Local -> "!"
      TypedLocality Distributed -> ":"
    np = prettyNodePath . nodePath $ ld
    no = prettyShowOp . nodeOp $ ld
    fields = T.pack . show . nodeType $ ld in
      T.unpack $ toStrict $ TF.format txt (np, no, loc, fields)

unsafeCastDataset :: ComputeNode LocDistributed a -> ComputeNode LocDistributed b
unsafeCastDataset ds = ds { _cnType = _cnType ds }

-- TODO: figure out the story around haskell types vs datatypes
-- Should we have equivalence classes for haskell, so that a tuple has the
-- same type as a structure?
-- Probably not, it breaks the correspondence.
-- Probably, it makes the metadata story easier.
castType :: SQLType a -> ComputeNode loc b -> Try (ComputeNode loc a)
castType sqlt n = do
  let dt = unSQLType sqlt
  let dt' = unSQLType (nodeType n)
  if dt `compatibleTypes` dt'
    then let n' = updateNode n (\node -> node { _cnType = dt }) in
      pure (_unsafeCastNode n')
    else tryError $ sformat ("castType: Casting error: dataframe has type "%sh%" incompatible with type "%sh) dt' dt

castType' :: SQLType a -> Try (ComputeNode loc Cell) -> Try (ComputeNode loc a)
castType' sqlt df = df >>= castType sqlt

_asTyped :: forall loc a. (SQLTypeable a) => Try (ComputeNode loc Cell) -> Try (ComputeNode loc a)
_asTyped = castType' (buildType :: SQLType a)

-- Performs an unsafe type recast.
-- This is useful for internal code that knows whether
-- this operation is legal or not through some other means.
-- This may still throw an error if the cast is illegal.
_unsafeCastNode :: ComputeNode loc1 a -> ComputeNode loc2 b
_unsafeCastNode x = x {
    _cnType = _cnType x,
    _cnLocality = _cnLocality x
  }

_unsafeCastNodeTyped :: TypedLocality loc2 -> ComputeNode loc1 a -> ComputeNode loc2 b
_unsafeCastNodeTyped l x = x {
    _cnType = _cnType x,
    _cnLocality = unTypedLocality l
  }

--
_unsafeCastLoc :: CheckedLocalityCast loc' =>
  TypedLocality loc -> TypedLocality loc'
_unsafeCastLoc (TypedLocality Local) =
  checkLocalityValidity (TypedLocality Local)
_unsafeCastLoc (TypedLocality Distributed) =
  checkLocalityValidity (TypedLocality Distributed)


-- This should be a programming error
checkLocalityValidity :: forall loc. (HasCallStack, CheckedLocalityCast loc) =>
  TypedLocality loc -> TypedLocality loc
checkLocalityValidity x =
  if x `notElem` _validLocalityValues
    then
      let msg = sformat ("CheckedLocalityCast: element "%shown%" not in the list of accepted values: "%shown)
                  x (_validLocalityValues :: [TypedLocality loc])
      in failure msg x
    else x


_nodeId :: ComputeNode loc a -> NodeId
_nodeId node = _opNodeId (nodeOpNode node) (nodeContext node)

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

_defaultNodeName :: ComputeNode loc a -> NodeName
_defaultNodeName node =
  let opName = (prettyShowOp . nodeOp) node
      namePieces = T.splitOn (T.pack ".") opName
      lastOpt = (listToMaybe . reverse) namePieces
      l = fromMaybe (T.pack "???") lastOpt
      idbs = nodeId node
      idt = (T.take 6 . decodeUtf8 . unNodeId) idbs
      n = T.concat [T.toLower l, T.pack "_", idt]
  in NodeName n

-- Create a new empty node. Also performs a locality check to
-- make sure the info being provided is correct.
_emptyNode :: forall loc a. (IsLocality loc) =>
  NodeOp -> SQLType a -> ComputeNode loc a
_emptyNode op sqlt = _emptyNodeTyped (_getTypedLocality :: TypedLocality loc) sqlt op

_emptyNodeTyped :: forall loc a.
  TypedLocality loc -> SQLType a -> NodeOp -> ComputeNode loc a
_emptyNodeTyped tloc (SQLType dt) op = updateNode (_unsafeCastNodeTyped tloc ds) id where
  ds :: ComputeNode loc a
  ds = ComputeNode {
    _cnName = Nothing,
    _cnOp = op,
    _cnType = dt,
    _cnParents = V.empty,
    _cnLogicalParents = Nothing,
    _cnLogicalDeps = V.empty,
    _cnLocality = unTypedLocality tloc,
    _cnNodeId = error "_emptyNode: _cnNodeId",
    _cnPath = NodePath V.empty
  }
