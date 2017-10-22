package org.karps

import java.nio.charset.Charset

import scala.collection.mutable.ArrayBuffer

import com.google.protobuf.ByteString
import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import tensorflow.attr_value._
import tensorflow.node_def._

import org.apache.spark.rdd.RDD
import org.apache.spark.sql._
import org.apache.spark.sql.catalyst.InternalRow
import org.apache.spark.sql.catalyst.analysis.UnresolvedException
import org.apache.spark.sql.catalyst.encoders.ExpressionEncoder
import org.apache.spark.sql.catalyst.plans.QueryPlan

import org.karps.structures._

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
    raw: UntypedNode,
    session: SparkSession) extends Logging {

  /**
   * The RDD dependencies.
   *
   * Unlike the lazy value below, this will not trigger computations.
   */
  def peekRDDInfo: Option[Seq[RDDInfo]] = _transientRDDInfo

  private var _execId: Option[String] = None
  private[this] var _transientRDDInfo: Option[Seq[RDDInfo]] = None

  private lazy val cacheAsUsed: ResultCache = cache()

  lazy val rectifiedDataFrameSchema = dataframeWithType.rectifiedSchema

  lazy val checkpointedDataframe: DataFrame = checkpointedDataframeWithType.df

  // TODO: this checkpointed variable is not used anymore, this is handled by the ops.
  lazy val checkpointedDataframeWithType: DataFrameWithType = {
    dataframeWithType
  }

  private lazy val dataframeWithType: DataFrameWithType = {
    val currCache = cacheAsUsed
    logger.debug(s"Creating dataframe for node: $path")
    val outputs = dependencies.map { item =>
      item.path -> currCache.finalResult(item.path).map(LocalExecOutput.apply)
        .getOrElse(DisExecutionOutput(item.checkpointedDataframeWithType))
    }
    logger.debug(s"Dependent outputs for node: $path: $outputs")
    val adf1 = builder.build(outputs.map(_._2), raw.extra, session)
    adf1
  }

  private lazy val encoderOut: ExpressionEncoder[Row] = {
    KarpsStubs.getBoundEncoder(checkpointedDataframe)
  }

  private lazy val queryExecution = checkpointedDataframe.queryExecution
  private lazy val executedPlan = queryExecution.executedPlan
  lazy val logical = KarpsStubs.logicalPlan(checkpointedDataframe)
  lazy val physical = queryExecution.sparkPlan

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

  private lazy val collectedInternal: Seq[InternalRow] = {
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
    val fringeNames: Map[RDDId, String] = dependencies
      .flatMap(_.RDDDependencies)
      .flatMap { rddi =>
        rddi.proto.map(p => rddi.id -> p.name)
      } .toMap
    val fringeHeads: Seq[String] = dependencies
      .flatMap(_.RDDDependencies.lastOption)
      .flatMap(_.proto.map(_.name))

    val res = ExecutionItem.captureRDDIds(rdd, fringe, fringeNames, fringeHeads, path.local)
    _transientRDDInfo = Option(res)
    res
  }

  lazy val infoLogical: SQLTreeInfo = {
    val deps = dependencies.map(_.infoLogical)
    ExecutionItem.captureSQLTree(path, deps, logical)
  }

  lazy val infoPhysical: SQLTreeInfo = {
    val deps = dependencies.map(_.infoPhysical)
    ExecutionItem.captureSQLTree(path, deps, physical)
  }

  def executionId: String = _execId.get
}

object ExecutionItem extends Logging {

  class TreeNodeWrap(private val tn: QueryPlan[_]) {
    override def equals(obj: scala.Any): Boolean = {
      obj.isInstanceOf[TreeNodeWrap] && obj.asInstanceOf[TreeNodeWrap].tn.fastEquals(tn)
    }

    override def hashCode(): Int = tn.hashCode()
  }

  type IMap[V] = Map[TreeNodeWrap, V]

  private def fromValues[T <: QueryPlan[T], V](
      s: Seq[(QueryPlan[T], V)]): IMap[V] = {
    s.map(z => new TreeNodeWrap(z._1.asInstanceOf[QueryPlan[_]]) -> z._2) .toMap
  }

  private def captureRDDIds[T](
      rdd: RDD[T],
      stopFringe: Seq[RDDId],
      fringeNames: Map[RDDId, String],
      dependencies: Seq[String],
      path: Path): Seq[RDDInfo] = {
    logger.debug(s"captureRDDIds: fringe = $stopFringe")
    logger.debug(s"captureRDDIds: fringe names = $fringeNames")
    val m = captureRDDIds(rdd, stopFringe.toSet, Map.empty)
    val startId = m.values.map(_.id).toSeq.sortBy(_.repr).head
    logger.debug(s"captureRDDIds: m = $m")
    val res = fillRDDProto(path, startId, fringeNames, dependencies, m)
    logger.debug(s"captureRDDIds: res = $res")
    res
  }

