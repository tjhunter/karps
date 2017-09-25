package org.karps

import scala.collection.JavaConversions._
import scala.util.{Failure, Success}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.apache.spark.SparkContext
import org.apache.spark.sql._
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._

import org.karps.row.{AlgebraicRow, Cell, RowArray, RowCell}
import org.karps.ops.{ColumnTransforms, GroupedReduction, Readers, TypeConversions}
import org.karps.structures._
import karps.core.{row => R}
import karps.core.{std => S}


object SparkRegistry extends Logging {
  import GlobalRegistry._

  object ImplicitAccessor extends SQLImplicits {
    override def _sqlContext: SQLContext =
      throw new Exception(s"SQL context is not available here")
    // TODO we could access the default SQL context from the default session?
  }


  def orderRowElements(df: DataFrame): DataFrame = {
    def fun(r: Row, st: StructType, at: ArrayType): Any = {
      val ar2 = AlgebraicRow.fromRow(r, st) match {
        case Success(AlgebraicRow(Seq(RowArray(seq)))) =>
          println(s">>orderRowElements: seq=$seq")
          val s = seq.sorted(Cell.CellOrdering)
          println(s">>orderRowElements: s=$s")
          RowArray(s)
        case e =>
          throw new Exception(s"Could not convert $r of type $st: $e")
      }
      val arr = Cell.toAny(ar2)
      println(s">>orderRowElements: arr=$arr")
      arr
    }
    val schema = df.schema
    val (fname, at) = schema.fields match {
      case Array(StructField(name, dt: ArrayType, _, _)) =>
        name -> dt
      case x => throw new Exception(s"Expected one field, got $df")
    }
    def u2(r: Row) = fun(r, schema, at)
    val localUdf = org.apache.spark.sql.functions.udf(u2 _, at)
    import df.sparkSession.implicits._
    val res = df.select(localUdf(struct(df.col(fname))))
    logger.debug(s"orderRowElements: df=$df, res=$res")
    res
  }

  def unpackRowElements(df: DataFrame): DataFrame = {
    def fun(r: Row, st: StructType): Any = {
      val ar2 = AlgebraicRow.fromRow(r, st) match {
        case Success(AlgebraicRow(Seq(RowArray(seq)))) =>
          val seq2 = seq.map {
            case RowCell(AlgebraicRow(Seq(cell))) => cell
            case x => throw new Exception(s"Expected a RowArray with a single element, got $x")
          }
          println(s">>unpackRowElements: seq=$seq")
          println(s">>unpackRowElements: seq2=$seq2")
          RowArray(seq2)
        case e =>
          throw new Exception(s"Could not convert $r of type $st: $e")
      }
      val arr = Cell.toAny(ar2)
      println(s">>unpackRowElements: arr=$arr")
      arr
    }
    val schema = df.schema
    // We expect a single field with a an array that contains a struct with a single field as well.
    val (fname, at) = schema.fields match {
      case Array(StructField(name, ArrayType(StructType(Array(f)), n), _, _)) =>
        name -> ArrayType(f.dataType, containsNull = n)
      case x => throw new Exception(s"Expected one field, got $df")
    }
    def u2(r: Row) = fun(r, schema)
    val localUdf = org.apache.spark.sql.functions.udf(u2 _, at)
    import df.sparkSession.implicits._
    val res = df.select(localUdf(struct(df.col(fname))))
    logger.debug(s"orderRowElements: df=$df, res=$res")
    res
  }

