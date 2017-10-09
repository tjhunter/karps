
{-|
Module      : Spark.Core.ColumnFunctions
Description : Column operations

The standard library of functions that operate on
data columns.
-}
module Spark.Core.ColumnFunctions(
  -- * Reductions
  sum,
  sum',
  count,
  count',
  -- * Casting
  asDouble
) where

import Prelude hiding(sum)
import Spark.Core.Internal.ArithmeticsImpl()
import Spark.Core.InternalStd.Column
import Spark.Core.Internal.AggregationFunctions
import Spark.Core.Internal.Projections()
