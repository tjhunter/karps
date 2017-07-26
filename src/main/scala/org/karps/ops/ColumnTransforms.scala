package org.karps.ops


import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.sql.{Column, DataFrame, KarpsStubs}
import org.apache.spark.sql.catalyst.analysis.FunctionRegistry

import org.karps.{ColumnWithType, DataFrameWithType, KarpsException$}
import org.karps.ops.Extraction.{FieldName, FieldPath}
import org.karps.structures._
import karps.core.{structured_transform => ST}



// TODO: refactor to use ColumnWithType, it will simplify things.
object ColumnTransforms extends Logging {
  import org.karps.structures.ProtoUtils.sequence
  
  def select(adf: DataFrameWithType, ex: OpExtra): Try[(Seq[Column], AugmentedDataType)] = {
    def convert(cwt: ColumnWithType): (Seq[Column], AugmentedDataType) = {
      cwt.rectifiedSchema.topLevelStruct match {
        case Some(st) =>
          // Unroll the computations at the top.
          val cols = st.fieldNames.map(fname => cwt.col.getField(fname).as(fname)).toSeq
          cols -> cwt.rectifiedSchema
        case None =>
          Seq(cwt.col) -> cwt.rectifiedSchema
      }
    }
    val cwt = DataFrameWithType.asTypedColumn(adf)
    logger.debug(s"select: cwt=$cwt")
    for {
        p <- ProtoUtils.fromExtra[ST.Column](ex)
        trans <- fromProto(p)
        res <- select0(cwt, trans)
    } yield {
      logger.debug(s"select: trans = $trans")
      logger.debug(s"select: res = $res")
      convert(res)
    }
    
  }

  private case class Field(fieldName: FieldName, fieldTrans: StructuredTransform)

  private sealed trait StructuredTransform {
    def name: Option[String]
  }
  private case class ColStructure(
      fields: Seq[Field],
      name: Option[String]) extends StructuredTransform
  private case class ColExtraction(
      path: FieldPath,
      name: Option[String]) extends StructuredTransform
  private case class ColFunction(
      functionName: String,
      inputs: Seq[StructuredTransform],
      name: Option[String]) extends StructuredTransform

  private def fromProto(t: ST.Column): Try[StructuredTransform] = {
    val fname = Option(t.fieldName)
    t.content match {
      case ST.Column.Content.Function(ST.ColumnFunction(fnam, cf)) =>
        val ops = sequence(cf.map(fromProto))
        if (fnam == null) {
          Failure(new Exception(s"Missing name"))
        } else {
          ops.map(ops2 => ColFunction(fnam, ops2, fname))
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
      case ST.Column.Content.Empty =>
        Failure(new Exception(s"Missing content: ${t.fieldName}"))
    }
  }
  
  def checkFieldNames(s: Seq[Option[String]]): Try[Seq[FieldName]] = {
    sequence(s.map {
      case None => Failure(new Exception("Missing name"))
      case Some(s) => Success(FieldName(s))
    })
  }

  private def extractPath(cwt: ColumnWithType, fieldPath: FieldPath): Try[ColumnWithType] = {
    val adt = extractType(cwt.rectifiedSchema, fieldPath)
    val res = adt.map { adt2 =>
      val c = extractCol(cwt.col, fieldPath)
      ColumnWithType(c, adt2, cwt.ref)
    }
    logger.debug(s"extractPath: cwt=$cwt fieldPath=$fieldPath res=$res")
    res
  }


  // Returns a single column. This column may need to be denormalized after that.
  private def select0(
      cwt: ColumnWithType,
      trans: StructuredTransform): Try[ColumnWithType] = trans match {
    case ColExtraction(fieldPath, _) => extractPath(cwt, fieldPath)
    case ColFunction(funName, inputs, _) =>
      val inputst = sequence(inputs.map(select0(cwt, _)))
      inputst.flatMap(inputs =>
        SQLFunctionsExtraction.buildFunction(funName, inputs, cwt.ref))

    case ColStructure(fields, _) =>
      val fst = sequence(fields.map { f =>
        select0(cwt, f.fieldTrans).map { cwt2 =>
          val c2 = cwt2.col.as(f.fieldName.name)
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
  }


  private def extractType(adt: AugmentedDataType, path: FieldPath): Try[AugmentedDataType] = {
    (path, adt) match {
      case (FieldPath(Nil), _) =>
        Success(adt)
      case (FieldPath(h :: t), AugmentedDataType(st: StructType, nullability)) =>
        // Look into a sub field.
        st.fields.find(_.name == h.name) match {
          case None => Failure(new Exception(s"Cannot find field $h in $st"))

          case Some(StructField(_, dt, nullable, _)) =>
            val thisNullability = Nullable.fromNullability(nullable).intersect(nullability)
            extractType(AugmentedDataType(dt, thisNullability), FieldPath(t))

          case x =>
            Failure(new Exception(s"Failed to match $path in structure $st"))
        }
      case _ => Failure(new Exception(s"Should be a struct: $adt for $path"))
    }
  }

  // This is not checked, because the check is done when finding the type of the element.
  private def extractCol(col: Column, path: FieldPath): Column = path match {
    case FieldPath(Nil) => col
    case FieldPath(h :: t) =>
      extractCol(col.getField(h.name), FieldPath(t))
  }
}