  // TODO: remove
  val collect = createTypedBuilderD("org.spark.Collect") { (adf, _) =>
    val df2 = if (adf.rectifiedSchema.isNullable && adf.rectifiedSchema.isPrimitive) {
        logger.debug(s"collect: primitive+nullable")
        // Nullable and primitive, we must wrap the content (otherwise the null values get
        // discarded).
        val c0 = DataFrameWithType.asWrappedColumn(adf)
        val c = collect_list(c0)
        val coll = adf.df.groupBy().agg(c)
        unpackRowElements(coll)
    } else {
      // The other cases: wrap the content, but no need to extract the values after that.
      logger.debug(s"collect: wrapped")
      val c0 = DataFrameWithType.asColumn(adf)
      val c = collect_list(c0)
      adf.df.groupBy().agg(c)
    }
    logger.debug(s"collect: df2=$df2")
    // Ensure that the final elements are sorted
    val df3 = orderRowElements(df2)
    val schema = AugmentedDataType.wrapArray(adf.rectifiedSchema)
    logger.info(s"collect: input df: $adf ${adf.df.schema}")
    logger.info(s"collect: output df3: $df3 ${df3.schema}")
    logger.info(s"collect: output schema: $schema")
    DataFrameWithType.create(df3, schema).get
  }

  val locLiteral = createTypedBuilder0("org.spark.LocalLiteral") { z =>
    val typedCell = ProtoUtils.fromExtra[R.CellWithType](z)
        .flatMap(CellWithType.fromProto) match {
      case Success(ct) => ct
      case Failure(e) =>
        throw new Exception(s"Deserialization failed", e)
    }
    val session = SparkSession.builder().getOrCreate()
    val df = session.createDataFrame(Seq(typedCell.row), typedCell.rowType)
    DataFrameWithType.create(df, typedCell.cellType).get
  }

  val dLiteral = createTypedBuilder0("org.spark.DistributedLiteral") { z =>
    val cell = ProtoUtils.fromExtra[R.CellWithType](z)
        .flatMap(CellWithType.fromProto)
        .flatMap(DistributedSparkConversion.deserializeDistributed)
    val cellCol = cell match {
      case Success(cc) => cc
      case Failure(e) =>
        throw new Exception(s"Deserialization failed", e)
    }
    val session = SparkSession.builder().getOrCreate()
    logger.debug(s"constant: data=$cellCol")
    val rows = cellCol.normalizedData.map(AlgebraicRow.toRow)
    val df = session.createDataFrame(rows, cellCol.normalizedCellDataType)
    logger.debug(s"constant: created dataframe: df=$df cellDT=${cellCol.cellDataType}")
    DataFrameWithType.create(df, cellCol.cellDataType).get
  }

  val persist = createBuilderD("org.spark.Persist") { (adf, _) =>
    val df = adf.df
    // For now, we just use the default storage level.
    df.persist()
    // Force the materialization of the cache, as multiple
    // calls to this cache may be issued after that.
    df.count()
    adf
  }

  val cache = createBuilderD("org.spark.Cache") { (adf, _) =>
    // For now, we just use the default storage level.
    adf.df.persist()
    // Force the materialization of the cache, as multiple
    // calls to this cache may be issued after that.
    adf.df.count()
    adf
  }

  // This is a hack, it should be resolved into persist/unpersist
  val autocache = createBuilderD("org.spark.Autocache") { (adf, _) =>
    // For now, we just use the default storage level.
    adf.df.persist()
    // Force the materialization of the cache, as multiple
    // calls to this cache may be issued after that.
    adf.df.count()
    adf
  }

  val unpersist = createBuilderD("org.spark.Unpersist") { (adf, _) =>
    // The call is blocking for now, for debugging purposes.
    adf.df.unpersist(blocking = true)
    adf
  }

  // TODO: remove and replace by unpersist
  val uncache = createBuilderD("org.spark.Uncache") { (adf, _) =>
    // The call is blocking for now, for debugging purposes.
    adf.df.unpersist(blocking = true)
    adf
  }

