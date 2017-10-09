{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-redundant-constraints #-}

-- A number of standard aggregation functions.
-- TODO: completely redo the module based on the builders.

module Spark.Core.Internal.AggregationFunctions(
  -- Standard library
  collect,
  collect',
  count,
  count',
  sum,
  sum',
) where

import Prelude hiding(sum)

import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.ColumnStructures
import Spark.Core.Internal.ColumnFunctions(unColumn')
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.RowGenerics(ToSQL)
import Spark.Core.Internal.StructuredBuilder(AggSQLBuilder(..))
import Spark.Core.Internal.LocalDataFunctions()
import Spark.Core.Internal.FunctionsInternals
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.Utilities
import Spark.Core.StructuresInternal(emptyFieldPath)
import Spark.Core.InternalStd.Aggregation
import Spark.Core.Types
import Spark.Core.Try


{-| The sum of all the elements in a column.

If the data type is too small to represent the sum, the value being returned is
undefined.
-}
sum :: forall ref a. (Num a, SQLTypeable a, ToSQL a) =>
  Column ref a -> LocalData a
sum = applyAggCol sumABuilder

sum' :: Column' -> LocalFrame
sum' = applyAggCol' sumABuilder

count :: Column ref a -> LocalData Int
count = applyAggCol countABuilder

count' :: Column' -> LocalFrame
count' = applyAggCol' countABuilder


{-| Collects all the elements of a column into a list.

NOTE:
This list is sorted in the canonical ordering of the data type: however the
data may be stored by Spark, the result will always be in the same order.
This is a departure from Spark, which does not guarantee an ordering on
the returned data.
-}
collect :: forall ref a. (SQLTypeable a) => Column ref a -> LocalData [a]
collect = applyAggCol collectAggBuilder

{-| See the documentation of collect. -}
collect' :: Column' -> LocalFrame
collect' = applyAggCol' collectAggBuilder

applyAggCol' :: AggSQLBuilder -> Column' -> Observable'
applyAggCol' b c' = Observable' $ do
  c2 <- unColumn' c'
  let ds = pack1 c2
  _applyAgg b ds

applyAggCol :: forall ref a b. (SQLTypeable b) => AggSQLBuilder -> Column ref a -> LocalData b
applyAggCol b c = applyAggD b (pack1 c)

{-| Typing errors are considered fatal, as the type system is supposed to check
that the transform is correct here. -}
applyAggD :: forall a b. (SQLTypeable b) => AggSQLBuilder -> Dataset a -> LocalData b
applyAggD b ds = forceRight $ do
  let dt1 = buildType :: SQLType b
  uds <- asDF ds
  uld <- _applyAgg b uds
  castType dt1 uld

{-| Applies the builder and returns a new node. -}
_applyAgg :: AggSQLBuilder -> UntypedDataset -> Try UntypedLocalData
_applyAgg b ds = do
  let f = asbBuilder b
  (dt', _) <- f (unSQLType . nodeType $ ds)
  let no = NodeReduction ao where
        ao = AggFunction (asbName b) emptyFieldPath (Just dt')
  return $ emptyLocalData no (SQLType dt') `parents` [untyped ds]
