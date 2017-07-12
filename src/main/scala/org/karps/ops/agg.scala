package org.karps.ops

import scala.util.{Failure, Try, Success}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import com.trueaccord.scalapb.json.JsonFormat

import org.apache.spark.sql.types._
import org.apache.spark.sql.RelationalGroupedDataset

import org.karps.{ColumnWithType, DataFrameWithType}
import org.karps.ops.Extraction.{FieldName, FieldPath}
import org.karps.ops.SQLFunctionsExtraction.SQLFunctionName
import org.karps.structures.{AugmentedDataType, IsStrict, OpExtra}
import karps.core.{structured_transform => ST}

object GroupedReduction extends Logging {
  import org.karps.structures.ProtoUtils.sequence

  def groupReduceOrThrow(adf: DataFrameWithType, js: OpExtra): DataFrameWithType =
    groupReduce(adf, js).get

  def groupReduce(adf: DataFrameWithType, js: OpExtra): Try[DataFrameWithType] = {
    for {
      op <- parseTrans(js)
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
      op <- parseTrans(js)
      col <- performTrans(c, op)
      df = adf.df.groupBy().agg(col.col)
      dfwt <- DataFrameWithType.create(df, col.rectifiedSchema)
    } yield {
      dfwt
    }
  }


  private sealed trait AggOp {
    def name: Option[String]
  }
  
  private case class AggFunction(
    function: SQLFunctionName,
    inputs: Seq[FieldPath],
    name: Option[String]) extends AggOp
    
  private case class AggStruct(
    struct: Seq[Field],
    name: Option[String]) extends AggOp

  private case class Field(fieldName: FieldName, op: AggOp)

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
  
  private def parseTrans(extra: OpExtra): Try[AggOp] = {
    val proto = Try(JsonFormat.fromJsonString[ST.Aggregation](extra.content))
    proto.flatMap(fromProto)
  }

  private def fromProto(agg: ST.Aggregation): Try[AggOp] = {
    val fname = Option(agg.fieldName)
    import ST.Aggregation.AggOp
    agg.aggOp match {
      case AggOp.Empty =>
        Failure(new Exception(s"Missing content"))

      case AggOp.Op(ST.AggregationFunction(name, inputs)) =>
        if (name == null) {
          return Failure(new Exception(s"Missing name"))
        }
        val paths = inputs.map { input =>
          FieldPath(input.path.map(FieldName.apply).toList)
        }
        Success(AggFunction(name, paths, fname))

      case AggOp.Struct(ST.AggregationStructure(fields)) =>
        val fst = sequence(fields.map(fromProto))
        for {
          fs <- fst
          fieldNames <- ColumnTransforms.checkFieldNames(fs.map(_.name))
        } yield {
          val fs2 = fs.zip(fieldNames).map { case (f, fn) => Field(fn, f) }
          AggStruct(fs2, fname)
        }
        
    }
  }

  private def performTrans(
      valCol: ColumnWithType,
      agg: AggOp): Try[ColumnWithType] = agg match {
    case AggFunction(n, inputs, _) =>
      for {
        cols <- sequence(inputs.map(Extraction.extractCol(valCol, _)))
        c <- SQLFunctionsExtraction.buildFunction(n, cols, valCol.ref)
      } yield {
        c
      }
    case AggStruct(fields, _) =>
      sequence(fields.map { f =>
        performTrans(valCol, f.op).map(_.alias(f.fieldName))
      }).flatMap(ColumnWithType.struct(_ : _*))
  }
}

