
// Conversions of Spark data
//
// General comments:
//  - the data is transported in compact json (no struct, only arrays): a SQL datatype
//    is always required for parsing
//  - the basic unit of type in Spark is the Row with a StructType, while the basic
//    unit of data in Karps is the Cell with a DataType. The functions below make sure
//    that the data can be converted back and forth.
package org.karps.structures

import scala.util.{Failure, Success, Try}

import org.apache.spark.sql.Row
import org.apache.spark.sql.catalyst.expressions.GenericRowWithSchema
import org.apache.spark.sql.types._

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import karps.core.{types => T}
import karps.core.{row => R}
import org.karps.row.{AlgebraicRow, Cell, RowCell, RowArray}
import org.karps.KarpsException
import org.karps.structures.ProtoUtils._


sealed trait Nullable {
  def intersect(other: Nullable): Nullable
}
case object IsStrict extends Nullable {
  override def intersect(other: Nullable): Nullable = other
}
case object IsNullable extends Nullable  {
  override def intersect(other: Nullable): Nullable = IsNullable
}

object Nullable {
  def fromNullability(isNullable: Boolean): Nullable = {
    if (isNullable) IsNullable else IsStrict
  }

  // strict if all the inputs are strict.
  def intersect(seq: Seq[Nullable]): Nullable = {
    if (seq.contains(IsNullable)) IsNullable else IsStrict
  }
}


/**
 * The basic data type used around Karps.
 *
 * This datatype compensates some issues with Spark datatypes, especially involving
 * nullability and strict structures at the top level.
 * @param dataType
 */
case class AugmentedDataType (dataType: DataType, nullability: Nullable) {

  def isPrimitive: Boolean = dataType match {
    case _: StructType => false
    case _: ArrayType => false
    case _: MapType => false
    case _ => true
  }

  /**
   * Indicates that this datatype can safely be used as a dataframe struct.
   * @return
   */
  def topLevelStruct: Option[StructType] = dataType match {
    case st: StructType if nullability == IsStrict => Some(st)
    case _ => None
  }

  def isNullable: Boolean = nullability == IsNullable

  /**
   * Pretty formatting of the output.
   */
  override def toString: String = {
    val s1 = dataType match {
      case _: IntegerType => "int"
      case _: DoubleType => "double"
      case _: StringType => "txt"
      case _: BooleanType => "bool"
      case _: LongType => "long"
      case x: ArrayType =>
        val sub = AugmentedDataType(x.elementType, Nullable.fromNullability(x.containsNull))
        "[" +  sub.toString + "]"
      case st: StructType =>
        st.fields.map { f =>
          val sub = AugmentedDataType(f.dataType, Nullable.fromNullability(f.nullable))
          val x = if (f.name.contains(" ")) { "`" + f.name + "`" } else f.name
          s"$x:$sub"
        }.mkString("{", " ", "}")
    }
    nullability match {
      case IsStrict => s1
      case IsNullable => s"$s1?"
    }
  }
}

object AugmentedDataType {
  /**
   * Wraps the corresponding type in an array: a -> [a]
   */
  def wrapArray(adt: AugmentedDataType): AugmentedDataType = {
    AugmentedDataType(ArrayType(adt.dataType, adt.isNullable), IsStrict)
  }

  /**
   * Carries the nullability information of a field, but not the name.
   */
  def fromField(f: StructField): AugmentedDataType = {
    val nl = if (f.nullable) IsNullable else IsStrict
    AugmentedDataType(f.dataType, nl)
  }
  
  def toProto(adt: AugmentedDataType): T.SQLType = {
    import T.SQLType.StrictType
    import T.SQLType.BasicType._


    val strict: StrictType = adt.dataType match {
      case _: IntegerType => StrictType.BasicType(INT)
      case _: LongType => StrictType.BasicType(INT) // TODO: fix eventually
      case _: DoubleType => StrictType.BasicType(DOUBLE)
      case _: StringType => StrictType.BasicType(STRING)
      case _: BooleanType => StrictType.BasicType(BOOL)
      case x: ArrayType =>
        val sub = AugmentedDataType(x.elementType, Nullable.fromNullability(x.containsNull))
        val sub2 = toProto(sub)
        StrictType.ArrayType(sub2)
      case st: StructType =>
        val fs = st.fields.map { f =>
          val sub = AugmentedDataType(f.dataType, Nullable.fromNullability(f.nullable))
          val sub2 = toProto(sub)
          T.StructField().withFieldName(f.name).withFieldType(sub2)
        }
        StrictType.StructType(T.StructType(fs))
    }
    T.SQLType(strictType=strict, nullable=adt.isNullable)
  }
  
