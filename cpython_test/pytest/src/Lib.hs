{-# LANGUAGE ForeignFunctionInterface #-}


module Lib
    ( someFunc
    ) where

import Foreign.C.Types
import Foreign.C.String
import Data.String
import Lib2

someFunc :: IO ()
someFunc = putStrLn "someFunc"



fibonacci_hs :: CInt -> CInt
fibonacci_hs = fromIntegral . fibonacci . fromIntegral

foreign export ccall fibonacci_hs :: CInt -> CInt

