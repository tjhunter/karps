{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

module Spark.Core.Functions(
  -- * Creation
  dataset,
  dataframe,
  constant,
  -- * Standard conversions
  asLocalObservable,
  asDouble,
  -- * Arithmetic operations
  (.+),
  (.-),
  (./),
  div',
  -- * Utilities
  (@@),
  _1,
  _2,
  -- * Standard library
  collect,
  collect',
  count,
  identity,
  autocache,
  cache,
  uncache,
  joinInner,
  joinInner',
  broadcastPair
  ) where

import qualified Data.Vector as V

import Spark.Core.Dataset
import Spark.Core.Types
import Spark.Core.Row
import Spark.Core.Internal.ArithmeticsImpl
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.DatasetStd
import Spark.Core.Internal.Joins
import Spark.Core.Internal.CachingUntyped(uncache)
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.LocalDataFunctions
import Spark.Core.Internal.FunctionsInternals()
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.AggregationFunctions
import Spark.Core.Internal.TypesStructures(SQLType(..))
import Spark.Core.Internal.Projections
import Spark.Core.Internal.CanRename
import Spark.Core.InternalStd.Observable
import Spark.Core.InternalStd.Dataset

dataset :: (ToSQL a, SQLTypeable a, HasCallStack) => [a] -> Dataset a
dataset l = emptyDataset op tp where
  tp = buildType
  op = NodeDistributedLit (unSQLType tp) (V.fromList (valueToCell <$> l))
