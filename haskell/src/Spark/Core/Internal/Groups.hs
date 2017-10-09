{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

-- A number of standard aggregation functions.

module Spark.Core.Internal.Groups(
  GroupData,
  LogicalGroupData,
  -- Typed functions
  groupByKey,
  mapGroup,
  aggKey,
  groupAsDS
  -- Developer

) where

import qualified Data.Text as T
import qualified Data.Vector as V
import Formatting
import Debug.Trace(trace)

import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.ColumnStructures
import Spark.Core.Internal.ColumnFunctions(untypedCol, colType, colOp, iUntypedColData, castTypeCol, dropColReference, genColOp)
import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.LocalDataFunctions()
import Spark.Core.Internal.FunctionsInternals
import Spark.Core.Internal.TypesFunctions(tupleType, structTypeFromFields)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.RowStructures(Cell)
import Spark.Core.Try
import Spark.Core.StructuresInternal
import Spark.Core.Internal.CanRename
-- import Spark.Proto.Std(Shuffle(..))

{-| A dataset that has been partitioned according to some given field.
-}
data GroupData key val = GroupData {
  -- The dataset of reference for this group
  _gdRef :: !UntypedDataset,
  -- The columns used to partition the data by keys.
  _gdKey :: !GroupColumn,
  -- The columns that contain the values.
  _gdValue :: !GroupColumn
}

type LogicalGroupData = Try UntypedGroupData

-- A column in a group, that can be used either for key or for values.
-- It is different from the column data, because it does not include
-- broadcast data.
data GroupColumn = GroupColumn {
  _gcType :: !DataType,
  _gcOp :: !ColOp,
  _gcRefName :: !(Maybe FieldName)
} deriving (Eq, Show)


{-| (developper)

A group data type with no typing information.
-}
type UntypedGroupData = GroupData Cell Cell

{-| Performs a logical group of data based on a key.
-}
groupByKey :: (HasCallStack) => Column ref key -> Column ref val -> GroupData key val
groupByKey keys vals = forceRight $ _castGroup (colType keys) (colType vals) =<< _groupByKey (iUntypedColData keys) (iUntypedColData vals)

{-| Transforms the values in a group.
-}
-- This only allows direct transforms, so it is probably valid in all cases.
mapGroup :: GroupData key val -> (forall ref. Column ref val -> Column ref val') -> GroupData key val'
mapGroup g f =
  let c = _valueCol g
      c' = f (_unsafeCastColData c)
      -- Assume for now that there is no broadcast.
      -- TODO: deal with broadcast eventually
      gVals = forceRight $ _groupCol c'
  in g {  _gdValue = gVals }

{-| Given a group and an aggregation function, aggregates the data.

Note: not all the reduction functions may be used in this case. The analyzer
will fail if the function is not universal.
-}
-- TODO: it should be a try, this can fail
aggKey :: (HasCallStack) => GroupData key val -> (forall ref. Column ref val -> LocalData val') -> Dataset (key, val')
aggKey gd f = trace "aggKey" $
  let ugd = _untypedGroup gd
      keyt = traceHint "aggKey: keyt: " $  mapGroupKeys gd colType
      valt = traceHint "aggKey: valt: " $  mapGroupValues gd colType
      -- We call the function twice: the first one to recover the type info,
      -- and the second time to perform the unrolling.
      -- TODO we should be able to do it in one pass instead.
      fOut = traceHint "aggKey: fOut: " $  f (mapGroupValues gd dropColReference)
      valt' = traceHint "aggKey: valt': " $ nodeType fOut
      t = traceHint "aggKey: t: " $ tupleType keyt valt'
      f' c = untypedLocalData . f <$> castTypeCol valt c
      tud = traceHint "aggKey: tud: " $ _aggKey ugd f'
      res = castType' t tud
  in forceRight res

{-| Returns the collapsed representation of a grouped dataset, discarding group
information.
-}
groupAsDS :: forall key val. GroupData key val -> Dataset (key, val)
groupAsDS g = pack s where
  c1 = _unsafeCastColData (_keyCol g) :: Column UnknownReference key
  c2 = _unsafeCastColData (_valueCol g) :: Column UnknownReference val
  s = struct (c1, c2) :: Column UnknownReference (key, val)

mapGroupKeys :: GroupData key val -> (forall ref. Column ref key -> a) -> a
mapGroupKeys gd f =
  f (_unsafeCastColData (_keyCol gd))

mapGroupValues :: GroupData key val -> (forall ref. Column ref val -> a) -> a
mapGroupValues gd f =
  f (_unsafeCastColData (_valueCol gd))

-- ******** INSTANCES ***********


instance Show (GroupData key val) where
  show gd = T.unpack s where
    s = sformat ("GroupData[key="%sh%", val="%sh%"]") (_gdKey gd) (_gdValue gd)

-- ******** PRIVATE METHODS ********


_keyCol :: GroupData key val -> UntypedColumnData
_keyCol gd = ColumnData {
    _cOrigin = _gdRef gd,
    _cType = _gcType (_gdKey gd),
    _cOp = genColOp . _gcOp . _gdKey $ gd,
    _cReferingPath = _gcRefName . _gdKey $ gd
  }

_valueCol :: GroupData key val -> UntypedColumnData
_valueCol gd = ColumnData {
    _cOrigin = _gdRef gd,
    _cType = _gcType (_gdValue gd),
    _cOp = genColOp . _gcOp . _gdValue $ gd,
    _cReferingPath = _gcRefName . _gdValue $ gd
  }
-- dt: output type of the aggregation op
_applyAggOp :: (HasCallStack) => DataType -> AggOp -> UntypedGroupData -> UntypedDataset
_applyAggOp dt ao ugd = traceHint ("_applyAggOp dt=" <> show' dt <> " ao=" <> show' ao <> " ugd=" <> show' ugd <> " res=") $
  -- Reset the names to make sure there are no collision.
  let c1 = untypedCol (_keyCol ugd) @@ T.unpack "_1"
      c2 = untypedCol (_valueCol ugd) @@ T.unpack "_2"
      s = struct' [c1, c2]
      p = pack' s
      ds = forceRight p
      -- The structure of the result dataframe
      keyDt = unSQLType (colType (_keyCol ugd))
      st' = structTypeFromFields [(unsafeFieldName "key", keyDt), (unsafeFieldName "agg", dt)]
      -- The keys are different, so we know we this operation is legit:
      st = forceRight st'
      resDt = SQLType . StrictType . Struct $ st
      ds2 = emptyDataset (NodeGroupedReduction ao) resDt `parents` [untyped ds]
  in ds2

-- TODO: this should be moved to ColumnFunctions
_transformCol :: ColOp -> UntypedColumnData -> UntypedColumnData
-- TODO: at this point, it should be checked for correctness (the fields
-- being extracted should exist)
_transformCol co ucd = ucd { _cOp = genColOp co }

-- Takes a column operation and chain it with another column operation.
_combineColOp :: ColOp -> ColOp -> Try ColOp
_combineColOp _ (ColBroadcast _) = missing "_combineColOp: ColBroadcast"
_combineColOp _ (x @ (ColLit _ _)) = pure x
_combineColOp x (ColFunction fn v _) =
  (\x' -> ColFunction fn x' Nothing) <$> sequence (_combineColOp x <$> v)
_combineColOp x (ColExtraction fp) = _extractColOp x (V.toList (unFieldPath fp))
_combineColOp x (ColStruct v) =
  ColStruct <$> sequence (f <$> v) where
    f (TransformField n val) = TransformField n <$> _combineColOp x val

_extractColOp :: ColOp -> [FieldName] -> Try ColOp
_extractColOp x [] = pure x
_extractColOp (ColStruct s) (fn : t) =
  case V.find (\x -> tfName x == fn) s of
    Just (TransformField _ co) ->
      _extractColOp co t
    Nothing ->
      tryError $ sformat ("Expected to find field "%sh%" in structure "%sh) fn s
_extractColOp x y =
  tryError $ sformat ("Cannot perform extraction "%sh%" on column operation "%sh) y x

_aggKey :: UntypedGroupData -> (UntypedColumnData -> Try UntypedLocalData) -> Try UntypedDataset
_aggKey = error "_aggKey: not implemented"

_unsafeCastColData :: Column ref a -> Column ref' a'
_unsafeCastColData c = c { _cType = _cType c }

{-| Checks that the group can be cast.
-}
_castGroup ::
  SQLType key -> SQLType val -> UntypedGroupData -> Try (GroupData key val)
_castGroup (SQLType keyType) (SQLType valType) ugd =
  let keyType' = unSQLType . colType . _keyCol $ ugd
      valType' = unSQLType . colType . _valueCol $ ugd in
  if keyType == keyType'
  then if valType == valType'
    then
      pure ugd { _gdRef = _gdRef ugd }
    else
      tryError $ sformat ("The value column (of type "%sh%") cannot be cast to type "%sh) valType' valType
  else
    tryError $ sformat ("The value column (of type "%sh%") cannot be cast to type "%sh) keyType' keyType

_untypedGroup :: GroupData key val -> UntypedGroupData
_untypedGroup gd = gd { _gdRef = _gdRef gd }

_groupByKey :: UntypedColumnData -> UntypedColumnData -> LogicalGroupData
_groupByKey = undefined

_groupCol :: Column ref a -> Try GroupColumn
_groupCol c = do
  co <- colOpNoBroadcast (colOp c)
  return GroupColumn {
            _gcType = unSQLType $ colType c,
            _gcOp = co,
            _gcRefName = Nothing
           }
