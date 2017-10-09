{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}


{-| Functions over datasets that are used within core because they are so
ubiquitous.
-}
module Spark.Core.Internal.DatasetStd where

import qualified Data.Vector as V
import Formatting
import Lens.Family2((^.))

import Spark.Core.Try
import Spark.Core.Row
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.PathsUntyped()
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.TypesFunctions
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.RowUtils
import qualified Proto.Karps.Proto.Std as PStd
import qualified Proto.Karps.Proto.Row as PRow
import qualified Proto.Karps.Proto.Graph as PGraph

{-| Returns the union of two datasets.

In the context of streaming and differentiation, this union is biased towards
the left: the left argument expresses the stream and the right element expresses
the increment.
-}
union :: Dataset a -> Dataset a -> Dataset a
union n1 n2 = forceRight $ fromBuilder2 n1 n2 unionBuilder (nodeLocality n1) (nodeType n1)

unionBuilder :: NodeBuilder
unionBuilder = buildOpDD "org.spark.Union" $ \dt1 dt2 ->
  if dt1 == dt2
    then pure $ cniStandardOp' Distributed "org.spark.Union" dt1
    else tryError $ "unionBuilder: expected same type, but got "<>show' dt1<>" and "<>show' dt2


{-| The identity function.

Returns a compute node with the same datatype and the same content as the
previous node. If the operation of the input has a side effect, this side
side effect is *not* reevaluated.

This operation is typically used when establishing an ordering between some
operations such as caching or side effects, along with `logicalDependencies`.
-}
identity :: ComputeNode loc a -> ComputeNode loc a
identity n = forceRight $ if unTypedLocality (nodeLocality n) == Local
    then fromBuilder1 n identityBuilderL (nodeLocality n) (nodeType n)
    else fromBuilder1 n identityBuilderD (nodeLocality n) (nodeType n)

identityBuilderD :: NodeBuilder
identityBuilderD = buildOpD "org.spark.Identity" $ \dt ->
    pure $ cniStandardOp' Distributed "org.spark.Identity" dt

identityBuilderL :: NodeBuilder
identityBuilderL = buildOpL "org.spark.LocalIdentity" $ \dt ->
    pure $ cniStandardOp' Local "org.spark.LocalIdentity" dt

dataframe :: DataType -> [Cell] -> DataFrame
dataframe dt l = fromBuilder0Extra' literalBuilderD =<< cwt where
  cwt = tryEither $ cellWithTypeToProto (arrayType' dt) (RowArray (V.fromList l))

literalBuilderD :: NodeBuilder
literalBuilderD = buildOpExtra "org.spark.DistributedLiteral" f where
  f :: PRow.CellWithType -> Try CoreNodeInfo
  f cwt = do
    (cells', dt') <- tryEither (cellWithTypeFromProto cwt)
    case (cells', dt') of
      (RowArray v, StrictType (ArrayType dt)) ->
        pure $ CoreNodeInfo (NodeShape dt Distributed) op where
          op = NodeDistributedLit dt v
      _ -> tryError $ sformat ("builderDistributedLiteral: Expected an array of cells and an array type, got "%sh) (cells', dt')

literalBuilderL :: NodeBuilder
literalBuilderL = buildOpExtra "org.spark.LocalLiteral" f where
  f :: PRow.CellWithType -> Try CoreNodeInfo
  f cwt = do
    (cells', dt) <- tryEither (cellWithTypeFromProto cwt)
    let op = NodeLocalLit dt cells'
    return $ CoreNodeInfo (NodeShape dt Local) op where


localityFromProto :: PGraph.Locality -> Locality
localityFromProto PGraph.LOCAL = Local
localityFromProto PGraph.DISTRIBUTED = Distributed

localityToProto :: Locality -> PGraph.Locality
localityToProto Local = PGraph.LOCAL
localityToProto Distributed = PGraph.DISTRIBUTED

placeholder :: forall loc a. (IsLocality loc) => SQLType a -> ComputeNode loc a
placeholder sqlt = forceRight $ fromBuilder0Extra placeholderBuilder p loct sqlt where
  loct = _getTypedLocality :: TypedLocality loc
  loc = unTypedLocality loct
  p = PStd.Placeholder (localityToProto loc) (Just (toProto (unSQLType sqlt)))

placeholderBuilder :: NodeBuilder
placeholderBuilder = buildOpExtra "org.spark.Placeholder" f where
  f :: PStd.Placeholder -> Try CoreNodeInfo
  f p = do
    pdt <- extractMaybe p PStd.maybe'dataType "datatype"
    dt <- fromProto pdt
    let loc = p ^. PStd.locality
    return $ cniStandardOp (localityFromProto loc) "org.spark.Placeholder" dt p

{-| Low-level operator that takes an observable and propagates it along the
content of an existing dataset.

Users are advised to use the Column-based `broadcast` function instead.
-}
broadcastPair :: Dataset a -> LocalData b -> Dataset (a, b)
broadcastPair ds1 obs2 = forceRight $ fromBuilder2 ds1 obs2 broadcastPairBuilder (nodeLocality ds1) sqlt where
      sqlt = tupleType (nodeType ds1) (nodeType obs2)

broadcastPairBuilder :: NodeBuilder
broadcastPairBuilder = buildOpDL "org.spark.BroadcastPair" $ \dt1 dt2 -> do
  let dt = tupleType' dt1 dt2
  return $ CoreNodeInfo (NodeShape dt Distributed) NodeBroadcastJoin


-- This operators is mostly used internally -> no need to expose currently.
pointerBuilder :: NodeBuilder
pointerBuilder = buildOpExtra "org.spark.PlaceholderCache" f where
  f :: PStd.LocalPointer -> Try CoreNodeInfo
  f p = do
    pdt <- extractMaybe p PStd.maybe'dataType "datatype"
    dt <- fromProto pdt
    return $ cniStandardOp Local "org.spark.PlaceholderCache" dt p
