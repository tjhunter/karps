{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

{-| The standard library of functions operating on columns only.

You should use these functions if you care about expressing some
transforms involving columns only. Most of the functions here have
an overloaded equivalent in DatasetStandard which will work also for
datasets, dataframes, observables, etc.

This module is meant to be imported qualified.
-}
module Spark.Core.InternalStd.Column(
  asDouble,
  castDoubleCBuilder,
  eqCBuilder,
  inverseCBuilder,
  plusCBuilder,
  minusCBuilder,
  multiplyCBuilder,
  divideCBuilder,
  lowerCBuilder,
  lowerEqCBuilder,
  greaterCBuilder,
  greaterEqCBuilder
) where

import Data.Text(Text)

import Spark.Core.Internal.ColumnStructures
import Spark.Core.Internal.ColumnFunctions
import Spark.Core.Internal.TypesGenerics(buildType)
import Spark.Core.Internal.TypesStructures(StrictDataType(DoubleType, BoolType))
import Spark.Core.Internal.StructuredBuilder
import Spark.Core.Internal.TypesFunctions(mapDataType)

{-| Converts a numeric column to a column of doubles.

Some loss of precision may occur.-}
asDouble :: (Num a) => Column ref a -> Column ref Double
asDouble = makeColOp1 "double" buildType

-- ******* Casting *********

castDoubleCBuilder :: ColumnSQLBuilder
castDoubleCBuilder = colBuilder1 "cast_double" $ \dt -> do
  checkNumber dt
  return $ mapDataType dt (const DoubleType)

-- ****** Mathematical operators ******

_mathOp :: Text -> ColumnSQLBuilder
_mathOp n = colBuilder2Homo n $ \dt -> do
  checkNumber dt
  return dt

plusCBuilder :: ColumnSQLBuilder
plusCBuilder = _mathOp "plus"

minusCBuilder :: ColumnSQLBuilder
minusCBuilder = _mathOp "minus"

multiplyCBuilder :: ColumnSQLBuilder
multiplyCBuilder = _mathOp "multiply"

divideCBuilder :: ColumnSQLBuilder
divideCBuilder = colBuilder2Homo "divide" $ \dt -> do
  checkStrictDataTypeList [DoubleType] dt
  return dt

inverseCBuilder :: ColumnSQLBuilder
inverseCBuilder = colBuilder1 "inverse" $ \dt -> do
  checkStrictDataTypeList [DoubleType] dt
  return dt

-- ******* Comparisons ********

_compOp :: Text -> ColumnSQLBuilder
_compOp n = colBuilder2Homo n $ \dt ->
  pure $ mapDataType dt (const BoolType)

eqCBuilder :: ColumnSQLBuilder
eqCBuilder = _compOp "eq"

lowerEqCBuilder :: ColumnSQLBuilder
lowerEqCBuilder = _compOp "lower_equal"

lowerCBuilder :: ColumnSQLBuilder
lowerCBuilder = _compOp "lower"

greaterEqCBuilder :: ColumnSQLBuilder
greaterEqCBuilder = _compOp "greater_equal"

greaterCBuilder :: ColumnSQLBuilder
greaterCBuilder = _compOp "greater"

-- ****** Misc ******
