{-# LANGUAGE OverloadedStrings #-}

module Spark.Core.InternalStd.Observable(
  asDouble,
  localPackBuilder) where

import qualified Spark.Core.InternalStd.Column as C
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.FunctionsInternals
import Spark.Core.Internal.TypesGenerics(SQLTypeable)
import Spark.Core.Internal.NodeBuilder
import Spark.Core.Internal.OpStructures
import Spark.Common.TypesStructures(DataType)
import Spark.Common.TypesFunctions(structTypeTuple')
import Spark.Common.Utilities
import Spark.Common.Try

{-| Casts a local data as a double.
-}
asDouble :: (Num a, SQLTypeable a) => LocalData a -> LocalData Double
asDouble = projectColFunction C.asDouble

{-| Packs observables together into a single observable.

This is required to apply transforms.
-}
localPackBuilder :: (HasCallStack) => NodeBuilder
localPackBuilder = buildOpVariable "org.spark.LocalPack" $ \nss -> do
  -- Check that the inputs are not empty and all local.
  dts <- _checkLocal nss
  -- Make a tuple with all the inputs
  let dt = structTypeTuple' dts
  let no = NodeLocalOp $ StandardOperator "org.spark.LocalPack" dt emptyExtra
  let cni = coreNodeInfo dt Local no
  return cni

_checkLocal :: (HasCallStack) => [NodeShape] -> Try (NonEmpty DataType)
_checkLocal [] = tryError "localPackBuilder: no input provided"
_checkLocal (h : t) = sequence $ f <$> (h :| t) where
    f ns | nsLocality ns == Distributed =
          tryError "localPackBuilder: parent node should be local"
    f ns = pure $ nsType ns