  val broadcastPairBuilder = new OpBuilder {

    override def op: String = "org.spark.BroadcastPair"

    override def build(
        parents: Seq[ExecutionOutput],
        extra: OpExtra,
        session: SparkSession): DataFrameWithType = {
      val (dfwt, cellwt) = parents match {
        case Seq(DisExecutionOutput(x), LocalExecOutput(y)) => x -> y
        case _ => KarpsException.fail(s"Expected (dataframe, observable), got $parents")
      }
      val adt = AugmentedDataType.tuple(dfwt.rectifiedSchema, Seq(cellwt.cellType))
      val c1 = DataFrameWithType.asColumn(dfwt).as("_1")
      // The cell may need additional wrapping.
      val c2 = buildColumn(cellwt, session).as("_2")
      logger.debug(s"broadcastPairBuilder: c2=$c2")
      val df = dfwt.df.select(c1, c2)
      logger.debug(s"broadcastPairBuilder: df=$df")
      DataFrameWithType.create(df, adt).get
    }

    private def buildColumn(cwt: CellWithType, session: SparkSession): Column = {
      // Wrap the non-primitive types
      val mustWrap = cwt.cellData match {
          // The array does not need to be wrapped if it contains primitive types,
          // but it is simpler for now.
        case _: RowArray => true
        case _: RowCell => true
        case _ => false
      }
      if (mustWrap) {
        // Put the content in a UDF.
        val payload = Cell.toAny(cwt.cellData)
        def u2(x: Int) = { payload }
        val localUdf = org.apache.spark.sql.functions.udf(u2 _, cwt.cellType.dataType)
        localUdf(lit(1))
      } else {
        lit(Cell.toAny(cwt.cellData))
      }
    }
  }

  /**
   * Takes all the parents and assembles them into a local structure.
   */
  val localPackBuilder = new OpBuilder {
    override def op: String = "org.spark.LocalPack"

    override def build(
        parents: Seq[ExecutionOutput],
        extra: OpExtra,
        session: SparkSession): DataFrameWithType = {
      require(parents.nonEmpty)
      val cellswt = parents.map {
        case LocalExecOutput(row) => row
        case x => KarpsException.fail(s"org.Spark.LocalPack: Expected a local element, got $x")
      }
      val c = CellWithType.makeTuple(cellswt.head, cellswt.tail)
      DataFrameWithType.fromCells(Seq(c), session).get
    }
  }

  // A special op builder that simply wraps a result already computed.
  def pointerOpBuilder(typedCell: CellWithType): OpBuilder = new OpBuilder {
    override def op = "org.spark.PlaceholderCache"
    override def build(
        p: Seq[ExecutionOutput],
        ex: OpExtra,
        session: SparkSession): DataFrameWithType = {
      val df = session.createDataFrame(Seq(typedCell.row), typedCell.rowType)
      DataFrameWithType.create(df, typedCell.cellType).get
    }

  }

  val inferSchema = new OpBuilder {
    override def op = "org.spark.InferSchema"
    override def build(
        p: Seq[ExecutionOutput],
        ex: OpExtra,
        session: SparkSession): DataFrameWithType = {
      require(p.isEmpty, (ex, p))
      val reader = session.read
      val df = Readers.buildDF(reader, ex).get
      // We only get the schema here.
      val schema = df.schema
      val r = TypeConversions.toRow(schema)
      val r2 = AlgebraicRow.toRow(r)
      val df2 = session.sqlContext.createDataFrame(Seq(r2), TypeConversions.typeStructure)
      DataFrameWithType.create(df2, AugmentedDataType(TypeConversions.typeStructure, IsStrict)).get
    }
  }

  val dataSource = new OpBuilder {
    override def op = "org.spark.GenericDatasource"
    override def build(
        p: Seq[ExecutionOutput],
        ex: OpExtra,
        session: SparkSession): DataFrameWithType = {
      require(p.isEmpty, (ex, p))
      val reader = session.read
      val df = Readers.buildDF(reader, ex).get
      DataFrameWithType.create(df, AugmentedDataType(df.schema, IsStrict)).get
    }
  }


  val identity = createBuilderD("org.spark.Identity") { (df, _) => df }

  val filter = createBuilderD("org.spark.Filter") { (adf, _) =>
    adf.rectifiedSchema.topLevelStruct match {
      case Some(StructType(Array(f1, f2))) =>
        assert(f1.name == "filter", f1)
        assert(f1.dataType == BooleanType, f1)
        assert(f2.name == "value", f2)
        val filt = adf.df.col("filter")
        val df2 = adf.df.filter(filt === true)
        val col = df2.col("value")
        // TODO: not sure if this is correct, this should be checked.
        val cwt = ColumnWithType(col, AugmentedDataType.fromField(f2), df2)
        ColumnWithType.asDataFrame(cwt)
      case _ => KarpsException.fail(s"Expected a structure, but got $adf")
    }
  }

