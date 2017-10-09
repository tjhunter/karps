{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Some basic structures about nodes in a graph, etc.

module Spark.Core.StructuresInternal(
  NodeName(..),
  NodePath(..),
  NodeId(..),
  FieldName(..),
  FieldPath(..),
  ComputationID(..),
  catNodePath,
  fieldName,
  unsafeFieldName,
  emptyFieldPath,
  nullFieldPath,
  headFieldPath,
  fieldPath,
  fieldPath',
  prettyNodePath,
  fieldPathToProto,
  fieldPathFromProto,
  nodePathAppendSuffix,
  emptyNodeId
) where

import qualified Data.Text as T
import Data.ByteString(ByteString)
import GHC.Generics (Generic)
import Data.Hashable(Hashable)
import Data.List(intercalate)
import Data.String(IsString(..))
import Data.Vector(Vector)
import qualified Data.Vector as V
import Data.Text.Encoding as E

import Spark.Core.Internal.Utilities
import Spark.Core.Internal.ProtoUtils
-- TODO: move elsewhere
import qualified Proto.Karps.Proto.StructuredTransform as PST
import qualified Proto.Karps.Proto.Computation as PC
import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.ApiInternal as PAI

-- | The name of a node (without path information)
newtype NodeName = NodeName { unNodeName :: T.Text } deriving (Eq, Ord)

-- | The user-defined path of the node in the hierarchical representation of the graph.
newtype NodePath = NodePath { unNodePath :: Vector NodeName } deriving (Eq, Ord)

-- | The unique ID of a node. It is based on the parents of the node
-- and all the relevant intrinsic values of the node.
newtype NodeId = NodeId { unNodeId :: ByteString } deriving (Eq, Ord, Generic)

-- | The name of a field in a sql structure
-- This structure ensures that proper escaping happens if required.
-- TODO: prevent the constructor from being used, it should be checked first.
newtype FieldName = FieldName { unFieldName :: T.Text } deriving (Eq)

-- | A path to a nested field an a sql structure.
-- This structure ensures that proper escaping happens if required.
newtype FieldPath = FieldPath { unFieldPath :: Vector FieldName } deriving (Eq)

{-| A unique identifier for a computation (a batch of nodes sent for execution
to Spark).
-}
data ComputationID = ComputationID {
  unComputationID :: !T.Text
} deriving (Eq, Show, Generic)

emptyNodeId :: NodeId
emptyNodeId = NodeId "NOID"

-- | A safe constructor for field names that fixes all the issues relevant to
-- SQL escaping
-- TODO: proper implementation
-- TODO: have fieldNameTo/FromProto
fieldName :: T.Text -> Either String FieldName
fieldName = Right . FieldName

-- | Constructs the field name, but will fail if the content is not correct.
unsafeFieldName :: (HasCallStack) => T.Text -> FieldName
unsafeFieldName = forceRight . fieldName

-- | A safe constructor for field names that fixes all the issues relevant to SQL escaping
-- TODO: proper implementation
fieldPath :: T.Text -> Either String FieldPath
fieldPath x = Right . FieldPath . V.singleton $ FieldName x

emptyFieldPath :: FieldPath
emptyFieldPath = FieldPath V.empty

nullFieldPath :: FieldPath -> Bool
nullFieldPath = V.null . unFieldPath

headFieldPath :: FieldPath -> Maybe FieldName
headFieldPath (FieldPath v) | V.null v = Nothing
headFieldPath (FieldPath v) = Just $ V.head v

fieldPath' :: [FieldName] -> FieldPath
fieldPath' = FieldPath . V.fromList

{-| Appends a suffix to the last element of the nodepath.

This does not make the path deeper.
-}
nodePathAppendSuffix :: NodePath -> T.Text -> NodePath
nodePathAppendSuffix (NodePath v) t = NodePath $ V.snoc (V.init v) x' where
    x = unNodeName (V.last v)
    x' = NodeName (x <> t)

-- | The concatenated path. This is the inverse function of fieldPath.
-- | TODO: this one should be hidden?
catNodePath :: NodePath -> T.Text
catNodePath (NodePath np) =
  T.intercalate "/" (unNodeName <$> V.toList np)

prettyNodePath :: NodePath -> T.Text
-- Only a single slash, double slashes are reserved for the case
-- of global paths (including session and computation)
prettyNodePath np = "/" <> catNodePath np

instance Show NodeId where
  show (NodeId bs) = s' where
    s = show bs
    n = 10
    s' = if length s > n
      then (drop 1 . take (n - 3)) s ++ ".."
      else s

instance Show NodeName where
  show (NodeName nn) = T.unpack nn

instance Show NodePath where
  show np = T.unpack $ T.concat ["NPath(", catNodePath np, ")" ]

instance Show FieldPath where
  show (FieldPath l) =
    intercalate "." (show <$> V.toList l)

instance Show FieldName where
  -- TODO(kps) escape the '.' characters in the field name
  show (FieldName fn) = T.unpack fn

instance Hashable NodeId

instance IsString FieldName where
  fromString = FieldName . T.pack

fieldPathToProto :: FieldPath -> PST.ColumnExtraction
fieldPathToProto (FieldPath v) = PST.ColumnExtraction (unFieldName <$> V.toList v)

fieldPathFromProto :: PST.ColumnExtraction -> FieldPath
fieldPathFromProto (PST.ColumnExtraction l) = FieldPath (FieldName <$> V.fromList l)

instance FromProto PC.ComputationId ComputationID where
  fromProto (PC.ComputationId txt) = pure $ ComputationID txt

instance ToProto PC.ComputationId ComputationID where
  toProto (ComputationID txt) = PC.ComputationId txt

instance FromProto PG.Path NodePath where
  -- TODO: add more checks to the path, to make sure it respects some basic
  -- sanity checks.
  fromProto (PG.Path l) = pure . NodePath . V.fromList $ (NodeName <$> l)

instance ToProto PG.Path NodePath where
  toProto (NodePath v) = PG.Path . V.toList $ (unNodeName <$> v)

instance FromProto PAI.NodeId NodeId where
  fromProto (PAI.NodeId txt) = pure $ NodeId (E.encodeUtf8 txt)

instance ToProto PAI.NodeId NodeId where
  toProto (NodeId bs) = PAI.NodeId (show' bs)

instance Ord FieldName where
  compare f1 f2 = compare (unFieldName f1) (unFieldName f2)
