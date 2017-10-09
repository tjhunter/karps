{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Spark.IO.Internal.InputStructures(
  -- SparkPath(..),
  DataSchema(..),
  InputOptionValue(..),
  InputOptionKey(..),
  DataFormat(..),
  SourceDescription(..),
  extractResourcePath,
  updateResourceStamp
) where

import qualified Data.Map.Strict as M
import Data.Text(Text)
import Lens.Family2((^.), (&), (.~))
import Data.ProtoLens.Message(def)

import Spark.Core.Types
import Spark.Core.Try

import Spark.Core.Internal.BrainStructures(ResourcePath, resourcePath, unResourcePath)
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.OpFunctions(decodeExtra', convertToExtra')
import Spark.Core.Internal.ProtoUtils
import qualified Proto.Karps.Proto.Io as PIO

{-| A path to some data that can be read by Spark.
-}
-- newtype SparkPath = SparkPath {unSparkPath :: Text } deriving (Show, Eq)

{-| The schema policty with respect to a data source. It should either
request Spark to infer the schema from the source, or it should try to
match the source against a schema provided by the user.
-}
data DataSchema = InferSchema | UseSchema DataType deriving (Show, Eq)

{-| The low-level option values accepted by the Spark reader API.
-}
data InputOptionValue =
    InputIntOption Int
  | InputDoubleOption Double
  | InputStringOption Text
  | InputBooleanOption Bool
  deriving (Eq, Show)

newtype InputOptionKey = InputOptionKey { unInputOptionKey :: Text } deriving (Eq, Show, Ord)

{-| The type of the source.

This enumeration contains all the data formats that are natively supported by
Spark, either for input or for output, and allows the users to express their
own format if requested.
-}
data DataFormat =
    JsonFormat
  | TextFormat
  | CsvFormat
  | CustomSourceFormat !Text
  deriving (Eq, Show)

{-| A description of a data source, following Spark's reader API version 2.

Eeach source constists in an input source (json, xml, etc.), an optional schema
for this source, and a number of options specific to this source.

Since this descriptions is rather low-level, a number of wrappers of provided
for each of the most popular sources that are already built into Spark.
-}
data SourceDescription = SourceDescription {
  inputPath :: !ResourcePath,
  inputSource :: !DataFormat,
  inputSchema :: !DataSchema,
  sdOptions :: !(M.Map InputOptionKey InputOptionValue),
  inputStamp :: !(Maybe DataInputStamp)
} deriving (Eq, Show)

-- instance IsString SparkPath where
--   fromString = SparkPath . T.pack


instance FromProto PIO.SourceDescription SourceDescription where
  fromProto sd = do
    df <- _dataFormatFromProto (sd ^. PIO.source)
    s <- case sd ^. PIO.maybe'schema of
          Nothing -> pure InferSchema
          Just p -> UseSchema <$> fromProto p
    rp <- resourcePath (sd ^. PIO.path)
    let st = case sd ^. PIO.stamp of
          "" -> Nothing
          x -> Just (DataInputStamp x)
    return SourceDescription {
      inputPath = rp,
      inputSource = df,
      inputSchema = s,
      sdOptions = M.empty, -- TODO: not parsing options for now.
      inputStamp = st
    }

instance ToProto PIO.SourceDescription SourceDescription where
  toProto sd = msg2 where
    msg0 = (def :: PIO.SourceDescription)
        & PIO.path .~ unResourcePath (inputPath sd)
        & PIO.source .~ s where
          s = case inputSource sd of
            JsonFormat -> "json"
            _ -> "" -- TODO: dropping everything else for now.
    msg1 = case inputStamp sd of
      Nothing -> msg0
      Just (DataInputStamp x) -> msg0 & PIO.stamp .~ x
    msg2 = case inputSchema sd of
      InferSchema -> msg1
      UseSchema dt -> msg1 & PIO.schema .~ toProto dt


_dataFormatFromProto :: Text -> Try DataFormat
_dataFormatFromProto "" = tryError "_dataFormatFromProto: missing data format"
_dataFormatFromProto "csv" = pure CsvFormat
_dataFormatFromProto "json" = pure JsonFormat
_dataFormatFromProto txt = pure $ CustomSourceFormat txt


{-| If the node is a reading operation, returns the HdfsPath of the source
that is going to be read.
-}
extractResourcePath :: NodeOp -> Maybe ResourcePath
extractResourcePath (NodeDistributedOp so) | soName so == "org.spark.GenericDatasource" =
  -- Try to unpack the extra op and get a path from it.
  case decodeExtra' (soExtra so) of
    Right x -> Just (inputPath x)
    _ -> Nothing -- TODO: this should be an error
extractResourcePath _ = Nothing

{-| Updates the input stamp if possible.

If the node cannot be updated, it is most likely a programming error: an error
is returned.
-}
updateResourceStamp :: NodeOp -> DataInputStamp -> Try NodeOp
updateResourceStamp (NodeDistributedOp so) dis | soName so == "org.spark.GenericDatasource" =
  f <$> decodeExtra' (soExtra so) where
    f sd = NodeDistributedOp $ so { soExtra = x' } where
      x' = convertToExtra' (sd { inputStamp =  Just dis})
updateResourceStamp x _ = pure x
