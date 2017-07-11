package org.karps

import scala.collection.JavaConverters._
import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
// import spray.json.{JsObject, JsValue}
import com.trueaccord.scalapb.json.JsonFormat

import org.apache.spark.sql.functions._
import org.apache.spark.sql.functions.{struct => sqlStruct}
import org.apache.spark.sql.types.StructType
import org.apache.spark.sql._

import org.karps.ops.Extraction
import org.karps.row.Cell
import org.karps.structures._
import karps.core.{computation => C}


/**
 * A dataframe, along with the type as Karps wants to see it.
 *
 * Karps and Spark differ in their handling of nullability and primitive types:
 *  - Karps allows primitive types as top-level, while Spark only accepts structures at the top
 *  level
 *  - Spark does not correctly handle nullability in a number of common situations, so the exact
 *  type has to be overridden by providing the correct data type.
 *
 * The only piece of information that does not get carried along is the metadata. It is ignored
 * for now.
 *
 * @param df the dataframe as manipulated by Spark
 * @param rectifiedSchema the type of the dataframe, as seen by Karps
 */
case class DataFrameWithType private (df: DataFrame, rectifiedSchema: AugmentedDataType)

object DataFrameWithType extends Logging {

  def create(df: DataFrame, adt: AugmentedDataType): Try[DataFrameWithType] = {
    AugmentedDataType.isCompatible(adt, df.schema) match {
      case Some(err) => Failure(new KarpsException(err))
      case None =>
        // Reset the name of the top column, if possible.
        // After long computations, this name may become very verbose.
        val df2 = adt.topLevelStruct match {
          case Some(_) => df
            // This is a top level structure, the names of the fields are already set.
          case None =>
            // The name of the top-level field is not important, reset it to 'value'.
            val fname = df.schema.fieldNames match {
              case Array(f1) => f1
              case x => KarpsException.fail(
                s"Could not extract single field name in $df")
            }
            if (fname != "value") {
              df.withColumnRenamed(fname, "value")
            } else {
              df
            }
        }
        Success(new DataFrameWithType(df2, adt))
    }
  }

  /**
   * Uses the structure of the dataframe as the strict, top-level structure.
   */
  def createFromStruct(df: DataFrame): DataFrameWithType = {
    DataFrameWithType.create(df, AugmentedDataType(df.schema, IsStrict)).get
  }

  /**
   * Creates a DFWT, assuming that the content of the dataframe is a single column that contains
   * a single row only.
   */
  def createDenormalized(df: DataFrame): Try[DataFrameWithType] = {
    df.schema.fields match {
      case Array(f) =>
        DataFrameWithType.create(df, AugmentedDataType.fromField(f))
      case x => Failure(new Exception(s"Expected dataframe with single column, got type $df"))
    }
  }

  def asColumn(adf: DataFrameWithType): Column = {
    if (adf.rectifiedSchema.isPrimitive) {
      // There should be a single column in this dataframe.
      adf.df.schema.fields match {
        case Array(f) => adf.df.col(f.name)
        case _ => throw new Exception(s"Expected single field in $adf")
      }
    } else {
      asWrappedColumn(adf)
    }
  }

  /**
   * Represents the dataframe as a column, with the same type.
   */
  def asTypedColumn(adf: DataFrameWithType): ColumnWithType = {
    ColumnWithType(asColumn(adf), adf.rectifiedSchema, adf.df)
  }

  /**
   * Unconditionnally wraps the content of the augmented dataframe into a structure. It does not
   * attempt to unpack single fields.
   */
  def asWrappedColumn(adf : DataFrameWithType): Column = {
    // Put everything in a struct, because this is the original type.
    logger.debug(s"asColumn: adf=$adf ")
    val colNames = adf.df.schema.fieldNames.toSeq
    logger.debug(s"asColumn: colNames=$colNames")
    val cols = colNames.map(n => adf.df.col(n))
    logger.debug(s"asColumn: cols=$cols")
    struct(cols: _*)

  }