  def fromProto(t: T.SQLType): Try[AugmentedDataType] = {
    val nl = checkField(t.nullable, "nullable")
    val strict = t.strictType match {
      case T.SQLType.StrictType.Empty =>
        missingField("strictType")
      case T.SQLType.StrictType.BasicType(bt) =>
        import T.SQLType.BasicType._
        bt match {
          case UNUSED => unrecognized("basic_type", 0)
          case INT => Success(IntegerType)
          case DOUBLE => Success(DoubleType)
          case STRING => Success(StringType)
          case BOOL => Success(BooleanType)
          case Unrecognized(x) => unrecognized("basic_type", x)
        }
      case T.SQLType.StrictType.StructType(T.StructType(fs)) =>
        val fs2 = fs.map {
          case T.StructField(n, Some(t2)) if n != null =>
            fromProto(t2).map(t3 => StructField(n,
                t3.dataType, t3.isNullable))
          case x => Failure(new Exception(s"Failed to interpret field: $x"))
        }
        sequence(fs2).map(fields => StructType(fields))
      case T.SQLType.StrictType.ArrayType(at) =>
        fromProto(at).map(adt => ArrayType(adt.dataType, adt.isNullable))
    }
    for {
      n <- nl
      s <- strict
    } yield AugmentedDataType(s, Nullable.fromNullability(n))
  }

  // Does not allow repeated fields
  def fromStruct(s: Seq[(String, AugmentedDataType)]): Try[AugmentedDataType] = {
    // I could never figure out if Spark allows repeated field names -> disallow.
    if (s.map(_._1).distinct.size != s.size) {
      Failure(new KarpsException(s"Duplicate fields in ${s.map(_._1)}"))
    } else {
      val fields = s.map { case (name, adt) =>
        StructField(name, adt.dataType, adt.isNullable)
      }
      val str = StructType(fields)
      Success(AugmentedDataType(str, IsStrict))
    }
  }

  def tuple(first: AugmentedDataType, others: Seq[AugmentedDataType]): AugmentedDataType = {
    val s = first +: others
    val names = (1 to s.size).map { idx => s"_$idx" }
    fromStruct(names.zip(s)).get
  }

  /**
   * Checks that the given data type is either the normalized version or equal
   * to the given ADT.
   *
   * Returns an error message if this is not the case.
   */
  def isCompatible(adt: AugmentedDataType, dt: DataType): Option[String] = (adt, dt) match {
    // The algorithm is not trivial because the nullability information may be changed at
    // any nesting level.
    // Top-level structures.
    case (AugmentedDataType(st1: StructType, IsStrict), st2: StructType) =>
      // This is a top-level structure, it should have the same type, modulo some
      // additional nullability information.
      if (transfersTo(st1, st2)) {
        None
      } else {
        Some(s"Expected top-level structure $st1, but got top-level structure $st2")
      }
    case (_, st @ StructType(Array(f))) =>
      // This is a wrapped element (either top-level non-struct or optional struct).
      // Drop the field name during the check, it is a mess for the time being.
      val adt2 = AugmentedDataType.fromField(f)
      if (transfersTo(adt.dataType, adt2.dataType)) {
        // Nullability requirements: adt2.isNullable => adt.isNullable (we may have additional
        // strictness information)
        if (!adt.isNullable || adt2.isNullable) {
          None
        } else {
          Option(s"The two normalized types have incompatible nullability:" +
            s" expected $adt, got $adt2")
        }
      } else {
        Option(s"The two normalized types are different: expected $adt, got $adt2")
      }
    case _ => Option(s"$adt is not compatible with $dt")
  }

  // The type dt1 is a subset of the type dt2
  private def transfersTo(dt1: DataType, dt2: DataType): Boolean = (dt1, dt2) match {
    case (x, y) if x == y => true
      // Special case as long as we do not have long implemented.
    case (IntegerType, LongType) => true
    case (ArrayType(t1, nl1), ArrayType(t2, nl2)) => transfersTo(t1, t2) && transfersTo(nl1, nl2)
    case (st1: StructType, st2: StructType) =>
      if (st1.fields.length != st2.fields.length) {
        false
      } else {
        st1.fields.zip(st2.fields).forall { case (f1, f2) => transfersTo(f1, f2) }
      }
  }

  private def transfersTo(f1: StructField, f2: StructField): Boolean = {
    f1.name == f2.name &&
      transfersTo(f1.nullable, f2.nullable) &&
      transfersTo(f1.dataType, f2.dataType)
  }

  private def transfersTo(null1: Boolean, null2: Boolean): Boolean = {
    ! null1 || null2
  }
}

/**
 * A collection of data cells.
 * @param cellDataType the datatype of each cell, before normalization (if
 *                     normalization happened)
 * @param normalizedCellDataType the datatype of each cell, after normalization
 * @param normalizedData the data, after normalization
 */
case class CellCollection(
    cellDataType: AugmentedDataType,
    normalizedCellDataType: StructType,
    normalizedData: Seq[AlgebraicRow])

// TODO: make recursive, so that there is never any issues with the type!
/**
 * A single cell. This is how an observable is represented.
 * @param cellData the data in the cell. It can contain nulls.
 * @param cellType the type of the cell.
 */
