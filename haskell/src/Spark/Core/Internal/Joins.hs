{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-| Exposes some of Spark's joining algorithms.
-}
module Spark.Core.Internal.Joins(
  join,
  join',
  joinInner,
  joinInner',
  joinObs,
  joinObs'
) where

import Control.Arrow

import Spark.Core.Internal.ColumnStructures
import Spark.Core.Internal.ColumnFunctions
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.FunctionsInternals
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.TypesFunctions(structTypeFromFields)
import Spark.Core.Try
import Spark.Core.StructuresInternal(unsafeFieldName)
import Spark.Core.Internal.NodeBuilder(NodeBuilder, buildOpDDExtra, cniStandardOp)
import qualified Proto.Karps.Proto.Std as PStd

{-| Standard (inner) join on two sets of data.
-}
join :: Column ref1 key -> Column ref1 value1 -> Column ref2 key -> Column ref2 value2 -> Dataset (key, value1, value2)
join = joinInner

{-| Untyped version of the standard join.
-}
join' :: Column' -> Column' -> Column' -> Column' -> DataFrame
join' = joinInner'

{-| Explicit inner join.
-}
joinInner :: Column ref1 key -> Column ref1 value1 -> Column ref2 key -> Column ref2 value2 -> Dataset (key, value1, value2)
joinInner key1 val1 key2 val2 = unsafeCastDataset (forceRight df) where
  df = joinInner' (untypedCol key1) (untypedCol val1) (untypedCol key2) (untypedCol val2)

{-| Untyped version of the inner join.
-}
joinInner' :: Column' -> Column' -> Column' -> Column' -> DataFrame
joinInner' key1 val1 key2 val2 = do
  df1 <- pack' (struct' [key1, val1])
  df2 <- pack' (struct' [key2, val2])
  _ <- _joinTypeInner key1 val1 val2
  let extra = PStd.Join PStd.Join'INNER
  fromBuilder2Extra df1 df2 joinBuilder extra undefined undefined
  --
  -- let so = StandardOperator { soName = "org.spark.Join", soOutputType = dt, soExtra = p } where
  --       p = PStd.Join PStd.Join'INNER
  -- let ds = emptyDataset (NodeDistributedOp so) (SQLType dt)
  -- let f ds' = ds' { _cnParents = V.fromList [untyped df1, untyped df2] }
  -- return $ updateNode ds f

joinBuilder :: NodeBuilder
joinBuilder = buildOpDDExtra "org.spark.Join" f where
  f :: DataType -> DataType -> PStd.Join -> Try CoreNodeInfo
  f _ _ j = do
    let dt = error "joinBuilder: data type: "
    return $ cniStandardOp Distributed "org.spark.Join" dt j

{-| Broadcasts an observable alongside a dataset to make it available as an
extra column.
-}
-- This is the low-level operation that is used to implement the other
-- broadcast operations.
joinObs :: (HasCallStack) => Column ref val -> LocalData val' -> Dataset (val, val')
joinObs c ld =
  -- TODO: has a forcing at the last moment so that we can at least
  -- have stronger guarantees in the type coercion.
  unsafeCastDataset $ forceRight $ joinObs' (untypedCol c) (asObs' . pure . untypedLocalData $ ld)

{-| Broadcasts an observable along side a dataset to make it available as
an extra column.

The resulting dataframe has 2 columns:
 - one column called 'values'
 - one column called 'broadcast'

 Note: this is a low-level operation. Users may want to use broadcastObs instead.
-}
-- TODO: what is the difference with broadcastPair???
joinObs' :: Column' -> LocalFrame -> DataFrame
joinObs' dc lf = do
  let df = pack' dc
  dc' <- df
  c <- unColumn' (asCol' df)
  o <- unObservable' lf
  st <- structTypeFromFields [(unsafeFieldName "values", unSQLType (colType c)), (unsafeFieldName "broadcast", unSQLType (nodeType o))]
  let sqlt = SQLType (StrictType (Struct st))
  return $ emptyDataset NodeBroadcastJoin sqlt `parents` [untyped dc', untyped o]

_joinTypeInner :: Column' -> Column' -> Column' -> Try DataType
_joinTypeInner kcol col1 col2 = do
  cs <- sequence (unColumn' <$> [kcol, col1, col2])
  st <- structTypeFromFields $ (colFieldName &&& unSQLType . colType) <$> cs
  return $ StrictType (Struct st)
