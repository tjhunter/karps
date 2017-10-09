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
import Spark.Core.Internal.TypesFunctions
import Spark.Core.Internal.RowGenericsFrom
import Spark.Core.Internal.TypesStructuresRepr(DataTypeElementRepr)

spec :: Spec
spec = do
  describe "Decoding data types"  $ do
    it "should decode DataTypeElementRepr" $ do
      let x = rowArray [rowArray [StringElement "ts3f1"],BoolElement True,IntElement 1,IntElement 0]
      let elt = cellToValue x :: TryS DataTypeElementRepr
      elt `shouldSatisfy` isRight
