{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

{-| The builders and operands for standard aggregations.
-}
module Spark.Core.InternalStd.Aggregation(
  collectAggBuilder,
  countABuilder,
  sumABuilder,
  minABuilder,
  maxABuilder
) where

import Spark.Core.Internal.StructuredBuilder
import Spark.Core.Internal.TypesFunctions(arrayType', intType)


-- TODO: there should be a collect_sorted instead, since we have stronger
-- guarantees with Karps.
collectAggBuilder :: AggSQLBuilder
collectAggBuilder = AggSQLBuilder "collect_list" $ \dt ->
  return (arrayType' dt, Nothing)

countABuilder :: AggSQLBuilder
countABuilder = AggSQLBuilder "count" $ const (pure (intType, Nothing))

sumABuilder :: AggSQLBuilder
sumABuilder = AggSQLBuilder "sum" $ \dt -> do
  checkNumber dt
  -- Unlike spark, there is no casting whatsoever
  -- This is on purpose
  return (dt, Nothing)

maxABuilder :: AggSQLBuilder
maxABuilder = AggSQLBuilder "max" $ \dt -> do
  -- This could be dropped eventually, all types are comparable.
  checkNumber dt
  return (dt, Nothing)

minABuilder :: AggSQLBuilder
minABuilder = AggSQLBuilder "min" $ \dt -> do
  -- This could be dropped eventually, all types are comparable.
  checkNumber dt
  return (dt, Nothing)
