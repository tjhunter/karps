{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Spark.Core.Internal.RowUtilsSpec where

import Data.Maybe(fromJust)
import Test.Hspec
import Data.ByteString.Lazy(ByteString)
import qualified Data.Vector as V
import Data.Either(isRight)

import Spark.Core.Types
import Spark.Core.Row
import Spark.Common.TypesFunctions
import Spark.Common.RowGenericsFrom
import Spark.Common.TypesStructuresRepr(DataTypeElementRepr)

spec :: Spec
spec = do
  describe "Decoding data types"  $ do
    it "should decode DataTypeElementRepr" $ do
      let x = rowArray [rowArray [StringElement "ts3f1"],BoolElement True,IntElement 1,IntElement 0]
      let elt = cellToValue x :: TryS DataTypeElementRepr
      elt `shouldSatisfy` isRight
