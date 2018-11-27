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
import Data.Text(pack, Text)
import Data.ProtoLens.Encoding(decodeMessage, encodeMessage)
import Data.ProtoLens.Message(Message)
import Data.ProtoLens.TextFormat(showMessage)
import Data.ProtoLens(def)
import Lens.Micro((&), (.~), (^.))

import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.Graph_Fields as PG
import qualified Proto.Karps.Proto.ApiInternal as PI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PI
import Spark.Common.OpStructures(CoreNodeInfo, OpExtra, OperatorName, Locality(..))
import Spark.Common.ProtoUtils(FromProto(..), extractMaybe, extractMaybe')
import Spark.Common.StructuresInternal(NodePath)
import Spark.Common.TypesStructures(DataType)
import Spark.Common.Try(Try(..), tryError)

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


-- Node building

data ParsedNode = ParsedNode {
  pnLocality :: !Locality,
  pnPath :: !NodePath,
  pnOpName :: !OperatorName,
  pnExtra :: !OpExtra,
  pnParents :: ![NodePath],
  pnDeps :: ![NodePath],
  pnType :: !DataType
} deriving (Show)

data NodeBuilderRequest = NodeBuilderRequest !OperatorName !OpExtra [ParsedNode]

instance FromProto PI.NodeBuilderRequest NodeBuilderRequest where
  fromProto nbr = do
    let on = nbr ^. PI.opName
    oe <- fromProto (nbr ^. PI.extra)
    let z = nbr ^. PI.parents
    ps <- sequence $ fromProto <$> (nbr ^. PI.parents) :: Try [ParsedNode]
    return $ NodeBuilderRequest on oe []


instance FromProto PG.Node ParsedNode where
  fromProto pn = do
    p <- extractMaybe' pn PG.maybe'path "path"
    extra <- extractMaybe' pn PG.maybe'opExtra "op_extra"
    parents' <- sequence $ fromProto <$> (pn ^. PG.parents)
    deps <- sequence $ fromProto <$> (pn ^. PG.logicalDependencies)
    dt <- extractMaybe' pn PG.maybe'inferedType "infered_type"
    let loc = case pn ^. PG.locality of
          PG.DISTRIBUTED -> Distributed
          PG.LOCAL -> Local
    return ParsedNode {
      pnLocality = loc,
      pnPath = p,
      pnOpName = pn ^. PG.opName,
      pnExtra = extra,
      pnParents = parents',
      pnDeps = deps,
      pnType = dt
    }


build_node :: CTrans
build_node = transform_io f where
  process_msg op_name extra parents registry = out_msg where
    case registry `registryNode` pnOpName op_name of
      Nothing -> tryError $ sformat ("_buildNode: could not find op name '"%sh%"' in the registry") (pnOpName pn)
      Just nb' -> undefined

    err_msg = (def :: PI.ErrorMessage) & PI.message .~ (pack "error message")
    out_msg = (def :: PI.NodeBuilderResponse) & PI.error .~ err_msg
  error_msg txt = out_msg where
      err_msg = (def :: PI.ErrorMessage) & PI.message .~ (pack "error message")
      out_msg = (def :: PI.NodeBuilderResponse) & PI.error .~ err_msg
  f :: ByteString -> IO ByteString
  f bs = do
    registry <- accessRegistry
    let out = case decodeMessage bs of
          Left txt -> error_msg txt
          Right (nbr :: PI.NodeBuilderRequest) -> case fromProto nbr of
            Left txt -> error_msg txt
            Right (NodeBuilderRequest op_name extra parents) ->
                process_msg op_name extra parents registry
    return $ encodeMessage out


--build_node_internal :: StructuredNodeBuilderRegistry -> OpName -> OpExtra -> [NodeShape] -> Try Node

foreign export ccall fibonacci_hs :: CInt -> CInt

foreign export ccall input_hs :: CInt -> Ptr CChar -> Ptr CInt -> IO (Ptr CChar)

foreign export ccall my_transform1 :: CTrans

foreign export ccall build_node :: CTrans
