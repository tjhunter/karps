{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
-- The communication protocol with the server

module Spark.Compiler.Client where

import Data.Default(def)
import Data.Text(Text)
import Formatting
import Lens.Family2((^.), (&), (.~))

import Spark.Common.StructuresInternal
import Spark.Common.ProtoUtils
import Spark.Common.RowStructures(Cell)
import Spark.Common.RowUtils()
import Spark.Common.Try
import Spark.Common.TypesStructures(DataType)
import Spark.Common.TypesFunctions()
import Spark.Common.Utilities
import Spark.Compiler.BrainFunctions()
import Spark.Compiler.BrainStructures(LocalSessionId, ComputeGraph)
import qualified Proto.Karps.Proto.Computation as PC
import qualified Proto.Karps.Proto.Computation_Fields as PC
import qualified Proto.Karps.Proto.Interface as PI
import qualified Proto.Karps.Proto.Interface_Fields as PI

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
      PC.ResultStatus'Unrecognized x ->
        tryError $ sformat ("FromProto PC.ComputationResult: unknwon result status: "%sh) x
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
