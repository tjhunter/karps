
module Lib3
    ( fibonacci,
      accessRegistry
    ) where

import Data.IORef
import System.IO.Unsafe(unsafePerformIO)

import Spark.Common.NodeBuilder(NodeBuilderRegistry, buildNodeRegistry)
import Spark.Common.Utilities(traceHint)
import Spark.Standard.Base

-- The global session reference. Should not be accessed outside
-- this file.
_globalRegistryRef :: IORef NodeBuilderRegistry
{-# NOINLINE _globalRegistryRef #-}
_globalRegistryRef = unsafePerformIO (newIORef reg) where
  reg = traceHint "building node registry" $ buildNodeRegistry builtins
  builtins = [literalBuilderD]

accessRegistry :: IO NodeBuilderRegistry
accessRegistry = readIORef _globalRegistryRef

fibonacci :: Int -> Int
fibonacci n = fibs !! n
    where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
