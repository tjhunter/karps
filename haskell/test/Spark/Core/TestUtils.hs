
module Spark.Core.TestUtils where

import Test.Hspec

xit2 :: String -> IO () -> SpecWith (Arg (IO ()))
xit2 s f = it s $ do
  pendingWith s
  return ()
