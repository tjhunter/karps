{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Control.Monad.IO.Class
import Data.Default
import Data.Text(pack)
import Data.ProtoLens.Encoding(decodeMessage, encodeMessage)
import Data.ProtoLens.TextFormat(showMessage)
import qualified Data.ByteString.Lazy as LBS
import Debug.Trace
import Lens.Family2 ((&), (.~))

import Spark.Server.Transform(transform)
import Spark.Core.Internal.BrainStructures(CompilerConf)
import qualified Proto.Karps.Proto.ApiInternal as PAI


-- It should be a graph transform
serverFunction :: LBS.ByteString -> LBS.ByteString
serverFunction bs = res' where
  conf = def :: CompilerConf
  msg_ = decodeMessage (LBS.toStrict bs)
  _s (Right z) = showMessage z
  _s (Left msg) = show msg
  msg' = trace ("serverFunction: msg=" ++ _s msg_) msg_
  x = case msg' of
      Right pgt -> transform conf pgt
      Left txt -> msg where
        msg0 = def :: PAI.GraphTransformResponse
        am = (def :: PAI.AnalysisMessage) & PAI.content .~ pack txt
        msg = msg0 & PAI.messages .~ [am]
  x' = trace ("serverFunction: res=" ++ showMessage x) x
  res = LBS.fromStrict . encodeMessage $ x'
  res' = trace ("serverFunction: res length = " ++ show (LBS.length res)) res


main :: IO ()
main = do
  _ <- liftIO $ mkRequestLogger def { outputFormat = Apache FromHeader }
  scotty 1234 $ do
      get "/alive" $ do
          text "yep!"
      post "/perform_transform" $ (do
        item <- body
        setHeader "Content-Type" "application/octet-stream"
        raw (serverFunction item)) `rescue` (\msg -> trace ("main: rescue:" ++ show msg) (text msg))
