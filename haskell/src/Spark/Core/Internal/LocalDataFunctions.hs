{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- A number of functions related to local data.

module Spark.Core.Internal.LocalDataFunctions(
  constant,
  iPackTupleObs
) where

import qualified Data.Text as T
import qualified Data.List.NonEmpty as N
import qualified Data.Vector as V
import Control.Exception.Base(assert)

import Spark.Core.Internal.DatasetFunctions
import Spark.Core.Internal.DatasetStructures
import Spark.Core.Internal.TypesFunctions
import Spark.Core.Internal.TypesStructures
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.TypesGenerics(SQLTypeable, buildType)
import Spark.Core.StructuresInternal(emptyFieldPath)
import Spark.Core.Row

constant :: (ToSQL a, SQLTypeable a) => a -> LocalData a
constant cst =
  let
    sqlt = buildType
    dt = unSQLType sqlt
  in emptyLocalData (NodeLocalLit dt (valueToCell cst)) sqlt

{-| (developer API)

This function takes a non-empty list of observables and puts them
into a structure. The names of each element is _0 ... _(n-1)
-}
iPackTupleObs :: N.NonEmpty UntypedLocalData -> UntypedLocalData
iPackTupleObs ulds =
  let dt = structTypeTuple' (unSQLType . nodeType <$> ulds)
      so = StandardOperator {
                soName = "org.spark.LocalPack",
                soOutputType = dt,
                soExtra = emptyExtra }
      op = NodeLocalOp so
  in emptyLocalData op (SQLType dt)
        `parents` (untyped <$> N.toList ulds)

instance (Num a, ToSQL a, SQLTypeable a) => Num (LocalData a) where
  (+) = _binOp "plus"
  (-) = _binOp "minus"
  (*) = _binOp "multiply"
  abs = _unaryOp "abs"
  signum = _unaryOp "signum"
  fromInteger x = constant (fromInteger x :: a)
  negate = _unaryOp "negate"

instance forall a. (ToSQL a, Enum a, SQLTypeable a) => Enum (LocalData a) where
  toEnum x = constant (toEnum x :: a)
  fromEnum = failure "Cannot use fromEnum against a local data object"
  -- TODO(kps) some of the others are still available for implementation

instance (Num a, Ord a) => Ord (LocalData a) where
  compare = failure "You cannot compare instances of LocalData. (yet)."
  min = _binOp "min"
  max = _binOp "max"

instance forall a. (Real a, ToSQL a, SQLTypeable a) => Real (LocalData a) where
  toRational = failure "Cannot convert LocalData to rational"

instance (ToSQL a, Integral a, SQLTypeable a) => Integral (LocalData a) where
  quot = _binOp "quotient"
  rem = _binOp "reminder"
  div = _binOp "divide"
  mod = _binOp "mod"
  quotRem = failure "quotRem is not implemented (yet). Use quot and rem."
  divMod = failure "divMod is not implemented (yet). Use div and mod."
  toInteger = failure "Cannot convert LocalData to integer"

instance (ToSQL a, SQLTypeable a, Fractional a) => Fractional (LocalData a) where
  fromRational x = constant (fromRational x :: a)
  (/) = _binOp "divide"


_unaryOp :: T.Text -> LocalData a -> LocalData a
_unaryOp optxt ld = emptyLocalData op resDt `parents` [untyped ld] where
  -- The return type is assumed to be the same as the input type.
  resDt = nodeType ld
  resDt' = unSQLType resDt
  op = NodeLocalStructuredTransform co
  co' = ColExtraction emptyFieldPath
  co = ColFunction optxt (V.singleton co') (Just resDt')

-- Homogeneous binary operators.
-- This implementation uses broadcasts, so it needs to be passed through the
-- compiler to be effective.
_binOp :: T.Text -> LocalData a -> LocalData a -> LocalData a
_binOp optxt ld1 ld2 = assert (nodeType ld1 == nodeType ld2) $
  emptyLocalData op resDt `parents` [untyped ld1, untyped ld2] where
    -- The return type is assumed to be the same as the input type.
    resDt = nodeType ld1
    resDt' = unSQLType resDt
    op = NodeLocalStructuredTransform co
    co1 = ColBroadcast 0
    co2 = ColBroadcast 1
    co = ColFunction optxt (V.fromList [co1, co2]) (Just resDt')
