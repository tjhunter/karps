
module Spark.Compiler.Compiler where

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
import Spark.Compiler.Structures
import Spark.Compiler.OutputSpark


performTransform :: ComputeGraph -> TransformReturn
performTransform cg =
  case emitSpark cg of
    Right cg' -> pure $ GraphTransformSuccess cg' []
    Left e -> Left $ GraphTransformFailure e []