  private def fillRDDProto(
      path: Path,
      startId: RDDId,
      fringeNames: Map[RDDId, String],
      dependencies: Seq[String],
      rddis: Map[RDDId, RDDInfo]): Seq[RDDInfo] = {
    val infos = rddis.values.toSeq.sortBy(_.id).toList
    val otherPaths = infos.map(info =>
      info.id -> s"$path/${info.className}_${info.id.repr}").toMap
    infos.map { info =>
      val proto = {
        val n = otherPaths(info.id)
        val paths = info.parents.flatMap { pid =>
          otherPaths.get(pid).orElse(fringeNames.get(pid))
        }
        val deps = if (info.id == startId) {
          // Everything in the fringe that we did not reach.
          dependencies.map(p => "^"+p)
        } else { Nil }
        val attrs: Map[String, AttrValue] = Map(
          "name" -> toAttrValue(info.className)
        )
        NodeDef(
          name=n,
          op = info.className,
          input = paths ++ deps,
          attr=attrs
        )
      }
      info.copy(proto=Some(proto))
    }
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

  private def captureSQLTree[T <: QueryPlan[T]](
      path: GlobalPath, dependencies: Seq[SQLTreeInfo], plan: T): SQLTreeInfo = {
    val deps = fromValues(dependencies.flatMap(sti => sti.planNode.map(n =>
      n.asInstanceOf[T] -> sti)))
    logger.debug(s"captureSQLTree: deps=$deps")
    captureSQLTree0(path, deps, plan, 0)._1
  }

  private def captureSQLTree0[T <: QueryPlan[T]](
      path: GlobalPath,
      dependencies: IMap[SQLTreeInfo],
      plan: T,
      startIndex: Int): (SQLTreeInfo, Int) = {
    // The plan was already generated in one of the dependencies -> no need to further
    // process this path. The index is not changing.
    val id0 = System.identityHashCode(plan)
    val id1 = plan.hashCode()
    dependencies.get(new TreeNodeWrap(plan)) match {
      case Some(sqlti) =>
        logger.debug(s"captureSQLTree0: $path $id0 $id1 -> old plan: ${sqlti.nodeId}")
        // Disconnect this node.
        return sqlti.copy(parentNodes = Nil, proto=None, planNode = None) -> startIndex
      case None =>
        logger.debug(s"captureSQLTree0: $path $id0 $id1 -> no plan found")
    }
    val n = fancyName(plan.verboseString)
    val n2 = s"${n}_$startIndex"
    var idx = startIndex + 1
    val cs = plan.children.map { c =>
      val (sti, idx2) = captureSQLTree0(path, dependencies, c, idx)
      idx = idx2
      sti
    }
    val nodeId = path.local.toString + "/" + n2
    val proto = {
      val cPaths = cs.flatMap(c => c.proto).flatMap(p2 => Option(p2.name))
      val attrs = Map(
        "verbose" -> toAttrValue(plan.verboseString),
        "schema" -> toAttrValue(plan.schemaString),
        "id" -> toAttrValue(System.identityHashCode(plan).toString),
        "hash" -> toAttrValue(plan.hashCode().toString),
        "simple" -> toAttrValue(plan.simpleString))
      // Tensorflow conversion to indicate the dep nodes.
      val depPaths = dependencies.values.map(x => "^"+x.nodeId)
      NodeDef(
        name=nodeId,
        op = n,
        input = cPaths ++ depPaths,
        attr=attrs
      )
    }
    val untyped = Some(plan).asInstanceOf[Option[QueryPlan[_]]]
    SQLTreeInfo(nodeId, plan.verboseString, cs, proto=Some(proto), planNode = untyped) -> idx
  }

  // Performs some cleanup on the name so that it is easier to display with tensorboard.
  private def fancyName(s: String): String = {
    val s1 = s.dropWhile(c => ! c.isLetterOrDigit)
    s1.takeWhile(c => c.isDigit || c.isLetter || c == ' ').trim.replace(' ', '_')
  }

  private def toAttrValue(s: => String): AttrValue = {
    val s2 = try {
      s + ""
    } catch {
      case _: UnresolvedException[_] => "?"
    }
    val v = ByteString.copyFrom(Charset.forName("UTF-8").encode(s2))
    AttrValue(value=AttrValue.Value.S(v))
  }
}
