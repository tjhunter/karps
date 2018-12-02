{-| The output generator for Spark.
-}

module Spark.Standard.Spark where

import qualified Data.Text as T
import qualified Data.Vector as V
import Data.ProtoLens(def)
import Lens.Micro((&), (.~), (^.))
import Formatting

import qualified Proto.Karps.Proto.Spark as PS
import qualified Proto.Karps.Proto.Spark_Fields as PS
import qualified Proto.Karps.Proto.ApiInternal as PAI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PAI
import Spark.Common.NodeStructures
import Spark.Common.NodeBuilder(NodeBuilder(..), buildOpExtra, buildOpD)
import Spark.Common.OpStructures
import Spark.Common.Try
import Spark.Common.Utilities
import Spark.Standard.Base

data TerminationStatus = IsTerminal | IsInternal deriving (Show, Eq)

outputSpark :: OperatorNode -> TerminationStatus -> Try (OperatorName, OpExtra)
outputSpark on ts = case onOpName on of
  x | (x == nbName collectB) && (ts == IsTerminal) ->
        pure ("spark.CollectPandas", emptyExtra)
  x | x == nbName dataLiteralB ->
        pure ("spark.MaterializePandas", onExtra on)
  otherwise -> tryError $ sformat ("outputSpark: operator "%sh%" not understood") (onOpName on)
