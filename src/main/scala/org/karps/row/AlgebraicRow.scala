package org.karps.row

import scala.util.{Failure, Success, Try}

import org.apache.spark.sql.Row
import org.apache.spark.sql.types._

import org.karps.structures.{AugmentedDataType, IsNullable}

import karps.core.{row => R}

/**
 * A representation of a row that is easy to manipulate with
 * algebraic datatypes.
 */
case class AlgebraicRow(cells: Seq[Cell])


object AlgebraicRow {

  import org.karps.structures.ProtoUtils.sequence
  import Cell.CellOrdering

  def fromRow(r: Row, st: StructType): Try[AlgebraicRow] = {
    Cell.from(r.toSeq, st) match {
      case Success(RowCell(c)) => Success(c)
      case Success(x) => Failure(new Exception(s"Got $x from $st -> $r"))
      case Failure(e) => Failure(e)
    }
  }

  def toRow(ar: AlgebraicRow): Row = Row(ar.cells.map(Cell.toAny):_*)
  
  def fromProto(r: R.Row): AlgebraicRow = {
    AlgebraicRow(r.values.map(Cell.fromProto))
  }

  def toProto(ar: AlgebraicRow): R.Row = {
    R.Row(ar.cells.map(Cell.toProto))
  }

  /**
   * Attempts to denormalize the row.
   */
  def denormalize(ar: AlgebraicRow): Try[Cell] = {
    ar.cells match {
      case Seq(c) => Success(c)
      case x => Failure(new Exception(s"Expected single cell, got $x"))
    }
  }


  // Defines a canonical ordering across any row and any cell.
  // The content need not match
  object RowOrdering extends Ordering[AlgebraicRow] {
    override def compare(x: AlgebraicRow, y: AlgebraicRow): Int = {
      Cell.CellOrdering.compare(RowArray(x.cells), RowArray(y.cells))
    }
  }
}

