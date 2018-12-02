
module Spark.Compiler.Structures where

import qualified Data.ByteString.Char8 as C8
import qualified Data.Text as T
import qualified Data.Vector as V
import Data.ProtoLens(def)
import Lens.Micro((&), (.~), (^.))

import qualified Proto.Karps.Proto.Graph as PG
import qualified Proto.Karps.Proto.Graph_Fields as PG
import qualified Proto.Karps.Proto.ApiInternal as PAI
import qualified Proto.Karps.Proto.ApiInternal_Fields as PAI
import Spark.Common.ComputeDag(ComputeDag, computeGraphMapVerticesI, cdVertices)
import Spark.Common.DAGStructures(Vertex(..), VertexId(..), Edge(..))
import Spark.Common.NodeStructures
import Spark.Common.OpStructures(nsLocality, nsType)
import Spark.Common.ProtoUtils(FromProto(..), ToProto(..), extractMaybe, extractMaybe')
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

instance ToProto PG.Graph ComputeGraph where
  toProto cg = ((def :: PG.Graph)
      & PG.nodes .~ l) where
        cg2 = computeGraphMapVerticesI cg f where
          f :: OperatorNode -> [(ParsedNode, StructureEdge)] -> ParsedNode
          f on l2 = _opNodeToParseNode on parents deps where
            parents = [pnPath pn | (pn, ParentEdge) <- l2]
            deps = [pnPath pn | (pn, LogicalEdge) <- l2]
        l = toProto . vertexData <$> V.toList (cdVertices cg2)
        _opNodeToParseNode :: OperatorNode -> [NodePath] -> [NodePath] -> ParsedNode
        _opNodeToParseNode on parents deps = ParsedNode {
            pnLocality = nsLocality . onShape $ on,
            pnPath = onPath on,
            pnOpName = onOpName on,
            pnExtra = onExtra on,
            pnParents = parents,
            pnDeps = deps,
            pnType = nsType . onShape $ on,
            pnId = pure $ onId on
          }


instance ToProto PAI.CompilerStep (PAI.CompilingPhase, ComputeGraph) where
  toProto (phase, cg) = (def :: PAI.CompilerStep)
      & PAI.phase .~ phase
      & PAI.graph .~ toProto cg
      -- & PAI.graphDef .~ displayGraph cg -- TODO: add the graph display
