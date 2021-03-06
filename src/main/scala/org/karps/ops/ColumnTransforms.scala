package org.karps.ops


import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._

import org.karps.ops.Extraction.{FieldName, FieldPath}
import org.karps.row._
import org.karps.structures._
import org.karps.{ColumnWithType, KarpsException}

import karps.core.{row => R, std => STD, structured_transform => ST}



// TODO: refactor to use ColumnWithType, it will simplify things.
object ColumnTransforms extends Logging {
  import StructuredTransformParsing._
  import org.karps.structures.ProtoUtils.sequence

  def select(
      cwt: ColumnWithType,
      ex: OpExtra): Try[ColumnWithType] = {
    for {
      p <- ProtoUtils.fromExtra[STD.StructuredTransform](ex)
      col = p.colOp.get
      trans <- fromProto(col)
      res <- select0(cwt, trans)
    } yield {
      logger.debug(s"select: p = $p")
      logger.debug(s"select: col = $col")
      logger.debug(s"select: trans = $trans")
      logger.debug(s"select: res = $res")
      res
    }
  }

  private def select0(
      cwt: ColumnWithType,
      trans: StructuredTransform): Try[ColumnWithType] = {
    // If a name is provided in the structure, make sure to use it.
    // It should always be the case.
    select1(cwt, trans).map { res =>
      trans.name match {
        case Some(n) if n.nonEmpty => res.copy(col = res.col.alias(n))
        case _ => res
      }
    }
  }

  // Returns a single column. This column may need to be denormalized after that.
  private def select1(
      cwt: ColumnWithType,
      trans: StructuredTransform): Try[ColumnWithType] = trans match {
    case ColExtraction(fieldPath, _) =>
      Extraction.extractCol(cwt, fieldPath)
    case ColFunction(funName, inputs, expectedType, _) =>
      val inputst = sequence(inputs.map(select0(cwt, _)))
      inputst.flatMap(inputs =>
        SQLFunctionsExtraction.buildFunction(funName, inputs, cwt.ref, expectedType))

    case ColStructure(fields, _) =>
      val fst = sequence(fields.map { f =>
        select0(cwt, f.fieldTrans).map { cwt2 =>
          val c2 = cwt2.col.alias(f.fieldName.name)
          val f2 = StructField(
            f.fieldName.name, cwt2.rectifiedSchema.dataType, cwt2.rectifiedSchema.isNullable)
          c2 -> f2
        }
      })
      for (fs <- fst) yield {
        val st = StructType(fs.map(_._2))
        val str = struct(fs.map(_._1): _*)
        ColumnWithType(str, AugmentedDataType(st, IsStrict), cwt.ref)
      }
    case ColLiteral(cellwt, _) => Success(literalCol(cellwt, cwt.ref))

  }

  private def literalCol(cwt: CellWithType, ref: DataFrame): ColumnWithType = {
    val c = cwt.cellData match {
      case IntElement(i) => lit(i)
      case DoubleElement(d) => lit(d)
      case StringElement(s) => lit(s)
      case BoolElement(b) => lit(b)
      case Empty => lit(null) // TODO not sure if Spark will resist that.
      case x =>
        // Do not trust Spark to correctly represent anything else.
        // TODO: wrap the content in a UDF and a row.
        KarpsException.fail(s"Literal not implemented yet for type ${cwt.cellType}")
    }
    ColumnWithType(c, cwt.cellType, ref)
  }
}

object StructuredTransformParsing {
  import org.karps.structures.ProtoUtils.sequence

  case class Field(fieldName: FieldName, fieldTrans: StructuredTransform)

  sealed trait StructuredTransform {
    def name: Option[String]
  }
  case class ColStructure(
      fields: Seq[Field],
      name: Option[String]) extends StructuredTransform
  case class ColExtraction(
      path: FieldPath,
      name: Option[String]) extends StructuredTransform
  case class ColFunction(
      functionName: String,
      inputs: Seq[StructuredTransform],
      expectedType: Option[AugmentedDataType],
      name: Option[String]) extends StructuredTransform
  case class ColLiteral(
      content: CellWithType,
      name: Option[String]) extends StructuredTransform


  def fromProto(t: ST.Column): Try[StructuredTransform] = {
    val fname = Option(t.fieldName)
    t.content match {
      case ST.Column.Content.Function(ST.ColumnFunction(fnam, cf, et)) =>
        val adtt = et match {
          case Some(x) => AugmentedDataType.fromProto(x).map(Option.apply)
          case None => Success(None)
        }
        if (fnam == null) {
          Failure(new Exception(s"Missing name"))
        } else {
          for {
            ops2 <- sequence(cf.map(fromProto))
            adt <- adtt
          } yield {
            ColFunction(fnam, ops2, adt, fname)
          }
        }
      case ST.Column.Content.Extraction(ST.ColumnExtraction(path)) =>
        val fp = FieldPath(path.map(FieldName.apply).toList)
        Success(ColExtraction(fp, fname))
      case ST.Column.Content.Struct(ST.ColumnStructure(fields)) =>
        val fst = sequence(fields.map(fromProto))
        for {
          fs <- fst
          fieldNames <- checkFieldNames(fs.map(_.name))
        } yield {
          val fs2 = fs.zip(fieldNames).map { case (f, fn) => Field(fn, f) }
          ColStructure(fs2, fname)
        }
      case ST.Column.Content.Literal(ST.ColumnLiteral(content)) =>
        for {
          cwt <- CellWithType.fromProto(content.get)
        } yield ColLiteral(cwt, fname)
      case ST.Column.Content.Empty =>
        Failure(new Exception(s"Missing content: ${t.fieldName}"))
      case x =>
        Failure(new Exception(s"Unsupported column operation: $x"))
    }
  }

  def checkFieldNames(s: Seq[Option[String]]): Try[Seq[FieldName]] = {
    sequence(s.map {
      case None => Failure(new Exception("Missing name"))
      case Some(s) => Success(FieldName(s))
    })
  }

}