  /**
   * A parallelize version that uses type information.
   */
  def fromCells(cells: Seq[CellWithType], session: SparkSession): Try[DataFrameWithType] = {
    // Check that the type is the same for all the cells:
    cells.map(_.cellType).distinct match {
      case Seq(adt) =>
        val rowType = LocalSparkConversion.normalizeDataTypeIfNeeded(adt)
        val rows: Seq[Row] = cells.map(_.row)
        val df = session.createDataFrame(rows.asJava, rowType)
        DataFrameWithType.create(df, adt)
      case x =>
        Failure(new KarpsException(s"Found multiple types: $x"))
    }
  }
}


/**
 * A data column, along with the type as Karps expects it.
 *
 * Unlike Spark's columns, it also stores its refering dataframe.
 */
case class ColumnWithType(
    col: Column,
    rectifiedSchema: AugmentedDataType,
    ref: DataFrame) {

  def alias(f: Extraction.FieldName): ColumnWithType = {
    ColumnWithType(col.alias(f.name), rectifiedSchema, ref)
  }
}

object ColumnWithType extends Logging {
  def struct(cols: ColumnWithType*): Try[ColumnWithType] = {
    val reft = cols.headOption match {
      case Some(c2) => Success(c2.ref)
      case None => Failure(new Exception("Structure cannot be empty"))
    }
    for {
      ref <- reft
      s <- Try(sqlStruct(cols.map(_.col):_*))
    } yield {
      val dt = KarpsStubs.getExpression(s).dataType
      ColumnWithType(s, AugmentedDataType(dt, IsStrict), ref)
    }
  }

  /**
   * Unconditionnally wraps the content of the augmented dataframe into a structure. It does not
   * attempt to unpack single fields.
   */
  def asWrappedColumn(adf : DataFrameWithType): Column = {
    // Put everything in a struct, because this is the original type.
    logger.debug(s"asColumn: adf=$adf ")
    val colNames = adf.df.schema.fieldNames.toSeq
    logger.debug(s"asColumn: colNames=$colNames")
    val cols = colNames.map(n => adf.df.col(n))
    logger.debug(s"asColumn: cols=$cols")
    sqlStruct(cols: _*)

  }
}

// The result of an execution item.
// It is either a dataframe (for distributed transforms) or a Row (that has been cached locally)
// for the local transforms.
sealed trait ExecutionOutput
case class LocalExecOutput(row: CellWithType) extends ExecutionOutput
case class DisExecutionOutput(df: DataFrameWithType) extends ExecutionOutput

trait OpBuilder {
  def op: String
  def build(
      parents: Seq[ExecutionOutput],
      extra: OpExtra, session: SparkSession): DataFrameWithType
}

class Registry extends Logging {

  private var ops: Map[String, OpBuilder] = Map.empty

  lazy val sparkSession: SparkSession = {
    logger.debug(s"Connecting registry $this to a Spark session")
    val s = SparkSession.builder().getOrCreate()
    logger.debug(s"Registry $this associated to Spark session $s")
    s
  }

  def addOp(builder: OpBuilder): Unit = synchronized {
    logger.debug(s"Registering ${builder.op}")
    ops += builder.op -> builder
  }

  private class SessionBuilder(
      raw: Seq[UntypedNode],
      sessionId: SessionId,
      computationId: ComputationId,
      cache: () => ResultCache) extends Logging {

    def getItem(
        raw: UntypedNode,
        done: Map[Path, ExecutionItem]): ExecutionItem = {
      val parents = raw.parents.map { path =>
        done.getOrElse(path, throw new Exception(s"Missing $path"))
      }
      val logicalDependencies = raw.logicalDependencies.map { path =>
        done.getOrElse(path, throw new Exception(s"Missing $path"))
      }
      // Special case here for the pointer constants.
      val builder = if (raw.op == "org.spark.PlaceholderCache") {
        val c = cache()
        val pointerPath = Registry.extractPointerPath(sessionId, raw.extra).get
        val res = c.status(pointerPath) match {
          case Some(d: ComputationDone) =>
            d.result.getOrElse {
              KarpsException.fail(s"Expected a finished computation for $pointerPath: $d")
            }
          case x => KarpsException.fail(
            s"Expected a finished computation for $pointerPath, got $x")
        }
        SparkRegistry.pointerOpBuilder(res)
      } else {
        ops.getOrElse(raw.op, throw new Exception(s"Operation ${raw.op} not registered"))
      }
      val path = GlobalPath.from(sessionId, computationId, raw.path)
      new ExecutionItem(parents, logicalDependencies, raw.locality,
        path, cache, builder, raw, sparkSession)
    }

    def getItems(
        todo: Seq[UntypedNode],
        done: Map[Path, ExecutionItem],
        doneInOrder: Seq[ExecutionItem]): Seq[ExecutionItem] = {
      if (todo.isEmpty) {
        return doneInOrder
      }
      // Find all the elements for which all the dependencies have been resolved:
      val (now, later) = todo.partition { raw =>
        (raw.parents ++ raw.logicalDependencies).forall(done.contains)
      }
      require(now.nonEmpty, (todo, done))
      val processed = now.map(raw => raw.path -> getItem(raw, done))
      val done2 = done ++ processed
      getItems(later, done2, doneInOrder ++ processed.map(_._2))
    }
  }

