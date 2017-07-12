
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

// import spray.json.{JsArray, JsBoolean, JsObject, JsString, JsValue, RootJsonFormat}
// import spray.json._

import org.apache.spark.sql.Row
import org.apache.spark.sql.catalyst.expressions.GenericRowWithSchema
import org.apache.spark.sql.types._

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
  
  def fromProto(t: T.SQLType): Try[AugmentedDataType] = {
    val nl = checkField(t.nullable, "nullable")
    val strict = t.strictType match {
      case T.SQLType.StrictType.Empty =>
        missingField("strictType")
      case T.SQLType.StrictType.BasicType(bt) =>
        import T.SQLType.BasicType._
        bt match {
          case INT => Success(IntegerType)
          case DOUBLE => Success(DoubleType)
          case STRING => Success(StringType)
          case BOOL => Success(BooleanType)
          case Unrecognized(x) => unrecognized("basic_type",x)
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
//   import JsonSparkConversions.get

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



//   implicit object CellJsonFormat extends RootJsonFormat[CellWithType] {
//     override def write(c: CellWithType) = JsObject(Map(
//       "type" -> JsonSparkConversions.serializeDataType(c.cellType),
//       "content" -> Cell.toJson(c.cellData)
//     ))
// 
//     override def read(json: JsValue): CellWithType =
//       throw new Exception()
//   }
// 
// 
//   // In every case, it wraps the content in an object.
//   def deserializeLocal(js: JsValue): Try[CellWithType] = js match {
//     case JsObject(m) =>
//       for {
//         tp <- get(m, "type")
//         ct <- get(m, "content")
//         adt <- JsonSparkConversions.deserializeDataType(tp)
//         value <- Cell.fromJson(ct, adt)
//       } yield {
//         CellWithType(value, adt)
//       }
//     case x: Any =>
//       Failure(new Exception(s"not an object: $x"))
//   }
}


// object JsonSparkConversions {
// 
//   def deserializeDataType(js: JsValue): Try[AugmentedDataType] = js match {
//     case JsObject(m) =>
//       def f(j: JsValue) = j match {
//         case JsBoolean(true) => Success(IsNullable)
//         case JsBoolean(false) => Success(IsStrict)
//         case _ => Failure(new Exception(s"Not a boolean: $j"))
//       }
//       for {
//         v <- get(m, "nullable")
//         t <- get(m, "dt")
//         b <- f(v)
//         dt <- Try { DataType.fromJson(t.compactPrint) }
//       } yield {
//         AugmentedDataType(dt, b)
//       }
//     case x => Failure(new Exception(s"expected object, got $x"))
//   }
// 
//   def serializeDataType(adt: AugmentedDataType): JsValue = {
//     // First compute the type to JSON and then parse it again.
//     // This is not pretty, but it should work in any case:
//     val js = adt.dataType.json.parseJson
//     JsObject(Map(
//       "nullable" -> JsBoolean(adt.isNullable),
//       "dt" -> js
//     ))
//   }
// 
//   def sequence[T](xs : Seq[Try[T]]) : Try[Seq[T]] = (Try(Seq[T]()) /: xs) {
//     (a, b) => a flatMap (c => b map (d => c :+ d))
//   }
// 
//   def get(
//       m: Map[String, JsValue],
//       key: String): Try[JsValue] = m.get(key) match {
//     case None => Failure(new Exception(s"Missing key $key in $m"))
//     case Some(v) => Success(v)
//   }
// 
//   def getBool(
//       m: Map[String, JsValue],
//       key: String): Try[Boolean] = m.get(key) match {
//     case None => Failure(new Exception(s"Missing key $key in $m"))
//     case Some(JsBoolean(b)) => Success(b)
//     case Some(x) => Failure(new Exception(s"Wrong value $x for key $key in $m"))
//   }
// 
//   def getObject(m: Map[String, JsValue], key: String): Try[JsObject] = {
//     getFlatten(m, key) {
//       case x: JsObject => Success(x)
//       case x => Failure(new Exception(s"Expected object, got $x"))
//     }
//   }
// 
//   def getFlatten[X](m: Map[String, JsValue], key: String)(f: JsValue => Try[X]): Try[X] = {
//     m.get(key) match {
//       case None => Failure(new Exception(s"Missing key $key in $m"))
//       case Some(x) => f(x)
//     }
//   }
// 
//   def getFlattenSeq[X](m: Map[String, JsValue], key: String)(f: JsValue => Try[X]): Try[Seq[X]] = {
//     def f2(jsValue: JsValue) = jsValue match {
//       case JsArray(arr) => sequence(arr.map(f))
//       case x => Failure(new Exception(s"Expected array, got $x"))
//     }
//     getFlatten(m, key)(f2)
//   }
// 
//   def getString(
//       m: Map[String, JsValue],
//       key: String): Try[String] = m.get(key) match {
//     case None => Failure(new Exception(s"Missing key $key in $m"))
//     case Some(JsString(s)) => Success(s)
//     case Some(x) => Failure(new Exception(s"Wrong value $x for key $key in $m"))
//   }
// 
//   def getStringList(
//       m: Map[String, JsValue],
//       key: String): Try[List[String]] = m.get(key) match {
//     case None => Failure(new Exception(s"Missing key $key in $m"))
//     case Some(JsArray(arr)) => sequence(arr.map {
//       case JsString(s) => Success(s)
//       case x => Failure(new Exception(s"Expected string, got $x"))
//     }).map(_.toList)
//     case Some(x) => Failure(new Exception(s"Wrong value $x for key $key in $m"))
//   }
// 
//   def getStringListList(
//       m: Map[String, JsValue],
//       key: String): Try[Seq[Seq[String]]] = m.get(key) match {
//     case None => Failure(new Exception(s"Missing key $key in $m"))
//     case Some(JsArray(arr)) => sequence(arr.map(arr2 =>
//       getStringList(Map("k"->JsArray(arr2)), "k")))
//     case Some(x) => Failure(new Exception(s"Wrong value $x for key $key in $m"))
//   }
// 
// }

object LocalSparkConversion {

//   import JsonSparkConversions.get

//   // In every case, it wraps the content in an object.
//   def deserializeLocal(js: JsValue): Try[CellWithType] = js match {
//     case JsObject(m) =>
//       for {
//         tp <- get(m, "type")
//         ct <- get(m, "content")
//         adt <- JsonSparkConversions.deserializeDataType(tp)
//         value <- Cell.fromJson(ct, adt)
//       } yield {
//         CellWithType(value, adt)
//       }
//     case x: Any =>
//       Failure(new Exception(s"not an object: $x"))
//   }

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
object DistributedSparkConversion {

//   import JsonSparkConversions.{get, sequence}
  import LocalSparkConversion.normalizeDataType
  
  // Takes a cell with a type and attempts to convert it to a cell collection.
  def deserializeDistributed(cwt: CellWithType): Try[CellCollection] = {
    (cwt.cellData, cwt.cellType) match {
      case (RowArray(seq), AugmentedDataType(ArrayType(inner, nl2), nl)) =>
        ???
//         val normed = seq.map
      case x => Failure(new Exception(s"Expected array, got $x"))
    }
  }

//   /**
//    * Deserializes, with a normalization process to try to
//    * keep data structures while allowing primitive types.
//    * @param js a pair of cell data types and some cells.
//    */
//   def deserializeDistributed(js: JsValue): Try[CellCollection] = js match {
//     case JsObject(m) =>
//       for {
//         tp <- get(m, "cellType")
//         ct <- get(m, "content")
//         celldt <- JsonSparkConversions.deserializeDataType(tp)
//         value <- deserializeSequenceCompact(celldt, ct)
//       } yield {
//         val rows = value.map(normalizeCell)
//         val st = LocalSparkConversion.normalizeDataTypeIfNeeded(celldt)
//         CellCollection(celldt, st, rows)
//       }
//     case x: Any =>
//       Failure(new Exception(s"not an object: $x"))
//   }
// 
//   /**
//    * Deserializes the content of a sequence (which should be a sequence of cells)
//    */
//   private def deserializeSequenceCompact(
//       celldt: AugmentedDataType,
//       cells: JsValue): Try[Seq[Cell]] = cells match {
//     case JsArray(arr) =>
//       sequence(arr.map(e => Cell.fromJson(e, celldt)))
//     case x =>
//       Failure(new Exception(s"Not an array: $x"))
//   }

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
