{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Spark.Core.Types(
  DataType,
  Nullable(..),
  TupleEquivalence(..),
  NameTuple(..),
  -- intType,
  -- canNull,
  -- noNull,
  -- stringType,
  -- arrayType',
  -- cellType,
  -- structField,
  -- structType,
  -- arrayType,
  SQLType,
  columnType,
  SQLTypeable,
  buildType,
  StructField,
  StructType,
  -- castType,
  catNodePath,
  unSQLType
) where

import Spark.Common.TypesStructures
import Spark.Common.TypesGenerics
import Spark.Common.TypesFunctions
import Spark.Common.StructuresInternal
import Spark.Core.Internal.FunctionsInternals(TupleEquivalence(..), NameTuple(..))

-- | Description of types supported in DataSets
-- Karps supports a restrictive subset of Algebraic Datatypes that is amenable to SQL
-- transformations. This file contains the description of all the supported types, and some
-- conversion tools.
