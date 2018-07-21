module Spark.Core.JavaExports where

foreign export java "@static spark.core.JavaExports.sayHello" sayHelloEta :: IO Int
sayHelloEta = do
    putStrLn "Hi"
    return 1
