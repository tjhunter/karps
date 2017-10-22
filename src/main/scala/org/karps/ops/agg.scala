package org.karps.ops

import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.apache.spark.sql.types._
import org.apache.spark.sql.{DataFrame, RelationalGroupedDataset}

import org.karps.ops.Extraction.{FieldName, FieldPath}
import org.karps.ops.SQLFunctionsExtraction.SQLFunctionName
import org.karps.structures.{AugmentedDataType, IsStrict, OpExtra, ProtoUtils}
import org.karps.{ColumnWithType, DataFrameWithType}

import karps.core.{std => STD, structured_transform => ST}

// This is
object GroupedReduction extends Logging {
  import AggregationParsing._
  import org.karps.structures.ProtoUtils.sequence

  def groupReduceOrThrow(adf: DataFrameWithType, js: OpExtra): DataFrameWithType =
    groupReduce(adf, js).get

  def groupReduce(adf: DataFrameWithType, js: OpExtra): Try[DataFrameWithType] = {
    for {
      op <- parseShuffle(js)
      (g, valCol) <- makeGroup(adf)
      col <- performTrans(valCol, op)
    } yield {
      val df = g.agg(col.col.alias("value"))
      DataFrameWithType.create(df, AugmentedDataType.apply(df.schema, IsStrict)).get
    }
  }

  def reduceOrThrow(adf: DataFrameWithType, js: OpExtra): DataFrameWithType =
    reduce(adf, js).get

  def reduce(adf: DataFrameWithType, js: OpExtra): Try[DataFrameWithType] = {
    val c = DataFrameWithType.asTypedColumn(adf)
    logger.info(s"reduce: c=$c adf=$adf")
    for {
      op <- parseReduction(js)
      col <- performTrans(c, op)
      df = adf.df.groupBy().agg(col.col)
      // In the case of structures, they are wrapped with an extra layer of indirection.
      // Remove this layer
      // TODO
      _ <- { logger.debug(s"reduce:\nop=$op\ncol=$col \ndf=$df"); Success(2) }
      dfwt <- createDF(df, col.rectifiedSchema)
    } yield {
      dfwt
    }
  }

  private def createDF(df: DataFrame, schema: AugmentedDataType): Try[DataFrameWithType] = {
    (schema.topLevelStruct, df.schema) match {
      case (Some(st), StructType(Array(f1))) =>
        // Top-level structure, which needs to be unwrapped.
        val df2 = f1.dataType match {
          case StructType(fields) =>
            val cols = fields.map(f => df.col(f1.name).getField(f.name).alias(f.name))
            df.select(cols:_*)
          case _ =>
            df.select(df.col(f1.name).alias(f1.name))
        }
        logger.debug(s"createDF: df2=$df2 schema=$schema")
        DataFrameWithType.create(df2, schema)
      case (Some(st), other) =>
        // This is not what we are expecting here, failure.
        Failure(new Exception(s"Expected a top-level structure with a single field to go with $st" +
          s" but got $other instead"))
      case (None, _) =>
        // Regular use case, just use the schema.
        DataFrameWithType.create(df, schema)
    }
  }

  // Groups all the keys together under a single "key' field and performs a group under this field.
  private def makeGroup(
      adf: DataFrameWithType): Try[(RelationalGroupedDataset, ColumnWithType)] = {
    // We expect a structure with 2 elements inside:
    val df = adf.df
    df.schema match {
      case StructType(Array(f1, f2)) =>
        val c = DataFrameWithType.asTypedColumn(adf)
        val g = df.groupBy(f1.name)
        for {
          c2 <- Extraction.extractField(c, FieldName(f2.name))
        } yield g -> c2
      case x => Failure(new Exception(s"Expected a struct with two fields, got $x"))
    }
  }

  private def performTrans(
      valCol: ColumnWithType,
      agg: AggOp): Try[ColumnWithType] = {
    val c2 = agg match {
      case AggFunction(n, inputs, et, _) =>
        for {
          cols <- sequence(inputs.map(Extraction.extractCol(valCol, _)))
          c <- SQLFunctionsExtraction.buildFunction(n, cols, valCol.ref, et)
        } yield {
          c
        }
      case AggStruct(fields, _) =>
        sequence(fields.map { f =>
          performTrans(valCol, f.op).map(_.alias(f.fieldName))
            .map(cwt => (f.fieldName.name, cwt))
        }).flatMap(ColumnWithType.struct(_ : _*))
    }
    // Apply the name if requested.
    agg.name match {
      case Some(n) if n != "" => c2.map(cwt => cwt.copy(col=cwt.col.alias(n)))
      case None => c2.map(cwt => cwt.copy(col=cwt.col.alias("agg_value")))
    }
  }
}

object AggregationParsing extends Logging {
  import org.karps.structures.ProtoUtils.sequence

  sealed trait AggOp {
    def name: Option[String]
  }

  case class AggFunction(
      function: SQLFunctionName,
      inputs: Seq[FieldPath],
      expectedType: Option[AugmentedDataType],
      name: Option[String]) extends AggOp

  case class AggStruct(
      struct: Seq[Field],
      name: Option[String]) extends AggOp

  case class Field(fieldName: FieldName, op: AggOp)

  private def fromProto(agg: ST.Aggregation): Try[AggOp] = {
    logger.debug(s"Parsing AGG: $agg")
    // Remove empty name values too.
    val fname = Option(agg.fieldName).filterNot(_ == "")
    import ST.Aggregation.AggOp
    agg.aggOp match {
      case AggOp.Empty =>
        Failure(new Exception(s"Missing content"))

      case AggOp.Op(af) =>
        if (af.functionName == null) {
          return Failure(new Exception(s"Missing name"))
        }
        // For a mysterious reason, this string has some extra stuff around it.
        // It may be because haskell uses utf8 while java uses utf16
        val trimmedName = af.functionName.toLowerCase.trim
        val adtt = af.expectedType match {
          case Some(x) => AugmentedDataType.fromProto(x).map(Option.apply)
          case None => Success(None)
        }
        val paths = af.inputs.map { input =>
          FieldPath(input.path.map(FieldName.apply).toList)
        }
        // Because protobuf does not make the difference between an empty
        // list and missing data, we are going to assume that if the path
        // is empty, it meant that the root was accessed.
        val paths2 = if (paths.isEmpty) {
          Seq(FieldPath(Nil))
        } else paths
        val res = adtt.map(adt => AggFunction(trimmedName, paths2, adt, fname))
        logger.debug(s"Build AGG function $res from $af")
        res

      case AggOp.Struct(ST.AggregationStructure(fields)) =>
        val fst = sequence(fields.map(fromProto))
        for {
          fs <- fst
          fieldNames <- StructuredTransformParsing.checkFieldNames(fs.map(_.name))
        } yield {
          val fs2 = fs.zip(fieldNames).map { case (f, fn) => Field(fn, f) }
          AggStruct(fs2, fname)
        }
    }
  }

  def parseShuffle(extra: OpExtra): Try[AggOp] = {
    val proto = ProtoUtils.fromExtra[STD.Shuffle](extra)
    val res = proto
      .flatMap { p => p.aggOp match {
        case None => Failure(new Exception("missing agg_op"))
        case Some(x) => Success(x)
      }}
      .flatMap(fromProto)
    res
  }

  def parseReduction(extra: OpExtra): Try[AggOp] = {
    val proto = ProtoUtils.fromExtra[STD.StructuredReduce](extra)
    val res = proto
        .flatMap { p => p.aggOp match {
          case None => Failure(new Exception("missing agg_op"))
          case Some(x) => Success(x)
        }}
      .flatMap(fromProto)
    res
  }

}

