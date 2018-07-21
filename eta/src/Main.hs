module Main where

import Primes
--import Spark.Core.Row
import Spark.Core.Internal.RowStructures

main :: IO ()
main = putStrLn $ "The 101st prime is " ++ show r where
    r = IntElement 3
