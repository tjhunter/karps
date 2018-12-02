
module Spark.Compiler.Compiler where

import qualified Data.ByteString.Char8 as C8
import qualified Data.Text as T

import qualified Proto.Karps.Proto.ApiInternal as PAI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PAI
import Spark.Common.ComputeDag(ComputeDag)
import Spark.Common.DAGStructures(Vertex(..), VertexId(..), Edge(..))
import Spark.Common.NodeStructures(StructureEdge(ParentEdge), OperatorNode, onPath)
import Spark.Common.StructuresInternal(NodeId, ComputationID, NodePath, prettyNodePath)
import Spark.Common.Try(NodeError, Try, nodeError, eMessage)

{-| internal

A graph of computations. This graph is a direct acyclic graph. Each node is
associated to a global path.

Note: this is a parsed representation that has already called the builders.
Note sure if this is the right design here.
-}
type ComputeGraph = ComputeDag OperatorNode StructureEdge

{-| The successful transform of a high-level functional graph into
a lower-level, optimized version.

One can see the progress using the phases also returned.
-}
data GraphTransformSuccess = GraphTransformSuccess {
  gtsNodes :: !ComputeGraph,
  gtsCompilerSteps :: ![(PAI.CompilingPhase, ComputeGraph)]
} deriving (Show)

{-| The result of a failure in the compiler. On top of the error, it also
returns information about the successful compiler steps.
-}
data GraphTransformFailure = GraphTransformFailure {
  gtfMessage :: !NodeError,
  gtfCompilerSteps :: ![(PAI.CompilingPhase, ComputeGraph)]
} deriving (Show)

type TransformReturn = Either GraphTransformFailure GraphTransformSuccess

pathToVId :: NodePath -> VertexId
pathToVId = VertexId . C8.pack . T.unpack . prettyNodePath

performTransform :: ComputeGraph -> TransformReturn
performTransform cg = return $ GraphTransformSuccess cg []