case class CellWithType(cellData: Cell, cellType: AugmentedDataType) {
  lazy val rowType: StructType =
    LocalSparkConversion.normalizeDataTypeIfNeeded(cellType)

  lazy val row: GenericRowWithSchema = {
    val r = Cell.toStruct(cellData).getOrElse {
      Row(Cell.toAny(cellData))
    }
    new GenericRowWithSchema(r.toSeq.toArray, rowType)
  }
}

object CellWithType {

  def makeTuple(field1: CellWithType, fields: Seq[CellWithType]): CellWithType = {
    val cellswt = field1 +: fields
    val adt = AugmentedDataType.tuple(field1.cellType, fields.map(_.cellType))
    CellWithType(RowCell(AlgebraicRow(cellswt.map(_.cellData))), adt)
  }

  /**
   * Takes some data that may have been normalized, and attempts to expose it as unnormalized
   * data again.
   */
  def denormalizeFromRow(row: Row, dt: AugmentedDataType): Try[CellWithType] = {
    val ct = dt.topLevelStruct match {
      case Some(st) =>
        // This is a top-level row, no need to denormalize
        AlgebraicRow.fromRow(row, st).map(RowCell.apply)
      case None =>
        // Convert the row first using the normalized schema, then attempt to access the content.
        val st = LocalSparkConversion.normalizeDataTypeIfNeeded(dt)
        for {
          ar <- AlgebraicRow.fromRow(row, st)
          dn <- AlgebraicRow.denormalize(ar)
        } yield {
          dn
        }
    }
    for (cell <- ct) yield { CellWithType(cell, dt) }
  }
  
  def fromProto(p: R.CellWithType): Try[CellWithType] = {
    for {
      pc <- checkField(p.cell, "cell")
      pt <- checkField(p.cellType, "cell_type")
      t <- AugmentedDataType.fromProto(pt)
    } yield {
      val c = Cell.fromProto(pc)
      CellWithType(c, t)
    }
  }
  
  def toProto(p: CellWithType): R.CellWithType = {
    R.CellWithType(
      cell = Some(Cell.toProto(p.cellData)),
      cellType = Some(AugmentedDataType.toProto(p.cellType))
    )
  }
}

object LocalSparkConversion {

  /**
   * Takes an augmented data type and attempts to convert it to a top-level struct that is
   * compatible with Spark data representation: strict top-level structures go through, everything
   * else is wrapped in a top-level struct with a single field.
   */
  def normalizeDataTypeIfNeeded(adt: AugmentedDataType): StructType = adt match {
    case AugmentedDataType(st: StructType, IsStrict) =>
      st
    case _ => normalizeDataType(adt)
  }

  private def normalizeDataType(adt: AugmentedDataType): StructType = {
    val f = StructField(
      "_1",
      adt.dataType, nullable = adt.nullability == IsNullable,
      metadata = Metadata.empty)
    StructType(Array(f))
  }
}

/**
 * Performs a number of conversions between the data as represented by karps
 * and the data accepted by Spark.
 *
 * All the data in a dataframe or in a row has to be a struct, but karps also
 * accepts primitive, non-nullable datatypes to be represented in a dataframe
 * or in a row. This is why there is a normalization process.
 * All data which is a non-nullable, primitive type associated with column name "_1
 * is automatically converted back and forth with the corresponding primitive type
 * The name _1 is already reserved for tuples, so it should not cause some ambiguity.
 *
 * All the observables are unconditionally wrapped into a structure with a single
 * non-nullable field called _1. This allows a representation that handles both
 * primitive and non-primitive types in a uniform manner.
 */
object DistributedSparkConversion extends Logging {
  
  // Takes a cell with a type and attempts to convert it to a cell collection.
  def deserializeDistributed(cwt: CellWithType): Try[CellCollection] = {
    logger.info(s"deserializeDistributed: cwt=$cwt")
    (cwt.cellData, cwt.cellType) match {
      case (RowArray(seq), AugmentedDataType(ArrayType(inner, nl2), nl)) if nl == IsStrict =>
        val rows = seq.map(normalizeCell)
        val adt = AugmentedDataType(inner, Nullable.fromNullability(nl2))
        val st = LocalSparkConversion.normalizeDataTypeIfNeeded(adt)
        logger.info(s"deserializeDistributed: adt=$adt st=$st rows=$rows")
        Success(CellCollection(adt, st, rows))
      case x => Failure(new Exception(s"Expected array, got $x"))
    }
  }

  /**
   * Takes a cell data and build a normalized representation of it: top-level rows go through,
   * everything else is wrapped in a row.
   * @param c
   * @return
   */
  private def normalizeCell(c: Cell): AlgebraicRow = c match {
    case RowCell(r) => r
    case _ => AlgebraicRow(Seq(c))
  }
}
