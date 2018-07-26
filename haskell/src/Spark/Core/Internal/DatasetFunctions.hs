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
  --updateNodeOp,
  -- Developer conversions
  --placeholder,
  castType,
  castType',
  -- Operator node functions
  updateOpNode,
  updateOpNodeOp,
  buildOpNode,
  buildOpNode'
) where

import qualified Data.Text as T
import Control.Monad(when)
import Formatting
import Data.ProtoLens.Message(Message)

import Spark.Common.StructuresInternal
import Spark.Common.Try
import Spark.Core.Row
import Spark.Common.NodeStructures
import Spark.Common.NodeFunctions
import Spark.Common.TypesStructures
import Spark.Core.Internal.DatasetStructures
import Spark.Common.NodeBuilder
import Spark.Common.OpStructures
import Spark.Common.OpFunctions
import Spark.Common.Utilities
import Spark.Common.TypesGenerics



-- | Converts to a dataframe and drops the type info.
-- This always works.
asDF :: ComputeNode LocDistributed a -> DataFrame
asDF = pure . untypedType

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
asLocalObservable = Observable' . pure . untypedType

asObservable :: forall a. (SQLTypeable a) => LocalFrame -> Try (LocalData a)
asObservable = _asTyped . unObservable'


untyped' :: Try (ComputeNode loc a) -> UntypedNode'
untyped' = fmap untyped


untypedDataset :: ComputeNode LocDistributed a -> UntypedDataset
untypedDataset = untypedType

{-| Removes type informatino from an observable. -}
untypedLocalData :: ComputeNode LocLocal a -> UntypedLocalData
untypedLocalData = untypedType

logicalParents' :: Try (ComputeNode loc a) -> [UntypedNode'] -> Try (ComputeNode loc a)
logicalParents' n' l' = do
  n <- n'
  l <- sequence l'
  return (logicalParents n l)

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
emptyDataset :: NodeOp -> SQLType a -> Dataset a
emptyDataset = _emptyNode

-- (internal)
emptyLocalData :: NodeOp -> SQLType a -> LocalData a
emptyLocalData = _emptyNode


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
  let n = emptyNodeTyped tl sqlt (cniOp cni)
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
  let n = emptyNodeTyped tl (SQLType builtType) (cniOp cni)
  let n2 = n `parents` l
  return n2

emptyNodeStandard :: forall loc a.
  TypedLocality loc -> SQLType a -> T.Text -> ComputeNode loc a
emptyNodeStandard tloc sqlt name = emptyNodeTyped tloc sqlt op where
  so = StandardOperator {
         soName = name,
         soOutputType = unSQLType sqlt,
         soExtra = emptyExtra
       }
  op = if unTypedLocality tloc == Local
          then NodeLocalOp so
          else NodeDistributedOp so


castType' :: SQLType a -> Try (ComputeNode loc Cell) -> Try (ComputeNode loc a)
castType' sqlt df = df >>= castType sqlt

_asTyped :: forall loc a. (SQLTypeable a) => Try (ComputeNode loc Cell) -> Try (ComputeNode loc a)
_asTyped = castType' (buildType :: SQLType a)


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

-- Create a new empty node. Also performs a locality check to
-- make sure the info being provided is correct.
_emptyNode :: forall loc a. (IsLocality loc) =>
  NodeOp -> SQLType a -> ComputeNode loc a
_emptyNode op sqlt = emptyNodeTyped (_getTypedLocality :: TypedLocality loc) sqlt op
