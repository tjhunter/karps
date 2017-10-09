{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
-- The communication protocol with the server

module Spark.Core.Internal.Client where

import Data.Text(Text)
import Lens.Family2((^.), (&), (.~))
import Data.Default(def)

import Spark.Core.StructuresInternal
import Spark.Core.Internal.ProtoUtils
import Spark.Core.Internal.RowUtils()
import Spark.Core.Internal.TypesStructures(DataType)
import Spark.Core.Internal.TypesFunctions()
import Spark.Core.Internal.RowStructures(Cell)
import Spark.Core.Internal.BrainFunctions()
import Spark.Core.Internal.BrainStructures(LocalSessionId, ComputeGraph)
import Spark.Core.Try
import qualified Proto.Karps.Proto.Computation as PC
import qualified Proto.Karps.Proto.Interface as PI

{-| The ID of an RDD in Spark.
-}
data RDDId = RDDId {
 unRDDId :: !Int
} deriving (Eq, Show, Ord)

data Computation = Computation {
  cSessionId :: !LocalSessionId,
  cId :: !ComputationID,
  cNodes :: !ComputeGraph, -- TODO: check to replace with OperatorNode?
  -- Non-empty
  cTerminalNodes :: ![NodePath],
  -- The node at the top of the computation.
  -- Must be part of the terminal nodes.
  cCollectingNode :: !NodePath,
  -- This redundant information is not serialized.
  -- It is used internally to track the resulting nodes.
  cTerminalNodeIds :: ![NodeId]
} deriving (Show)

data BatchComputationResult = BatchComputationResult {
  bcrTargetLocalPath :: !NodePath,
  bcrResults :: ![(NodePath, PossibleNodeStatus)]
} deriving (Show)

data RDDInfo = RDDInfo {
 rddiId :: !RDDId,
 rddiClassName :: !Text,
 rddiRepr :: !Text,
 rddiParents :: ![RDDId]
} deriving (Show)

data SparkComputationItemStats = SparkComputationItemStats {
  scisRddInfo :: ![RDDInfo]
} deriving (Show)

data PossibleNodeStatus =
    NodeQueued
  | NodeRunning
  | NodeFinishedSuccess !(Maybe NodeComputationSuccess) !(Maybe SparkComputationItemStats)
  | NodeFinishedFailure NodeComputationFailure deriving (Show)

data NodeComputationSuccess = NodeComputationSuccess {
  -- Because Row requires additional information to be deserialized.
  ncsData :: Cell,
  -- The data type is also available, but it is not going to be parsed for now.
  ncsDataType :: DataType
} deriving (Show)

data NodeComputationFailure = NodeComputationFailure {
  ncfMessage :: !Text
} deriving (Show)

instance ToProto PI.CreateComputationRequest Computation where
  toProto c = (def :: PI.CreateComputationRequest)
    & PI.session .~ toProto (cSessionId c)
    & PI.requestedComputation .~ toProto (cId c)
    & PI.requestedPaths .~ [toProto (cCollectingNode c)]
    & PI.graph .~ toProto (cNodes c)

instance FromProto PC.ComputationResult (NodePath, PossibleNodeStatus) where
  fromProto cr = do
    np <- extractMaybe' cr PC.maybe'localPath "local_path"
    case cr ^. PC.status of
      PC.UNUSED -> tryError "FromProto PC.ComputationResult: missing status"
      PC.SCHEDULED ->
        return (np, NodeQueued)
      PC.RUNNING ->
        return (np, NodeRunning)
      PC.FINISHED_SUCCESS -> do
        cwt <- extractMaybe cr PC.maybe'finalResult "final_result"
        (c, dt) <- fromProto cwt
        let ncs = NodeComputationSuccess c dt
        -- TODO: add the spark stats
        return (np, NodeFinishedSuccess (Just ncs) Nothing)
      PC.FINISHED_FAILURE ->
        return (np, NodeFinishedFailure ncf) where
          txt = cr ^. PC.finalError
          ncf = NodeComputationFailure txt

instance FromProto PC.BatchComputationResult BatchComputationResult where
  fromProto bcr = do
    np <- extractMaybe' bcr PC.maybe'targetPath "target_path"
    l <- sequence $ fromProto <$> (bcr ^. PC.results)
    return $ BatchComputationResult np l
