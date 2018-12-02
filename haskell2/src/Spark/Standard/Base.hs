module Spark.Standard.Base(
  collectB,
  dataLiteralB,
  literalBuilderD
) where

import Formatting
import Lens.Family2 ((&), (.~), (^.))

import qualified Proto.Karps.Proto.Row as PRow
import qualified Proto.Karps.Proto.Standard as PS
import qualified Proto.Karps.Proto.Standard_Fields as PS
import Spark.Common.NodeBuilder(NodeBuilder, buildOpExtra, buildOpD)
import Spark.Common.OpStructures(CoreNodeInfo(..), NodeOp(..), NodeShape(..), Locality(..), StandardOperator(..), OpExtra(..), emptyExtra)
import Spark.Common.ProtoUtils
import Spark.Common.RowStructures
import Spark.Common.RowUtils(cellWithTypeFromProto)
import Spark.Common.Try
import Spark.Common.TypesStructures
import Spark.Common.Utilities(sh, traceHint)

literalBuilderD :: NodeBuilder
literalBuilderD = buildOpExtra "org.karps.DistributedLiteral" f where
  f :: PRow.CellWithType -> Try CoreNodeInfo
  f cwt = do
    (cells', dt') <- traceHint "literalBuilderD:" $ tryEither (cellWithTypeFromProto cwt)
    case (cells', dt') of
      (RowArray v, StrictType (ArrayType dt)) ->
        pure $ CoreNodeInfo (NodeShape dt Distributed) op where
          op = NodeDistributedLit dt v
      _ -> tryError $ sformat ("builderDistributedLiteral: Expected an array of cells and an array type, got "%sh) (cells', dt')

collectB :: NodeBuilder
collectB = buildOpD n f where
  n = "org.karps.Collect"
  f dt = pure $ CoreNodeInfo (NodeShape dt' Local) no where
          dt' = StrictType (ArrayType dt)
          so = StandardOperator n dt' emptyExtra
          no = NodeLocalOp so

dataLiteralB :: NodeBuilder
dataLiteralB = buildOpExtra n f where
  n = "org.karps.DataLiteral"
  f :: PS.DataLiteral -> Try CoreNodeInfo
  f dl = do
    let parquet = dl ^. PS.parquet
    dt <- extractMaybe' dl PS.maybe'dataType "data_type"
    let ns = NodeShape dt Distributed
    let oe = OpExtra parquet "" ""
    let so = StandardOperator n dt oe
    return $ CoreNodeInfo {
        cniShape = ns,
        cniOp = NodeDistributedOp so
      }
