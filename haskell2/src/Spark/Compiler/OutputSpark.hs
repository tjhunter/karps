
module Spark.Compiler.OutputSpark where

import qualified Data.Vector as V

import Spark.Common.ComputeDag
import Spark.Common.DAGStructures
import Spark.Common.StructuresInternal
import Spark.Common.NodeStructures
import Spark.Common.Try
import Spark.Compiler.Structures
import Spark.Standard.Spark

emitSpark :: ComputeGraph -> Try ComputeGraph
emitSpark cg = mapVertices' cg f where
  outputs = vertexId <$> V.toList (cdOutputs cg)
  inoutputs p = if elem p outputs then IsTerminal else IsInternal
  f :: Vertex OperatorNode -> Try OperatorNode
  f vx = do
    let on = vertexData vx
    (oname, oe) <- outputSpark on (inoutputs (vertexId vx))
    return $ on { onOpName = oname, onExtra = oe }