  /**
   * The items are guaranteed to be returned in topological order.
   *
   * This is not required for the raw elements.
   */
  def getItems(
      raw: Seq[UntypedNode],
      sessionId: SessionId,
      computationId: ComputationId,
      cache: () => ResultCache): Seq[ExecutionItem] = {
    val sb = new SessionBuilder(raw, sessionId, computationId, cache)
    sb.getItems(raw, Map.empty, Seq.empty)
  }
}

object Registry {
//   import JsonSparkConversions._

//   def extractPointerPath(sid: SessionId, js: OpExtra): Try[GlobalPath] = js match {
//     case JsObject(m) =>
//       for {
//         p <- getStringList(m, "path")
//         comp <- getString(m, "computation")
//       } yield {
//         GlobalPath.from(sid, ComputationId(comp), Path.create(p))
//       }
//     case _ => Failure(new Exception(s"Expected object, got $js"))
//   }
  
  def extractPointerPath(sid: SessionId, js: OpExtra): Try[GlobalPath] = {
    // TODO: could be more robust here
    val proto = JsonFormat.fromJsonString[C.PointerPath](js.content)
    Success(GlobalPath.from(sid,
      ComputationId.fromProto(proto.computation.get),
      Path.fromProto(proto.localPath.get)))
  }
}

object GlobalRegistry extends Logging {
  val registry: Registry = new Registry()

  def createBuilder(opName: String)(
      fun:(Seq[ExecutionOutput], OpExtra) => DataFrameWithType): OpBuilder = {
    new OpBuilder {
      override def op = opName
      override def build(
          p: Seq[ExecutionOutput],
          ex: OpExtra,
          session: SparkSession): DataFrameWithType = {
        fun(p, ex)
      }
    }
  }

  def createBuilderSession(opName: String)(
    fun:(Seq[ExecutionOutput], OpExtra, SparkSession) => DataFrameWithType): OpBuilder = {
    new OpBuilder {
      override def op = opName
      override def build(
          p: Seq[ExecutionOutput],
          ex: OpExtra,
          session: SparkSession): DataFrameWithType = {
        fun(p, ex, session)
      }
    }
  }

