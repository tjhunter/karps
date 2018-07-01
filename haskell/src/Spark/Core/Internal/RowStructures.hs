{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Spark.Core.Internal.RowStructures where

import Data.Vector(Vector)
import qualified Data.Vector as V
import qualified Data.Text as T
import Data.ProtoLens(def)
import Lens.Micro((&), (.~))

import Spark.Core.Internal.ProtoUtils
import qualified Proto.Karps.Proto.Row as P
import qualified Proto.Karps.Proto.Row_Fields as P

-- | The basic representation of one row of data. This is a standard type that comes out of the
-- SQL engine in Spark.

-- | An element in a Row object.
-- All objects manipulated by the Spark framework are assumed to
-- be convertible to cells.
--
-- This is usually handled by generic transforms.
data Cell =
    Empty -- To represent maybe
    | IntElement !Int
    | DoubleElement !Double
    | StringElement !T.Text
    | BoolElement !Bool
    | RowArray !(Vector Cell)
    | RowElement !Row deriving (Show, Eq)

-- | A Row of data: the basic data structure to transport information
-- TODO rename to rowCells
data Row = Row {
    cells :: !(Vector Cell)
  } deriving (Show, Eq)


instance ToProto P.Cell Cell where
  toProto c = cellToProto c where
    cellToProto :: Cell -> P.Cell
    cellToProto Empty = def
    cellToProto (IntElement i) = def & P.intValue .~ (fromIntegral i)
    cellToProto (DoubleElement i) = def & P.doubleValue .~ i
    cellToProto (StringElement i) = def & P.stringValue .~ i
    cellToProto (BoolElement i) = def & P.boolValue .~ i
    cellToProto (RowArray v) = def & P.arrayValue .~ (def & P.values .~ v') where
      v' = cellToProto <$> V.toList v
    cellToProto (RowElement (Row v)) = def & P.structValue .~ (def & P.values .~ v') where
      v' = cellToProto <$> V.toList v
