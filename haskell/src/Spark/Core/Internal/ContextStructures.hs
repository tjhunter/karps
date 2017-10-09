{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Spark.Core.Internal.ContextStructures(
  SparkSessionConf(..),
  SparkSession(..),
  SparkState,
  SparkStatePure,
  ComputeGraph,
  TiedComputeGraph,
  HdfsPath(..),
  NodeCacheInfo(..),
  NodeCacheStatus(..),
  SparkStateT,
  SparkStatePureT
) where

import Data.Text(Text)
import Control.Monad.State(StateT, State)
import Control.Monad.Logger(LoggingT)

import Spark.Core.Internal.BrainStructures(LocalSessionId, ComputeGraph, CompilerConf)
import Spark.Core.Internal.DAGStructures(Graph)
import Spark.Core.Internal.OpStructures(HdfsPath(..))
import Spark.Core.Internal.Pruning
import Spark.Core.Internal.DatasetStructures(UntypedNode, StructureEdge,)

-- | The configuration of a remote spark session in Karps.
data SparkSessionConf = SparkSessionConf {
 -- | The URL of the end point.
  confEndPoint :: !Text,
  -- | The port used to configure the end point.
  confPort :: !Int,
  -- | (internal) the polling interval
  confPollingIntervalMillis :: !Int,
  -- | (optional) the requested name of the session.
  -- This name must obey a number of rules:
  --  - it must consist in alphanumerical and -,_: [a-zA-Z0-9\-_]
  --  - if it already exists on the server, it will be reconnected to
  --
  -- The default value is "" (a new random context name will be chosen).
  confRequestedSessionName :: !Text,
  confCompiler :: !CompilerConf
} deriving (Show)

-- | A session in Spark.
-- Encapsualates all the state needed to communicate with Spark
-- and to perfor some simple optimizations on the code.
data SparkSession = SparkSession {
  ssConf :: !SparkSessionConf,
  ssId :: !LocalSessionId,
  ssCommandCounter :: !Integer,
  ssNodeCache :: !NodeCache
} deriving (Show)



-- | Represents the state of a session and accounts for the communication
-- with the server.
type SparkState a = SparkStateT IO a

-- More minimalistic state transforms when doing pure evaluation.
-- (internal type)
-- TODO: use the transformer
type SparkStatePure x = State SparkSession x

type SparkStatePureT m = StateT SparkSession m
type SparkStateT m = LoggingT (SparkStatePureT m)


{-| internal

A graph of computation, in which the nodes have a direct relation to each other
in a way that is not tracked with the edges. This should be
used sparingly. Used only in older algorithms. -}
type TiedComputeGraph = Graph UntypedNode StructureEdge
