{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE TupleSections #-}

module Spark.Core.Internal.OpFunctions(
  simpleShowOp,
  prettyShowOp,
  extraNodeOpData,
  hashUpdateNodeOp,
  prettyShowColOp,
  prettyShowColFun,
  convertToExtra,
  convertToExtra',
  decodeExtra,
  decodeExtra',
  -- Special operations names
  nameLocalLiteral,
  nameStructuredTransform,
  nameLocalStructuredTransform,
  nameDistributedLiteral,
  nameGroupedReduction,
  nameReduction,
  nameBroadcastJoin,
  namePointer
) where

import qualified Crypto.Hash.SHA256 as SHA
import qualified Data.Text as T
import qualified Data.Vector as V
import qualified Data.ByteString.Base64 as B64
import Data.Text.Encoding(encodeUtf8, decodeUtf8)
import Data.Text(Text)
import Data.Char(isSymbol)
import Data.ProtoLens.Message(Message)
import Data.ProtoLens.Encoding(encodeMessage, decodeMessage)
import Data.ProtoLens.TextFormat(showMessage)

import Spark.Core.Try
import Spark.Core.Internal.OpStructures
import Spark.Core.Internal.Utilities
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Internal.TypesFunctions(arrayType')
import Spark.Core.Internal.RowUtils(cellWithTypeToProto, rowArray)
import qualified Proto.Karps.Proto.Std as PS

-- (internal)
-- The serialized type of a node operation, as written in
-- the JSON and proto description.
simpleShowOp :: NodeOp -> T.Text
simpleShowOp (NodeLocalOp op') = soName op'
simpleShowOp (NodeDistributedOp op') = soName op'
simpleShowOp (NodeLocalLit _ _) = nameLocalLiteral
simpleShowOp (NodeOpaqueAggregator op') = soName op'
-- simpleShowOp (NodeAggregatorReduction ua) =
--   _jsonShowAggTrans . uaoInitialOuter $ ua
simpleShowOp (NodeAggregatorLocalReduction ua) = _jsonShowSGO . uaoMergeBuffer $ ua
simpleShowOp (NodeStructuredTransform _) = nameStructuredTransform
simpleShowOp (NodeLocalStructuredTransform _) = nameLocalStructuredTransform
simpleShowOp (NodeDistributedLit _ _) = nameDistributedLiteral
simpleShowOp (NodeGroupedReduction _) = nameGroupedReduction
simpleShowOp (NodeReduction _) = nameReduction
simpleShowOp NodeBroadcastJoin = nameBroadcastJoin
simpleShowOp (NodePointer _) = namePointer

nameLocalLiteral :: T.Text
nameLocalLiteral = "org.spark.LocalLiteral"

nameStructuredTransform :: T.Text
nameStructuredTransform = "org.spark.StructuredTransform"

nameLocalStructuredTransform :: T.Text
nameLocalStructuredTransform = "org.spark.LocalStructuredTransform"

nameDistributedLiteral :: T.Text
nameDistributedLiteral = "org.spark.DistributedLiteral"

nameGroupedReduction :: T.Text
nameGroupedReduction = "org.spark.GroupedReduction"

nameReduction :: T.Text
nameReduction = "org.spark.StructuredReduce"

nameBroadcastJoin :: T.Text
nameBroadcastJoin = "org.spark.BroadcastJoin"

namePointer :: T.Text
namePointer = "org.spark.PlaceholderCache"

decodeExtra :: Message x => OpExtra -> Try x
decodeExtra (OpExtra o _ _) = case decodeMessage o of
  Right x -> pure x
  Left msg -> tryError $ "decodeExtra: " <> T.pack msg

decodeExtra' :: (Message x, FromProto x y) => OpExtra -> Try y
decodeExtra' o = decodeExtra o >>= fromProto

{-| Converts a message to the extra content of an op.
-}
convertToExtra :: Message x => x -> OpExtra
convertToExtra msg = OpExtra bin (T.pack (showMessage msg)) (decodeUtf8 (B64.encode bin)) where
  bin = encodeMessage msg

{-| Converts a haskell data structure that we know is backed by a proto to
an opExtra.
-}
convertToExtra' :: (Message x, ToProto x y) => y -> OpExtra
convertToExtra' = convertToExtra . toProto

{-| A text representation of the operation that is appealing for humans.
-}
prettyShowOp :: NodeOp -> T.Text
-- prettyShowOp (NodeAggregatorReduction uao) =
--   case uaoInitialOuter uao of
--     OpaqueAggTransform so -> soName so
--     -- Try to have a pretty name for the simple reductions
--     InnerAggOp (AggFunction n _) -> n
--     _ -> simpleShowOp (NodeAggregatorReduction uao)
prettyShowOp = simpleShowOp


-- A human-readable string that represents column operations.
prettyShowColOp :: ColOp -> T.Text
prettyShowColOp (ColBroadcast idx) = T.pack $ "BROADCAST(" ++ show idx ++ ")"
prettyShowColOp (ColExtraction fpath) = T.pack (show fpath)
prettyShowColOp (ColFunction txt cols _) =
  prettyShowColFun txt (V.toList (prettyShowColOp <$> cols))
prettyShowColOp (ColLit _ cell) = show' cell
prettyShowColOp (ColStruct s) =
  "struct(" <> T.intercalate "," (prettyShowColOp . tfValue <$> V.toList s) <> ")"

_jsonShowAggTrans :: AggTransform -> Text
_jsonShowAggTrans (OpaqueAggTransform op') = soName op'
_jsonShowAggTrans (InnerAggOp _) = "org.spark.StructuredReduction"


_jsonShowSGO :: SemiGroupOperator -> Text
_jsonShowSGO (OpaqueSemiGroupLaw so) = soName so
_jsonShowSGO (UdafSemiGroupOperator ucn) = ucn
_jsonShowSGO (ColumnSemiGroupLaw sfn) = sfn


_prettyShowAggOp :: AggOp -> T.Text
_prettyShowAggOp (AggUdaf _ ucn fp) = ucn <> "(" <> show' fp <> ")"
_prettyShowAggOp (AggFunction sfn v _) = prettyShowColFun sfn r where
  r = [show' v]
_prettyShowAggOp (AggStruct v) =
  "struct(" <> T.intercalate "," (_prettyShowAggOp . afValue <$> V.toList v) <> ")"

_prettyShowAggTrans :: AggTransform -> Text
_prettyShowAggTrans (OpaqueAggTransform op') = soName op'
_prettyShowAggTrans (InnerAggOp ao) = _prettyShowAggOp ao

_prettyShowSGO :: SemiGroupOperator -> Text
_prettyShowSGO (OpaqueSemiGroupLaw so) = soName so
_prettyShowSGO (UdafSemiGroupOperator ucn) = ucn
_prettyShowSGO (ColumnSemiGroupLaw sfn) = sfn

-- (internal)
-- The extra data associated with the operation, and that is required
-- by the backend to successfully perform the operation.
-- We pass the type as seen by Karps (along with some extra information about
-- nullability). This information is required by spark to analyze the exact
-- type of some operations.
extraNodeOpData :: NodeOp -> OpExtra
extraNodeOpData (NodeLocalLit dt cell) = convertToExtra . forceRight $ cellWithTypeToProto dt cell
extraNodeOpData (NodeStructuredTransform st) =
  convertToExtra (PS.StructuredTransform (Just (toProto st)))
extraNodeOpData (NodeLocalStructuredTransform st) =
  convertToExtra (PS.LocalStructuredTransform (Just (toProto st)))
extraNodeOpData (NodeDistributedLit dt v) =
  convertToExtra . forceRight $ cellWithTypeToProto dt' l' where
    dt' = arrayType' dt
    l' = rowArray (V.toList v)
extraNodeOpData (NodeDistributedOp so) = soExtra so
extraNodeOpData (NodeGroupedReduction ao) =
  convertToExtra (PS.Shuffle (Just (toProto ao)))
extraNodeOpData (NodeOpaqueAggregator so) = soExtra so
extraNodeOpData (NodeLocalOp so) = soExtra so
extraNodeOpData NodeBroadcastJoin = emptyExtra
extraNodeOpData (NodeReduction ao) =
  convertToExtra (PS.StructuredReduce (Just (toProto ao)))
extraNodeOpData (NodeAggregatorLocalReduction _) =
  error "extraNodeOpData: NodeAggregatorLocalReduction"
extraNodeOpData (NodePointer p) = convertToExtra' p

-- Adds the content of a node op to a hash.
hashUpdateNodeOp :: SHA.Ctx -> NodeOp -> SHA.Ctx
hashUpdateNodeOp ctx op' = SHA.updates ctx ["op", bsOp, "extra", bsExtra] where
  bsOp = encodeUtf8 $ simpleShowOp op'
  (OpExtra bsExtra _ _) = extraNodeOpData op'


prettyShowColFun :: T.Text -> [Text] -> T.Text
prettyShowColFun txt [col] | _isSym txt =
  T.concat [txt, " ", col]
prettyShowColFun txt [col1, col2] | _isSym txt =
  -- This is not perfect for complex operations, but it should get the job done
  -- for now.
  -- TODO eventually use operator priority here
  T.concat [col1, " ", txt, " ", col2]
prettyShowColFun txt cols =
  let vals = T.intercalate ", " cols in
  T.concat [txt, "(", vals, ")"]

_isSym :: T.Text -> Bool
_isSym txt = all isSymbol (T.unpack txt)
