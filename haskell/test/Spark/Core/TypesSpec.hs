{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Spark.Core.TypesSpec where

import GHC.Generics (Generic)
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck
import qualified Data.Text as T
import qualified Data.Vector as V

import Spark.Common.Utilities(failure)
import Spark.Core.Types
import Spark.Common.TypesFunctions
import Spark.Common.TypesStructures
import Spark.Common.StructuresInternal(unsafeFieldName)
import Spark.Common.TypesGenerics()


-- QUICKCHECK INSTANCES
-- TODO: move these outside to testing

instance Arbitrary StructField where
  arbitrary = do
    name <- elements ["_1", "a", "b", "abc"]
    dt <- arbitrary :: Gen DataType
    return $ StructField (unsafeFieldName $ T.pack name) dt

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


data TestStruct1 = TestStruct1 {
  ts1f1 :: Int,
  ts1f2 :: Maybe Int } deriving (Show, Generic)

instance SQLTypeable TestStruct1

data TestStruct2 = TestStruct2 { ts2f1 :: [Int] } deriving (Show, Generic, SQLTypeable)

data TestStruct3 = TestStruct3 { ts3f1 :: Int } deriving (Show, Generic, SQLTypeable)
data TestStruct4 = TestStruct4 { ts4f1 :: TestStruct3 } deriving (Show, Generic, SQLTypeable)

-- instance SQLTypeable TestStruct1
-- instance Menu TestStruct1


-- main :: IO ()
-- main = hspec spec

spec :: Spec
spec = do
  describe "Simple type tests" $ do
    it "show ints" $
      show intType `shouldBe` "int"

    it "show arrays" $
      show (arrayType' intType) `shouldBe` "[int]"

    it "show structures" $
      show (arrayType' (canNull intType)) `shouldBe` "[int?]"

  describe "The basic tests for int types" $ do
    it "ints" $
      let t = buildType :: (SQLType Int)
          dt = columnType t in
        dt `shouldBe` intType

    it "opt ints" $
      let t = buildType :: (SQLType (Maybe Int))
          dt = columnType t in
        dt `shouldBe` canNull intType

    -- The projection of all the product types
    it "opt opt ints" $
      let t = buildType :: (SQLType (Maybe (Maybe Int))) in
        columnType t `shouldBe` canNull intType

    it "array ints" $
      let t = buildType :: (SQLType [Int]) in
        columnType t `shouldBe` arrayType' intType

    it "array opt ints" $
      let t = buildType :: (SQLType [Maybe Int]) in
        columnType t `shouldBe` arrayType' (canNull intType)

    it "opt array ints" $
      let t = buildType :: (SQLType (Maybe [Int])) in
        columnType t `shouldBe` canNull (arrayType' intType)

  describe "The basic tests for records" $ do
    it "records with maybe" $
      let t = buildType :: (SQLType TestStruct1)
          out = structType [structField "ts1f1" intType, structField "ts1f2" (canNull intType)] in
        columnType t `shouldBe` out

    it "records with arrays" $
      let t = buildType :: (SQLType TestStruct2)
          out = structType [structField "ts2f1" (arrayType' intType)] in
        columnType t `shouldBe` out

    it "records within records" $
      let t = buildType :: (SQLType TestStruct4)
          out0 = structType [structField "ts3f1" intType]
          out = structType [structField "ts4f1" out0] in
        columnType t `shouldBe` out

  describe "Construction of frame types" $ do
    prop "frameTypeFromCol should be invertible" $
      \x ->
        let dt = colTypeFromFrame x
            y = frameTypeFromCol dt
        in x == y
    -- TODO this is not always working. Figure out the rules here.
    -- prop "colTypeFromFrame should be invertible" $
    --   \x -> (colTypeFromFrame . frameTypeFromCol) x == x
