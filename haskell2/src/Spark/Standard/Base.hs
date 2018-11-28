module Spark.Standard.Base(
  literalBuilderD
) where

import Formatting

import qualified Proto.Karps.Proto.Row as PRow
import Spark.Common.OpStructures(CoreNodeInfo(..), NodeOp(..), NodeShape(..), Locality(..))
import Spark.Common.NodeBuilder(NodeBuilder, buildOpExtra)
import Spark.Common.RowStructures
import Spark.Common.RowUtils(cellWithTypeFromProto)
import Spark.Common.Try
import Spark.Common.TypesStructures
import Spark.Common.Utilities(sh, traceHint)

literalBuilderD :: NodeBuilder
literalBuilderD = buildOpExtra "org.karps.DistributedLiteral" f where
  f :: PRow.CellWithType -> Try CoreNodeInfo
  f cwt = do
    (cells', dt') <- traceHint ("literalBuilderD:") $ tryEither (cellWithTypeFromProto cwt)
    case (cells', dt') of
      (RowArray v, StrictType (ArrayType dt)) ->
        pure $ CoreNodeInfo (NodeShape dt Distributed) op where
          op = NodeDistributedLit dt v
      _ -> tryError $ sformat ("builderDistributedLiteral: Expected an array of cells and an array type, got "%sh) (cells', dt')
