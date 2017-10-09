{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

module Spark.Core.GroupsSpec where

import Test.Hspec
import Data.Text(Text)

import Spark.Core.Context
import Spark.Core.Functions
import qualified Spark.Core.ColumnFunctions as C
import Spark.Core.Column
import Spark.Core.IntegrationUtilities
import Spark.Core.CollectSpec(run)
import Spark.Core.SimpleAddSpec(xrun)
import Spark.Core.Internal.Groups

sumGroup :: [MyPair] -> [(Text, Int)] -> IO ()
sumGroup l lexp = do
  let ds = dataset l
  let keys = ds // myKey'
  let values = ds // myVal'
  let g = groupByKey keys values
  let ds2 = g `aggKey` C.sum
  l2 <- exec1Def $ collect (asCol ds2)
  l2 `shouldBe` lexp

spec :: Spec
spec = do
  describe "Integration test - groups on (text, int)" $ do
    xrun "empty" $
      sumGroup [] []
    xrun "one" $
      sumGroup [MyPair "x" 1] [("x", 1)]
    xrun "two" $
      sumGroup [MyPair "x" 1, MyPair "x" 2, MyPair "y" 1] [("x", 3), ("y", 1)]
