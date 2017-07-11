package org.karps.ops


import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.sql.{Column, DataFrame, KarpsStubs}
import org.apache.spark.sql.catalyst.analysis.FunctionRegistry
import org.karps.{ColumnWithType, DataFrameWithType, KarpsException$}
import org.karps.ops.Extraction.{FieldName, FieldPath}
import org.karps.structures._
import karps.core.{structured_transform => ST}
// import spray.json.{JsArray, JsObject, JsValue}

import scala.util.{Failure, Success, Try}


// TODO: refactor to use ColumnWithType, it will simplify things.
object ColumnTransforms extends Logging {
  import org.karps.structures.ProtoUtils.sequence

//   import org.karps.structures.JsonSparkConversions.{getString, get, sequence}

//   /**
//    * Starts from an unrectified dataframe represented as a column, and
//    * recursively extracts the requested fields.
//    * @return
//    */
//   def select(adf: DataFrameWithType, js: JsValue): Try[(Seq[Column], AugmentedDataType)] = {
//     def convert(cwt: ColumnWithType): (Seq[Column], AugmentedDataType) = {
//       cwt.rectifiedSchema.topLevelStruct match {
//         case Some(st) =>
//           // Unroll the computations at the top.
//           val cols = st.fieldNames.map(fname => cwt.col.getField(fname).as(fname)).toSeq
//           cols -> cwt.rectifiedSchema
//         case None =>
//           Seq(cwt.col) -> cwt.rectifiedSchema
//       }
//     }
//     val cwt = DataFrameWithType.asTypedColumn(adf)
//     logger.debug(s"select: cwt=$cwt")
//     for {
//         trans <- parseTrans(js)
//         res <- select0(cwt, trans)
//     } yield {
//       logger.debug(s"select: trans = $trans")
//       logger.debug(s"select: res = $res")
//       convert(res)
//     }
//   }

  private sealed trait ColOp
  private case class ColExtraction(path: FieldPath) extends ColOp
  private case class ColFunction(name: String, inputs: Seq[ColOp]) extends ColOp

  private case class Field(fieldName: FieldName, fieldTrans: StructuredTransform)

  private sealed trait StructuredTransform {
    def name: Option[String]
  }
  private case class InnerOp(op: ColOp, name: Option[String]) extends StructuredTransform
  private case class InnerStruct(fields: Seq[Field], name: Option[String]) extends StructuredTransform
  
  private def fromProto(t: ST.Column): Try[StructuredTransform] = {
    val fname = Option(t.fieldName)
    t.content match {
      case ST.Column.Content.Op(op) =>
        fromProto(op).map(co => InnerOp(co, fname))
      case ST.Column.Content.Struct(ST.ColumnStructure(fields)) =>
        val fst = sequence(fields.map(fromProto))
        for {
          fs <- fst
          fieldNames <- checkFieldNames(fs.map(_.name))
        } yield {
          val fs2 = fs.zip(fieldNames).map { case (f, fn) => Field(fn, f) }
          InnerStruct(fs2, fname)
        }
      case ST.Column.Content.Empty =>
        Failure(new Exception(s"Missing content"))
    }
  }
  
  def checkFieldNames(s: Seq[Option[String]]): Try[Seq[FieldName]] = {
    sequence(s.map {
      case None => Failure(new Exception("Missing name"))
      case Some(s) => Success(FieldName(s))
    })
  }
  
  private def fromProto(t: ST.ColumnOperation): Try[ColOp] = {
    import ST.ColumnOperation.ColOp
    t.colOp match {
      case ColOp.Empty =>
        Failure(new Exception("missing col_op"))
      case ColOp.Function(ST.ColumnFunction(fnam, cf)) =>
        val ops = sequence(cf.map(fromProto))
        if (fnam == null) {
          Failure(new Exception(s"Missing name"))
        } else {
          ops.map(ops2 => ColFunction(fnam, ops2))
        }
      case ColOp.Extraction(ST.ColumnExtraction(path)) =>
        val fp = FieldPath(path.map(FieldName.apply).toList)
        Success(ColExtraction(fp))
    }
  }
  

//   private def parseTrans(js: JsValue): Try[StructuredTransform] = js match {
//     case JsArray(arr) =>
//       sequence(arr.map(parseField)).map(arr2 => InnerStruct(arr2))
//     case obj: JsObject =>
//       parseOp(obj).map(op => InnerOp(op))
//     case x => Failure(new Exception(s"Expected array or object, got $x"))
//   }
// 
//   private def parseOp(js: JsObject): Try[ColOp] = {
//     def opSelect(s: String) = s match {
//       case "extraction" =>
//         for {
//           p <- JsonSparkConversions.getFlatten(js.fields, "field")(Extraction.getFieldPath)
//         } yield {
//           ColExtraction(p)
//         }
//       case "fun" =>
//         // It is a function
//         for {
//           fname <- JsonSparkConversions.getString(js.fields, "function")
//           p <- JsonSparkConversions.getFlatten(js.fields, "args")(parseFunArgs)
//         } yield {
//           ColFunction(fname, p)
//         }
//       case s: String =>
//         Failure(new Exception(s"Cannot understand op '$s' in $js"))
//     }
// 
//     for {
//       op <- getString(js.fields, "colOp")
//       z <- opSelect(op)
//     } yield z
//   }
// 
//   private def parseOp(js: JsValue): Try[ColOp] = js match {
//     case o: JsObject => parseOp(o)
//     case _ =>
//       Failure(new Exception(s"Expected object, got $js"))
//   }
// 
//   private def parseFunArgs(js: JsValue): Try[Seq[ColOp]] = js match {
//     case JsArray(arr) =>
//       JsonSparkConversions.sequence(arr.map(parseOp))
//     case _ =>
//       Failure(new Exception(s"expected array, got $js"))
//   }
// 
//   private def parseField(js: JsValue): Try[Field] = js match {
//     case JsObject(m) =>
//       for {
//         fName <- getString(m, "name")
//         op <- get(m, "op")
//         trans <- parseTrans(op)
//       } yield {
//         Field(FieldName(fName), trans)
//       }
//     case _ =>
//       Failure(new Exception(s"expected object, got $js"))
//   }

  private def selectOp(op: ColOp, cwt: ColumnWithType): Try[ColumnWithType] = {
    op match {
      case ColExtraction(fieldPath) => extractPath(cwt, fieldPath)
      case ColFunction(funName, inputs) =>
        val inputst = sequence(inputs.map(selectOp(_, cwt)))
        inputst.flatMap(inputs =>
          SQLFunctionsExtraction.buildFunction(funName, inputs, cwt.ref))
    }
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
    case InnerOp(colOp, _) =>
      selectOp(colOp, cwt)

    case InnerStruct(fields, _) =>
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
