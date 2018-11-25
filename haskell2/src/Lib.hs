{-# LANGUAGE ForeignFunctionInterface #-}


module Lib
    ( someFunc
    ) where

import Foreign.C.Types
import Foreign.C.String
import Foreign
import Data.String
import Data.ByteString(packCStringLen, ByteString)
import Data.Text.Encoding(decodeUtf8, encodeUtf8)
import qualified Data.ByteString as BS
import Foreign.Marshal.Array(mallocArray, copyArray)
import Data.Text(pack)
import Data.ProtoLens.Encoding(decodeMessage, encodeMessage)
import Data.ProtoLens.Message(Message)
import Data.ProtoLens.Message(Message)
import Data.ProtoLens.Encoding(encodeMessage, decodeMessage)
import Data.ProtoLens.TextFormat(showMessage)
import Data.ProtoLens(def)
import Lens.Micro((&), (.~))

import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.Graph_Fields as PG
import qualified Proto.Karps.Proto.ApiInternal as PI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PI

import Lib3

someFunc :: IO ()
someFunc = putStrLn "someFunc"

fibonacci_hs :: CInt -> CInt
fibonacci_hs = fromIntegral . fibonacci . fromIntegral

input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)
input_hs l p l_out = do
  let len = (fromIntegral l) :: Int
  putStrLn $ "len=" ++ (show len)
  putStrLn $ "p=" ++ (show p)
  bs <- packCStringLen((p, len))
  putStrLn $ "bs=" ++ (show bs)
  let txt = decodeUtf8 bs
  putStrLn $ "txt=" ++ (show txt)
  poke l_out l
  putStrLn $ "l_out=" ++ (show l_out)
  let out = (pack "Hi there ") <> txt
  let out_bs = encodeUtf8 out
  BS.useAsCStringLen out_bs $ \(cs, cl) -> do
    let out_len = (fromIntegral cl) :: Int
    poke l_out (fromIntegral out_len)
    -- poke l_out (fromIntegral out_len)
    out_p <- mallocArray out_len
    copyArray out_p cs out_len
    return out_p

type CTrans = CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

transform_simple :: (ByteString -> ByteString) -> CTrans
transform_simple f l p l_out = do
  let len = (fromIntegral l) :: Int
  bs <- packCStringLen((p, len))
  let out_bs = f bs
  _return out_bs l_out

transform_io :: (ByteString -> IO ByteString) -> CTrans
transform_io f l p l_out = do
  let len = (fromIntegral l) :: Int
  bs <- packCStringLen((p, len))
  out_bs <- f bs
  _return out_bs l_out

_return :: ByteString -> Ptr CInt -> IO (Ptr CChar)
_return out_bs l_out = do
  BS.useAsCStringLen out_bs $ \(cs, cl) -> do
    let out_len = (fromIntegral cl) :: Int
    poke l_out (fromIntegral out_len)
    out_p <- mallocArray out_len
    copyArray out_p cs out_len
    return out_p

-- TODO: add a free function for the pointers that we return, they cannot be deallocated 
-- on the other side.

my_transform1 :: CTrans
my_transform1 = transform_simple f where
  f bs = out_bs where
    txt = decodeUtf8 bs
    out = (pack "Hi there ") <> txt
    out_bs = encodeUtf8 out


build_node :: CTrans
build_node = transform_io f where
  f bs = do
    let err_msg = (def :: PI.ErrorMessage) & PI.message .~ (pack "error message")
    let out_msg = (def :: PI.NodeBuilderResponse) & PI.error .~ err_msg
    return $ encodeMessage out_msg

--build_node_internal :: StructuredNodeBuilderRegistry -> OpName -> OpExtra -> [NodeShape] -> Try Node

foreign export ccall fibonacci_hs :: CInt -> CInt

foreign export ccall input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

foreign export ccall my_transform1 :: CTrans

foreign export ccall build_node :: CTrans

