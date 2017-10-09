{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Spark.Core.Internal.RowUtils(
  -- jsonToCell,
  checkCell,
  rowArray,
  rowCell,
  cellFromProto,
  cellWithTypeFromProto,
  cellWithTypeToProto
) where

-- import Data.Aeson
import Data.Text(Text)
import Data.Maybe(catMaybes, listToMaybe)
import Formatting
import qualified Data.Vector as V
import Control.Monad.Except

import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.RowStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Try
import Spark.Core.Internal.ProtoUtils
import qualified Proto.Karps.Proto.Row as P

type TryCell = Either Text Cell

instance FromProto P.CellWithType (Cell, DataType) where
  fromProto cwt = tryEither $ cellWithTypeFromProto cwt


cellFromProto :: DataType -> P.Cell -> TryCell
cellFromProto (NullableType _) (P.Cell Nothing) = pure Empty
cellFromProto (StrictType sdt) (P.Cell Nothing) =
  throwError $ sformat ("cellFromProto: nothing given on a strict type: "%sh%", got null") sdt
cellFromProto dt (P.Cell (Just ce)) = x where
  sdt = case dt of
    StrictType sdt' -> sdt'
    NullableType sdt' -> sdt'
  x = case (sdt, ce) of
    (IntType, P.Cell'IntValue i) -> pure $ IntElement (fromIntegral i)
    (DoubleType, P.Cell'DoubleValue d) -> pure $ DoubleElement d
    (StringType, P.Cell'StringValue s) -> pure $ StringElement s
    (BoolType, P.Cell'BoolValue b) -> pure $ BoolElement b
    (ArrayType dt', P.Cell'ArrayValue (P.ArrayCell l)) ->
      RowArray . V.fromList <$> sequence (cellFromProto dt' <$> l)
    (Struct (StructType v), P.Cell'StructValue (P.Row l)) ->
      if length l /= V.length v
      then throwError $ sformat ("cellFromProto: struct: got "%sh%" values but structure has "%sh%" elements") (length l) (length v)
      else RowElement . Row <$> sequence (f <$> l') where
        f (StructField _ dt', v') = cellFromProto dt' v'
        l' = V.zip v (V.fromList l)
    _ -> throwError $ sformat ("cellFromProto: mismatch "%sh) (sdt, ce)



cellWithTypeFromProto :: P.CellWithType -> Either Text (Cell, DataType)
cellWithTypeFromProto (P.CellWithType (Just c) (Just pdt)) = do
  dt <- case fromProto pdt of
    Right x -> Right x
    Left s -> Left (show' s) -- TODO: this is bad.
  cell <- cellFromProto dt c
  return (cell, dt)
cellWithTypeFromProto cwt =
  throwError $ sformat ("cellWithTypeFromProto: missing data in "%sh) cwt

cellWithTypeToProto :: DataType -> Cell -> Either Text P.CellWithType
cellWithTypeToProto dt c = do
  _ <- checkCell dt c
  return $ P.CellWithType (Just (toProto c)) (Just (toProto dt))


{-| Given a datatype, ensures that the cell has the corresponding type.
-}
checkCell :: DataType -> Cell -> Either Text Cell
checkCell dt c = case _checkCell dt c of
  Nothing -> pure c
  Just txt -> throwError txt

{-| Convenience constructor for an array of cells.
-}
rowArray :: [Cell] -> Cell
rowArray = RowArray . V.fromList

rowCell :: [Cell] -> Cell
rowCell = RowElement . Row . V.fromList

-- Returns an error message if something wrong is found
_checkCell :: DataType -> Cell -> Maybe Text
_checkCell dt c = case (dt, c) of
  (NullableType _, Empty) -> Nothing
  (StrictType _, Empty) ->
    pure $ sformat ("Expected a strict value of type "%sh%" but no value") dt
  (StrictType sdt, x) -> _checkCell' sdt x
  (NullableType sdt, x) -> _checkCell' sdt x

-- Returns an error message if something wrong is found
_checkCell' :: StrictDataType -> Cell -> Maybe Text
_checkCell' sdt c = case (sdt, c) of
  (_, Empty) ->
    pure $ sformat ("Expected a strict value of type "%sh%" but no value") sdt
  (IntType, IntElement _) -> Nothing
  (DoubleType, DoubleElement _) -> Nothing
  (StringType, StringElement _) -> Nothing
  (BoolType, BoolElement _) -> Nothing
  (Struct s, RowElement (Row l)) -> _checkCell' (Struct s) (RowArray l)
  (Struct (StructType fields), RowArray cells') ->
    if V.length fields == V.length cells'
      then
        let types = V.toList $ structFieldType <$> fields
            res = uncurry _checkCell <$> (types `zip` V.toList cells')
        in listToMaybe (catMaybes res)
      else
        pure $ sformat ("Struct "%sh%" has "%sh%" fields, asked to be matched with "%sh%" cells") sdt (V.length fields) (V.length cells')
  (ArrayType dt, RowArray cells') ->
    let res = uncurry _checkCell <$> (repeat dt `zip` V.toList cells')
    in listToMaybe (catMaybes res)
  (_, _) ->
    pure $ sformat ("Type "%sh%" is incompatible with cell content "%sh) sdt c
