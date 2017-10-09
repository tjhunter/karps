
module Spark.Core.TestUtils where

import Test.Hspec

xit :: String -> IO () -> SpecWith (Arg (IO ()))
xit s f = it s $ do
  pendingWith s
  return ()
