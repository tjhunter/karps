package org.karps

import scala.collection.mutable.ArrayBuffer
import scala.util.{Failure, Success}
import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.apache.spark.rdd.RDD
import org.apache.spark.sql._
import org.apache.spark.sql.catalyst.InternalRow
import org.apache.spark.sql.catalyst.encoders.ExpressionEncoder
import org.karps.row.Cell
import org.karps.structures.{CellWithType, UntypedNodeJson}
import spray.json.{JsArray, JsNumber, JsObject, JsString, JsValue, RootJsonFormat}


case class RDDId private (repr: Int) extends AnyVal

object RDDId {
  def fromRDD(rdd: RDD[_]): RDDId = new RDDId(rdd.id)

  implicit object MyOrdering extends Ordering[RDDId] {
    override def compare(x: RDDId, y: RDDId): Int = x.repr.compare(y.repr)
  }

  implicit object ThisFormat extends RootJsonFormat[RDDId] {
    override def write(c: RDDId) = JsNumber(c.repr)

    override def read(json: JsValue): RDDId =
      throw new Exception()
  }
}

/**
 * Some basic information about RDDs that is exposed and sent to clients.
 */
case class RDDInfo private (
  id: RDDId,
  className: String,
  repr: String, // A human-readable representation of the RDD
  parents: Seq[RDDId])

object RDDInfo {
  def fromRDD(rdd: RDD[_]): RDDInfo = {
    val parents = rdd.dependencies.map(_.rdd).map(RDDId.fromRDD)
    new RDDInfo(
      RDDId.fromRDD(rdd),
      rdd.getClass.getSimpleName,
      rdd.toString(),
      parents)
  }


  implicit object ThisFormat extends RootJsonFormat[RDDInfo] {
    override def write(c: RDDInfo) = JsObject(Map(
      "id" -> RDDId.ThisFormat.write(c.id),
      "className" -> JsString(c.className),
      "repr" -> JsString(c.repr),
      "parents" -> JsArray(c.parents.map(RDDId.ThisFormat.write).toVector)
    ))

    override def read(json: JsValue): RDDInfo =
      throw new Exception()
  }

}

/**
 * The elements that are going to be executed by the graph.
 */
class ExecutionItem(
    val dependencies: Seq[ExecutionItem],
    val logicalDependencies: Seq[ExecutionItem],
    val locality: Locality,
    val path: GlobalPath,
    cache: () => ResultCache,
    builder: OpBuilder,
    raw: UntypedNodeJson,
    session: SparkSession) extends Logging {

  /**
   * The RDD dependencies.
   *
   * Unlike the lazy value below, this will not trigger computations.
   */
  def peekRDDInfo: Option[Seq[RDDInfo]] = _transientRDDInfo

  private var _execId: Option[String] = None
  private[this] var _transientRDDInfo: Option[Seq[RDDInfo]] = None

  lazy val cacheAsUsed: ResultCache = cache()

  lazy val rectifiedDataFrameSchema = dataframeWithType.rectifiedSchema

  lazy val dataframe: DataFrame = dataframeWithType.df

  lazy val dataframeWithType: DataFrameWithType = {
    val currCache = cacheAsUsed
    logger.debug(s"Creating dataframe for node: $path")
    val outputs = dependencies.map { item =>
      item.path -> currCache.finalResult(item.path).map(LocalExecOutput.apply)
        .getOrElse(DisExecutionOutput(item.dataframeWithType))
    }
    logger.debug(s"Dependent outputs for node: $path: $outputs")
    builder.build(outputs.map(_._2), raw.extra, session)
  }

  lazy val encoderOut: ExpressionEncoder[Row] = {
    KarpsStubs.getBoundEncoder(dataframe)
  }

  lazy val queryExecution = dataframe.queryExecution
  lazy val executedPlan = queryExecution.executedPlan
  lazy val logical = queryExecution.logical

  lazy val rdd: RDD[InternalRow] = {
    // Get the execution id first.
    KarpsStubs.withNewExecutionId(session, queryExecution) {
      _execId = Option(session.sparkContext.getLocalProperty("spark.sql.execution.id"))
      require(_execId.isDefined)
    }

    KarpsStubs.withExecutionId(session.sparkContext, executionId) {
      executedPlan.execute()
    }
  }

  lazy val rddId = RDDId(rdd.id)

  lazy val collectedInternal: Seq[InternalRow] = {
    val results = ArrayBuffer[InternalRow]()
    KarpsStubs.withExecutionId(session.sparkContext, executionId) {
      rdd.collect().foreach(r => results.append(r.copy()))
    }
    results
  }

  lazy val collected: Seq[Row] = {
    collectedInternal.map(encoderOut.fromRow)
  }

  /**
   * The RDD dependencies being encompassed by this particular execution item.
   *
   * This will not include the RDDs from the parents.
   */
  lazy val RDDDependencies: Seq[RDDInfo] = {
    val fringe = dependencies.flatMap(_.RDDDependencies).map(_.id)
    val res = ExecutionItem.captureRDDIds(rdd, fringe)
    _transientRDDInfo = Option(res)
    res
  }

  def executionId: String = _execId.get
}

object ExecutionItem extends Logging {
  private case class SparkState()

  private def captureRDDIds[T](rdd: RDD[T], stopFringe: Seq[RDDId]): Seq[RDDInfo] = {
    logger.debug(s"captureRDDIds: fringe = $stopFringe")
    val m = captureRDDIds(rdd, stopFringe.toSet, Map.empty)
    val res = m.values.toSeq.sortBy(_.id).toList
    logger.debug(s"captureRDDIds: res = $res")
    res
  }

  private def captureRDDIds(
      rdd: RDD[_],
      stopFringe: Set[RDDId],
      analyzed: Map[RDDId, RDDInfo]): Map[RDDId, RDDInfo] = {
    val id = RDDId.fromRDD(rdd)
    if (stopFringe.contains(id) || analyzed.contains(id)) {
      return analyzed
    }
    val info = RDDInfo.fromRDD(rdd)
    var m = analyzed + (id -> info)
    for (child <- rdd.dependencies.map(_.rdd)) {
      m = captureRDDIds(child, stopFringe, m)
    }
    m
  }


}
