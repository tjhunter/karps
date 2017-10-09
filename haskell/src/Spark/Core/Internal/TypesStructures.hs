{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

{-| The structures of data types in Karps.

For a detailed description of the supported types, see
http://spark.apache.org/docs/latest/sql-programming-guide.html#data-types

At a high-level, Spark DataFrames and Datasets are equivalent to lists of
objects whose type can be mapped to the same StructType:
Dataset a ~ ArrayType StructType (...)
Columns of a dataset are equivalent to lists of object whose type can be
mapped to the same DataType (either Strict or Nullable)
Local data (or "blobs") are single elements whose type can be mapped to a
DataType (either strict or nullable)
-}
module Spark.Core.Internal.TypesStructures where

-- import Data.Aeson
import Data.Vector(Vector)
import qualified Data.Vector as V
-- import qualified Data.Aeson as A
import qualified Data.Text as T
import GHC.Generics(Generic)
import Test.QuickCheck
import Lens.Family2 ((^.))
import Formatting

import Spark.Core.StructuresInternal(FieldName(..))
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Try
import qualified Proto.Karps.Proto.Types as P


-- The core type algebra

-- | The data types that are guaranteed to not be null: evaluating them will return a value.
data StrictDataType =
    IntType
  | DoubleType
  | StringType
  | BoolType
  | Struct !StructType
  | ArrayType !DataType
  deriving (Eq)

-- | All the data types supported by the Spark engine.
-- The data types can either be nullable (they may contain null values) or strict (all the values are present).
-- There are a couple of differences with the algebraic data types in Haskell:
-- Maybe (Maybe a) ~ Maybe a which implies that arbitrary nesting of values will be flattened to a top-level Nullable
-- Similarly, [[]] ~ []
data DataType =
    StrictType !StrictDataType
  | NullableType !StrictDataType deriving (Eq)

-- | A field in a structure
data StructField = StructField {
  structFieldName :: !FieldName,
  structFieldType :: !DataType
} deriving (Eq)

-- | The main structure of a dataframe or a dataset
data StructType = StructType {
  structFields :: !(Vector StructField)
} deriving (Eq)


-- Convenience types

-- | Represents the choice between a strict and a nullable field
data Nullable = CanNull | NoNull deriving (Show, Eq)

-- | Encodes the type of all the nullable data types
data NullableDataType = NullableDataType !StrictDataType deriving (Eq)

-- | A tagged datatype that encodes the sql types
-- This is the main type information that should be used by users.
data SQLType a = SQLType {
  -- | The underlying data type.
  unSQLType :: !DataType
} deriving (Eq, Generic)


instance Show DataType where
  show (StrictType x) = show x
  show (NullableType x) = show x ++ "?"

instance Show StrictDataType where
  show StringType = "string"
  show DoubleType = "double"
  show IntType = "int"
  show BoolType = "bool"
  show (Struct struct) = show struct
  show (ArrayType at) = "[" ++ show at ++ "]"

instance Show StructField where
  show field = (T.unpack . unFieldName . structFieldName) field ++ ":" ++ s where
    s = show $ structFieldType field

instance Show StructType where
  show struct = "{" ++ unwords (map show (V.toList . structFields $ struct)) ++ "}"

instance Show (SQLType a) where
  show (SQLType dt) = show dt


instance FromProto P.SQLType DataType where
  fromProto sqlt = f <$> sdt where
    f = if sqlt ^. P.nullable then NullableType else StrictType
    sdt = case sqlt ^. P.maybe'strictType of
      Nothing -> tryError $ sformat ("dataTypeFromProto: missing strictType "%sh) sqlt
      Just (P.SQLType'BasicType P.SQLType'UNUSED) -> tryError $ sformat ("dataTypeFromProto: basic type is UNUSED "%sh) sqlt
      Just (P.SQLType'BasicType P.SQLType'INT) -> pure IntType
      Just (P.SQLType'BasicType P.SQLType'DOUBLE) -> pure DoubleType
      Just (P.SQLType'BasicType P.SQLType'STRING) -> pure StringType
      Just (P.SQLType'BasicType P.SQLType'BOOL) -> pure BoolType
      Just (P.SQLType'ArrayType sqlt') -> ArrayType <$> fromProto sqlt'
      Just (P.SQLType'StructType (P.StructType l)) -> Struct . StructType <$> v where
        f' (P.StructField fn (Just sqlt')) = StructField (FieldName fn) <$> fromProto sqlt'
        f' (P.StructField fn Nothing) = tryError $ sformat ("dataTypeFromProto: missing field type for "%sh) fn
        v = V.fromList <$> sequence (f' <$> l)

instance ToProto P.SQLType DataType where
  toProto dt = P.SQLType nl (Just x) where
    nl = case dt of
      StrictType _ -> False
      NullableType _ -> True
    _struct (StructType v) = P.StructType l where
      f (StructField n dt') = P.StructField (unFieldName n) (Just (toProto dt'))
      l = f <$> V.toList v
    _st IntType = P.SQLType'BasicType P.SQLType'INT
    _st DoubleType = P.SQLType'BasicType P.SQLType'DOUBLE
    _st StringType = P.SQLType'BasicType P.SQLType'STRING
    _st BoolType = P.SQLType'BasicType P.SQLType'BOOL
    _st (Struct st') = P.SQLType'StructType (_struct st')
    _st (ArrayType dt') = P.SQLType'ArrayType (toProto dt')
    x = case dt of
      (StrictType x') -> _st x'
      (NullableType x') -> _st x'

-- QUICKCHECK INSTANCES
-- TODO: move these outside to testing

instance Arbitrary StructField where
  arbitrary = do
    name <- elements ["_1", "a", "b", "abc"]
    dt <- arbitrary :: Gen DataType
    return $ StructField (FieldName $ T.pack name) dt

instance Arbitrary StructType where
  arbitrary = do
    fields <- listOf arbitrary
    return . StructType . V.fromList $ fields

instance Arbitrary StrictDataType where
  arbitrary = do
    idx <- elements [1,2] :: Gen Int
    return $ case idx of
      1 -> StringType
      2 -> IntType
      _ -> failure "Arbitrary StrictDataType"

instance Arbitrary DataType where
  arbitrary = do
    x <- arbitrary
    u <- arbitrary
    return $ if x then
      StrictType u
    else
      NullableType u