  // A builder that takes no argument other than some extra JSON input.
  def createTypedBuilder0(opName: String)(fun: OpExtra => DataFrameWithType): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], jsValue: OpExtra): DataFrameWithType = {
      require(items.isEmpty, items)
      fun(jsValue)
    }
    createBuilder(opName)(fun1)
  }

  // Builder that takes a single dataframe at the input.
  def createBuilderD(opName: String)
                    (fun: (DataFrameWithType, OpExtra) => DataFrameWithType): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], jsValue: OpExtra): DataFrameWithType = {
      items match {
        case Seq(DisExecutionOutput(adf)) => fun(adf, jsValue)
        case _ => throw new Exception(s"Unexpected input for op $opName: $items")
      }
    }
    createBuilder(opName)(fun1)
  }

  def createBuilderDD(opName: String)
                     (fun: (DataFrame, DataFrame, OpExtra) => DataFrame): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], jsValue: OpExtra): DataFrameWithType = {
      items match {
        case Seq(DisExecutionOutput(adf1), DisExecutionOutput(adf2)) =>
          // Result is distributed, no need to force denormalization?
          DataFrameWithType.createFromStruct(fun(adf1.df, adf2.df, jsValue))
        case _ => throw new Exception(s"Unexpected input for op $opName: $items")
      }
    }
    createBuilder(opName)(fun1)
  }

  def createTypedBuilderD(opName: String)(
        fun: (DataFrameWithType, OpExtra) => DataFrameWithType): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], jsValue: OpExtra): DataFrameWithType = {
      items match {
        case Seq(DisExecutionOutput(adf)) => fun(adf, jsValue)
        case _ => throw new Exception(s"Unexpected input for op $opName: $items")
      }
    }
    createBuilder(opName)(fun1)
  }

  // Because of Spark's extravagant handling of nullability, this function assumes that the result
  // is as strict as the strictness of the inputs. This is only done for the top-level operations.
  // For the types themselves, Spark is trusted.
  def createLocalBuilder2(opName: String)(fun: (Column, Column) => Column): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], js: OpExtra, session: SparkSession): DataFrameWithType = {
      val df = buildLocalDF(items, 2, session)
      val c1 = df.col("_1")
      val c2 = df.col("_2")
      buildLocalDF2(df, fun(c1, c2), nullability(items))
    }
    createBuilderSession(opName)(fun1)
  }

  def createLocalBuilder1(opName: String)(fun: Column => Column): OpBuilder = {
    def fun1(items: Seq[ExecutionOutput], js: OpExtra, session: SparkSession): DataFrameWithType = {
      val df = buildLocalDF(items, 1, session)
      val c1 = df.col("_1")
      buildLocalDF2(df, fun(c1), nullability(items))
    }
    createBuilderSession(opName)(fun1)
  }

  private def nullability(s: Seq[ExecutionOutput]): Nullable = {
    Nullable.intersect(s.map {
      case LocalExecOutput(row) => row.cellType.nullability
      case DisExecutionOutput(adf) => adf.rectifiedSchema.nullability
    })
  }

  private def buildLocalDF(
      items: Seq[ExecutionOutput],
      expectedNum: Int,
      session: SparkSession): DataFrame = {
    require(items.size == expectedNum, s"Expected $expectedNum elts, but got $items")
    val tcells = items.map {
      case LocalExecOutput(tcell) => tcell
      case x => throw new Exception(s"Expected a local output, got $x")
    }
    val fs = tcells.zipWithIndex.map { case (tcell, idx) =>
      logger.debug(s"buildLocalDF: idx=$idx tcell=$tcell rowType=${tcell.rowType}")
      tcell.rowType match {
        case StructType(Array(f)) => f.copy(name = s"_${idx + 1}")
        case x => throw new Exception(s"expected single field, got $tcell")
      }
    }
    val s = StructType(fs)
    // TODO: use a cell collection to build a row here. This is error-prone.
    logger.debug(s"buildLocalDF: s=$s")
    val rdata = tcells.map(tc => Cell.toAny(tc.cellData))
    val r = Row(rdata: _*)
    logger.debug(s"buildLocalDF: r=$r")
    val df = session.createDataFrame(Seq(r).asJava, s)
    logger.debug(s"buildLocalDF: df=$df schema=${df.schema}")
    df
  }

  private def buildLocalDF2(df: DataFrame, c: Column, overrideNl: Nullable): DataFrameWithType = {
    val dfout = df.select(c)
    // TODO: all below is just for debugging
    val res = dfout.collect().toSeq
    res match {
      case Seq(Row(x)) =>
      case _ => throw new Exception(s"Expected single row in $res")
    }
    // It is local, it should always work.
    val adf = DataFrameWithType.createDenormalized(dfout).get
    // Override the nullability of the top element, it is not to be trusted.
    val res2 = adf.copy(rectifiedSchema = adf.rectifiedSchema.copy(nullability = overrideNl))
    logger.debug(s"buildLocalDF2: dfout=$dfout schema=${dfout.schema} final=$res2")
    res2
  }
}

