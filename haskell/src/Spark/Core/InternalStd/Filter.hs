{-# LANGUAGE OverloadedStrings #-}

module Spark.Core.InternalStd.Filter(
filterBuilder) where

import Formatting

import Spark.Core.Internal.LocalDataFunctions()
import Spark.Core.Internal.NodeBuilder(cniStandardOp', NodeBuilder, buildOpD)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.TypesFunctions(extractFields2)
import Spark.Core.Try

filterBuilder :: NodeBuilder
filterBuilder = buildOpD "org.spark.Filter" $ \dt -> do
  -- The data type is supposed to have a pair of values.
  (dt1, dt2) <- extractFields2 "filter" "value" dt
  if dt1 == StrictType BoolType
  then
    return $ cniStandardOp' Distributed "org.spark.Filter" dt2
  else
    tryError $ sformat ("filterBuilder: expected boolean in the first field but got type "%sh) dt1
--
-- {-| Performs a filtering operation on columns of a dataset.
--
-- The first column is the reference column that is used to filter out values of
-- the second column.
-- -}
-- filterCol :: Column ref Bool -> Column ref a -> Dataset a
-- filterCol = missing "filterCol"
--
-- {-| Filters a column depending to only keep the strict data.
--
-- This function is useful to filter out some data within a structure, some of which
-- may not be strict.
-- -}
-- filterOpt :: Column ref (Maybe a) -> Column ref b -> Dataset (a, b)
-- filterOpt = missing "filterOpt"
--
-- {-| Returns the data for which another column is not defined.
-- -}
-- filterNone :: Column ref (Maybe a) -> Column ref b -> Dataset b
-- filterNone = missing "filterOpt"
--
-- {-| Only keeps the strict values of a column.
-- -}
-- filterMaybe :: Column ref (Maybe a) -> Dataset a
-- filterMaybe = missing "filterMaybe"
