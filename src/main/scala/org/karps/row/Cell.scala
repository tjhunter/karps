package org.karps.row

import scala.util.{Failure, Success, Try}

import org.apache.spark.sql.Row
import org.apache.spark.sql.types._

import org.karps.structures.{AugmentedDataType, IsNullable}
import karps.core.{row => R}

sealed trait Cell
case object Empty extends Cell // The null elements
case class IntElement(i: Int) extends Cell
case class DoubleElement(i: Double) extends Cell
case class StringElement(s: String) extends Cell
case class BoolElement(b: Boolean) extends Cell
// Unlike the haskell code, we need to make a distinction between the
// row and the array case during the reconstruction.
case class RowArray(seq: Seq[Cell]) extends Cell
case class RowCell(r: AlgebraicRow) extends Cell


object Cell {
  import org.karps.structures.ProtoUtils.sequence

  
  def fromProto(c: R.Cell): Cell = c.element match {
    case R.Cell.Element.Empty => Empty
    case R.Cell.Element.IntValue(i) => IntElement(i.toInt)
    case R.Cell.Element.StringValue(i) => StringElement(i)
    case R.Cell.Element.DoubleValue(i) => DoubleElement(i)
    case R.Cell.Element.BoolValue(i) => BoolElement(i)
    case R.Cell.Element.ArrayValue(R.ArrayCell(i)) =>
      RowArray(i.map(fromProto _))
    case R.Cell.Element.StructValue(arp) =>
      RowCell(AlgebraicRow.fromProto(arp))
  }
  
  def toProto(c: Cell): R.Cell = {
    import R.Cell.{Element => E}
    R.Cell(c match {
      case Empty => E.Empty
      case IntElement(i) => E.IntValue(i)
      case StringElement(s) => E.StringValue(s)
      case DoubleElement(d) => E.DoubleValue(d)
      case BoolElement(b) => E.BoolValue(b)
      case RowArray(cells) => E.ArrayValue(R.ArrayCell(cells.map(toProto)))
      case RowCell(ar) => E.StructValue(AlgebraicRow.toProto(ar))
    })
  }

  object CellOrdering extends Ordering[Cell] {
    override def compare(x: Cell, y: Cell): Int = compareCells(x, y)
  }


  private def cellsOrdering = Ordering.Iterable[Cell](CellOrdering)

  private def compareCells(x: Cell, y: Cell): Int = (x, y) match {
    case (IntElement(i1), IntElement(i2)) =>
      Ordering.Int.compare(i1, i2)
    case (IntElement(_), _) => 1
    case (_, IntElement(_)) => -1
    case (DoubleElement(i1), DoubleElement(i2)) =>
      Ordering.Double.compare(i1, i2)
    case (DoubleElement(_), _) => 1
    case (_, DoubleElement(_)) => -1
    case (StringElement(s1), StringElement(s2)) =>
      Ordering.String.compare(s1, s2)
    case (StringElement(_), _) => 1
    case (_, StringElement(_)) => -1
    case (BoolElement(b1), BoolElement(b2)) =>
      Ordering.Boolean.compare(b1, b2)
    case (BoolElement(_), _) => 1
    case (_, BoolElement(_)) => -1
    case (RowArray(seq1), RowArray(seq2)) =>
      cellsOrdering.compare(seq1, seq2)
    case (RowArray(_), _) => 1
    case (_, RowArray(_)) => -1
    case (RowCell(c1), RowCell(c2)) =>
      cellsOrdering.compare(c1.cells, c2.cells)
    case (RowCell(_), _) => 1
    case (_, RowCell(_)) => -1
    case (Empty, Empty) => 0
  }


  def toAny(c: Cell): Any = c match {
    case Empty => null
    case IntElement(i) => i
    case DoubleElement(d) => d
    case StringElement(s) => s
    case RowArray(s) => s.map(toAny)
    case RowCell(r) => AlgebraicRow.toRow(r)
    case BoolElement(b) => b
  }

  def toStruct(c: Cell): Option[Row] = c match {
    case RowCell(r) => Some(AlgebraicRow.toRow(r))
    case _ => None
  }

  def from(x: Any, dt: DataType): Try[Cell] = (x, dt) match {
    // Nulls, etc.
    case (null, _) => Success(Empty)
    case (None, _) => Success(Empty)
    case (Some(null), _) => Success(Empty)
    case (Some(y), _) => from(y, dt)
    // Primitives
    case (i: Int, t: IntegerType) => Success(IntElement(i))
    case (i: Integer, t: IntegerType) => Success(IntElement(i))
    case (i: Double, t: DoubleType) => Success(DoubleElement(i))
    case (i: java.lang.Double, t: DoubleType) => Success(DoubleElement(i))
    // TODO: proper implementation of the long type
    case (i: Long, t: LongType) => Success(IntElement(i.toInt))
    case (s: String, t: StringType) => Success(StringElement(s))
    case (b: Boolean, t: BooleanType) => Success(BoolElement(b))
    case (b: java.lang.Boolean, t: BooleanType) => Success(BoolElement(b))
    // Sequences
    case (a: Array[Any], _) => from(a.toSeq, dt)
    case (s: Seq[Any], t: ArrayType) =>
      sequence(s.map(from(_, t.elementType))).map(RowArray.apply)
    // Structures
    case (r: Row, t: StructType) =>
      from(r.toSeq, t)
    case (s: Seq[Any], t: StructType) =>
      val elts = s.zip(t.fields.map(_.dataType))
        .map { case (x2, dt2) => from(x2, dt2) }
      sequence(elts).map(ys => RowCell(AlgebraicRow(ys)))
    case _ => Failure(new Exception(s"Datatype $dt is not compatible with " +
      s"value type ${x.getClass}: $x"))
  }
}
