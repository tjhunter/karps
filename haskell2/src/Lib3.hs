
module Lib3
    ( fibonacci,
      accessRegistry
    ) where

import Data.IORef
import System.IO.Unsafe(unsafePerformIO)

import Spark.Common.NodeBuilder(NodeBuilderRegistry, buildNodeRegistry)


-- The global session reference. Should not be accessed outside
-- this file.
_globalRegistryRef :: IORef NodeBuilderRegistry
{-# NOINLINE _globalRegistryRef #-}
_globalRegistryRef = unsafePerformIO (newIORef (buildNodeRegistry []))

accessRegistry :: IO NodeBuilderRegistry
accessRegistry = readIORef _globalRegistryRef

fibonacci :: Int -> Int
fibonacci n = fibs !! n
    where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
