{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE QuasiQuotes #-}

module Spark.Core.Internal.OpFunctionsSpec where

import Test.Hspec
import Text.RawString.QQ

import Spark.Core.Functions
import Spark.Core.TestUtils
import Spark.Core.Internal.OpFunctions
import Spark.Core.Internal.DatasetFunctions


spec :: Spec
spec = do
  describe "extraNodeOpData" $ do
    xit "should have the content of a constant dataset" $ do
      let l = [1,2,3] :: [Int]
      let res = undefined
          -- res = decode
          --     ([r|{
          --       "cell" : {
          --         "arrayValue" : {
          --           "values": [{
          --             "intValue": 1.0
          --           }, {
          --             "intValue": 2.0
          --           }, {
          --             "intValue": 3.0
          --           }]
          --         }
          --       },
          --       "cellType": {
          --         "nullable": false,
          --         "arrayType": {
          --           "basicType": "INT",
          --           "nullable": false
          --         }
          --       }
          --     }|])
      let ds = dataset l
      let d = extraNodeOpData . nodeOp $ ds
      Just d `shouldBe` undefined--res