  val localStructuredTransforrm = new OpBuilder {

    override def op: String = "org.spark.LocalStructuredTransform"

    override def build(
        parents: Seq[ExecutionOutput],
        extra: OpExtra,
        session: SparkSession): DataFrameWithType = {
      logger.debug(s"LocalStructuredTransform: parents=$parents js=$extra")
      val adf = parents match {
        case Seq(DisExecutionOutput(dfwt)) => dfwt
        case Seq(LocalExecOutput(cwt0)) =>
          DataFrameWithType.fromCells(Seq(cwt0), session).get
      }
      val cwt = DataFrameWithType.asTypedColumn(adf)
      logger.debug(s"LocalStructuredTransform: cwt = $cwt")
      val cwt2 = ColumnTransforms.select(cwt, extra)
      logger.debug(s"LocalStructuredTransform: cwt2 = $cwt2")
      val adf2 = cwt2.map(ColumnWithType.asDataFrame)
      logger.debug(s"LocalStructuredTransform: adf2 = $adf2")
      adf2.get
    }
  }

  val select2 = new OpBuilder {

    override def op: String = "org.spark.StructuredTransform"

    override def build(
        parents: Seq[ExecutionOutput],
        extra: OpExtra, session: SparkSession): DataFrameWithType = {
      logger.debug(s"StructuredTransform: parents=$parents js=$extra")
      // Get the dataframe input:
      val adf = parents match {
        case Seq(DisExecutionOutput(dfwt)) => dfwt
        case Seq(LocalExecOutput(cwt)) =>
          DataFrameWithType.fromCells(Seq(cwt), session).get
      }
      val cwt = DataFrameWithType.asTypedColumn(adf)
      logger.debug(s"StructuredTransform: cwt = $cwt")
      val cwt2 = ColumnTransforms.select(cwt, extra)
      logger.debug(s"StructuredTransform: cwt2 = $cwt2")
      val adf2 = cwt2.map(ColumnWithType.asDataFrame)
      logger.debug(s"StructuredTransform: adf2 = $adf2")
      adf2.get
    }
  }

  val groupedReduction = createTypedBuilderD("org.spark.GroupedReduction")(
    GroupedReduction.groupReduceOrThrow)

  val structuredReduction = createTypedBuilderD("org.spark.StructuredReduce")(
    GroupedReduction.reduceOrThrow)

  val join = createBuilderDD("org.spark.Join") { (df1, df2, js) =>
    val key1f = df1.schema.fields match {
      case Array(keyf, _) => keyf
      case x => throw new Exception(s"The schema should be a (key, val), but got $x")
    }
    val key2f = df2.schema.fields match {
      case Array(keyf, _) => keyf
      case x => throw new Exception(s"The schema should be a (key, val), but got $x")
    }
    require(key1f == key2f,
      s"The two dataframe keys are not compatible: $key1f in $df1 ... $key2f in $df2")
    val extra = ProtoUtils.fromExtra[S.Join](js).get
    val joinType = extra.jointType match {
      case S.Join.JoinType.INNER => "inner"
      case x => throw new Exception(extra.toString)
    }

    require(joinType == "inner", s"Unknown join type: $joinType")

    val res = df1.join(df2, usingColumns = Seq(key1f.name), joinType = joinType)
    res
  }

  val all = Seq(
    autocache,
    broadcastPairBuilder,
    cache,
    collect,
    dLiteral,
    dataSource,
    filter,
    groupedReduction,
    identity,
    inferSchema,
    join,
    locLiteral,
    localPackBuilder,
    localStructuredTransforrm,
    persist,
    select2,
    structuredReduction,
    uncache,
    unpersist)

  def setup(): Unit = {
    all.foreach(registry.addOp)
  }
}
