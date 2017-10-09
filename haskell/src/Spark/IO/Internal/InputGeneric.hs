{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Spark.IO.Internal.InputGeneric(
  generic',
  genericWithSchema',
  genericWithSchema,
  extractResourcePath,
  updateResourceStamp
) where

import Spark.Core.Types
import Spark.Core.Try
import Spark.Core.Dataset

import Spark.Core.Internal.Utilities(forceRight)
import Spark.Core.Internal.DatasetFunctions(asDF, emptyDataset, emptyLocalData)
import Spark.Core.Internal.TypesStructures(SQLType(..))
import Spark.Core.Internal.ContextStructures(SparkState)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.OpFunctions(convertToExtra')
import Spark.Core.Internal.ContextIOInternal(executeCommand1)
import Spark.IO.Internal.InputStructures

{-| Generates a dataframe from a source description.

This may trigger some calculations on the Spark side if schema inference is
required.
-}
generic' :: SourceDescription -> SparkState DataFrame
generic' sd = do
  dtt <- _inferSchema sd
  return $ dtt >>= \dt -> genericWithSchema' dt sd

{-| Generates a dataframe from a source description, and assumes a given schema.

This schema overrides whatever may have been given in the source description. If
the source description specified that the schema must be checked or inferred,
this instruction is overriden.

While this is convenient, it may lead to runtime errors that are hard to
understand if the data does not follow the given schema.
-}
genericWithSchema' :: DataType -> SourceDescription -> DataFrame
genericWithSchema' dt sd = asDF $ emptyDataset no (SQLType dt) where
  sd' = sd { inputSchema = UseSchema dt }
  so = StandardOperator {
      soName = "org.spark.GenericDatasource",
      soOutputType = dt,
      soExtra = convertToExtra' sd'
    }
  no = NodeDistributedOp so

{-| Generates a dataframe from a source description, and assumes a certain
schema on the source.
-}
genericWithSchema :: forall a. (SQLTypeable a) => SourceDescription -> Dataset a
genericWithSchema sd =
  let sqlt = buildType :: SQLType a
      dt = unSQLType sqlt in
  forceRight $ castType sqlt =<< genericWithSchema' dt sd


-- Wraps the action of inferring the schema.
-- This is not particularly efficient here: it does a first pass to get the
-- schema, and then will do a second pass in order to read the data.
_inferSchema :: SourceDescription -> SparkState (Try DataType)
_inferSchema = executeCommand1 . _inferSchemaCmd

-- TODO: this is a monoidal operation, it could be turned into a universal
-- aggregator.
_inferSchemaCmd :: SourceDescription -> LocalData DataType
_inferSchemaCmd sd = emptyLocalData no sqlt where
  sqlt = buildType :: SQLType DataType
  dt = unSQLType sqlt
  so = StandardOperator {
      soName = "org.spark.InferSchema",
      soOutputType = dt,
      soExtra = convertToExtra' sd
    }
  no = NodeOpaqueAggregator so
