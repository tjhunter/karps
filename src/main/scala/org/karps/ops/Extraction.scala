package org.karps.ops

import scala.util.{Failure, Success, Try}

import org.apache.spark.sql.types.StructType
import org.karps.{ColumnWithType, DataFrameWithType}
import org.karps.structures.{AugmentedDataType, IsNullable, IsStrict}



object Extraction {

  case class FieldName(name: String)
  case class FieldPath(path: List[FieldName])


  def extractCol(col: ColumnWithType, fp: FieldPath): Try[ColumnWithType] = {
    fp match {
      case FieldPath(Seq()) => Success(col)
      case FieldPath(h :: t) =>
        for {
          col2 <- extractField(col, h)
          col3 <- extractCol(col2, FieldPath(t))
        } yield col3
    }
  }

  def extractCol(adf: DataFrameWithType, fp: FieldPath): Try[ColumnWithType] = {
    extractCol(DataFrameWithType.asTypedColumn(adf), fp)
  }

  def extractField(col: ColumnWithType, name: FieldName): Try[ColumnWithType] = {
    col.rectifiedSchema.dataType match {
      case s: StructType =>
        s.fields.find(_.name == name.name) match {
          case Some(f) =>
            val nl = if (col.rectifiedSchema.isNullable || f.nullable) IsNullable else IsStrict
            Success(ColumnWithType(col.col.getField(name.name), AugmentedDataType(f.dataType, nl)
              , col.ref))
          case None =>
            Failure(new Exception(s"Cannot find field $name in $col"))
        }
      case _ =>
        Failure(new Exception(s"Cannot find field $name in $col"))
    }
  }
}
