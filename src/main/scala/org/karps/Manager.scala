package org.karps

import scala.concurrent.Future
import scala.util.{Failure, Success}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.stub.StreamObserver
import org.apache.spark.scheduler.{SparkListener, SparkListenerStageCompleted, SparkListenerStageSubmitted}
import org.apache.spark.sql.SparkSession

import org.karps.ops.{HdfsPath, HdfsResourceResult, SourceStamps}
import org.karps.structures.{ComputationId, _}
import org.karps.brain.{Brain, CacheStatus, BrainTransformSuccess}

import scala.util.Try
import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.{graph => G}
import karps.core.interface.KarpsMainGrpc.KarpsMain


class KarpsListener(manager: Manager) extends SparkListener with Logging {
  override def onStageCompleted(stageCompleted: SparkListenerStageCompleted): Unit = {
    logger.debug(s"stage completed: $stageCompleted")
  }

  override def onStageSubmitted(stageSubmitted: SparkListenerStageSubmitted): Unit = {
    logger.debug(s"stage submitted: $stageSubmitted")
  }
}

/**
 * Wrapper for all the GRPC calls.
 *
 * A manager may not be available immediately.
 */
class GrpcManager(
    manager: Option[Manager], brain: Option[Brain]) extends KarpsMain with Logging {

  def this() = this(None, None)

  override def createSession(proto: I.CreateSessionRequest): Future[I.CreateSessionResponse] = {
    val sessionId = SessionId.fromProto(proto.requestedSession.get).get
    current.create(sessionId)
    Future.successful(I.CreateSessionResponse())
  }
  
  override def createComputation(protoIn: I.CreateComputationRequest): Future[I.CreateComputationResponse] = {
    createComputation(protoIn, None)
    val protoOut = I.CreateComputationResponse()
    Future.successful(protoOut)
  }

  override def computationStatus(protoIn: I.ComputationStatusRequest): Future[C.BatchComputationResult] = {
    val sessionId = SessionId.fromProto(protoIn.session.get).get
    val computationId =
      ComputationId.fromProto(protoIn.computation.get)
    val paths = protoIn.requestedPaths.map(Path.fromProto)
    if (paths.isEmpty) {
      val s = current.statusComputation(sessionId, computationId).getOrElse(
        throw new Exception(s"$sessionId $computationId"))
      val proto = BatchComputationResult.toProto(s)
      Future.successful(proto)
    } else {
      val p = paths.head
      val gp = GlobalPath.from(sessionId, computationId, p)
      val s = current.status(gp).getOrElse(throw new Exception(gp.toString))
      val pr1 = ComputationResult.toProto(s, gp, Nil)
      val proto = C.BatchComputationResult(Option(Path.toProto(p)), Seq(pr1))
      Future.successful(proto)
    }
  }
  
  override def resourceStatus(req: I.ResourceStatusRequest): Future[I.ResourceStatusResponse] = ???

  override def streamCreateComputation(
      request: I.CreateComputationRequest,
      responseObserver: StreamObserver[I.ComputationStreamResponse]): Unit = {
    createComputation(request, Some(responseObserver))
  }

  private def current: Manager = {
    manager.orElse(GrpcManager.currentManager).getOrElse {
      throw new Exception("No manager available")
    }
  }

  private def createComputation(
    protoIn: I.CreateComputationRequest,
    responseObserver: Option[StreamObserver[I.ComputationStreamResponse]]): Unit = {
    val sessionId = SessionId.fromProto(protoIn.session.get).get
    logger.debug(s"createComputation: sessionId=$sessionId")
    val computationId = ComputationId.fromProto(protoIn.requestedComputation.get)
    logger.debug(s"createComputation: computationId=$computationId")
    // Conversion from functional graph to pinned graph.
    val functionalGraph = protoIn.graph.get
    val pinnedGraph: G.Graph = brain match {
      case Some(b) => b.transform(sessionId, computationId, functionalGraph) match {
        case BrainTransformSuccess(g2, msgs) =>
          logger.info(s"Used brain to optimize the graph, messages:")
          for (msg <- msgs) {
            logger.info(s"- $msg")
          }
          g2
        case x =>
          logger.info(s"Brain failed to optimized graph, messages: $x")
          val e = new Exception(x.toString)
          for (obs <- responseObserver) {
            obs.onError(e)
          }
          throw new Exception(e)
      }
      case None => // Just assume the current graph is good enough
        functionalGraph
    }
    val nodes = pinnedGraph.nodes
        .map(UntypedNode.fromProto)
        .map(_.get)
    logger.debug(s"createComputation: nodes=$nodes")
    val sortedNodes = UntypedNode.sortTopo(nodes)
    logger.debug(s"createComputation: sorted nodes=$nodes")
    val l = responseObserver.map(obs =>
      new GrpcListener(sessionId, computationId, obs, sortedNodes, brain))
    logger.debug(s"createComputation: observers: $l")
    current.execute(sessionId, computationId, sortedNodes, l)
  }
}


class GrpcListener(
    sessionId: SessionId,
    override val computationId: ComputationId,
    obs: StreamObserver[I.ComputationStreamResponse],
    startNodes: Seq[UntypedNode],
    brain: Option[Brain]) extends ComputationListener with Logging {

  private var current: Map[Path, C.ComputationResult] = startNodes.map { n =>
    val p = GlobalPath.from(sessionId, computationId, n.path)
    val deps = (n.parents ++ n.logicalDependencies).map(GlobalPath.from(sessionId, computationId,
      _))
    n.path -> ComputationResult.toProto(ComputationScheduled, p, deps)
  }.toMap
  private var finished: Set[Path] = Set.empty

  private val baseMsg = I.ComputationStreamResponse(
    session = Some(SessionId.toProto(sessionId)),
    computation = Some(ComputationId.toProto(computationId)))

  def onComputation(comp: Computation): Unit = {
    logger.debug(s"$this: onComputation")
    val bcr = C.BatchComputationResult(targetPath=None, results=current.values.toSeq)
    obs.onNext(baseMsg)
    // Do nothing, it is already done at init.
  }

  override def onAnalyzed(
      path: GlobalPath,
      stats: SparkComputationStats,
      locality: Locality): Unit = synchronized {
    val p = SparkComputationStats.toProto(stats)
    val cr = current(path.local)
    current += path.local -> cr.copy(sparkStats=Some(p))
    // In the case of observables, we are not finished yet, as we wait for results.
    // No results expected for dataframes (just analysis).
    if (locality == Distributed) {
      finished += path.local
    }
    logger.debug(s"onAnalyzedDataFrame: got ${path.local} remaining: $remaining")
  }

  def onFinished(path: GlobalPath, result: Try[CellWithType]): Unit = {
    import C.ResultStatus._
    import I.ComputationStreamResponse.Updates._
    val cr = current(path.local)
    val cr2 = result match {
      case Success(cwt) =>
        cr.copy(status=FINISHED_SUCCESS, finalResult=Some(CellWithType.toProto(cwt)))
      case Failure(e) =>
        cr.copy(status=FINISHED_FAILURE, finalError=e.getLocalizedMessage)
    }
    if (result.isSuccess) {
      brain.foreach(_.updateStatus(path, CacheStatus.NodeComputedSuccess))
    }
    current += path.local -> cr2
    finished += path.local
    logger.debug(s"onFinished: got ${path.local} remaining: $remaining")
    obs.onNext(baseMsg.copy(
      updates = Results(C.BatchComputationResult(results=Seq(cr2)))
    ))
    if (isFinished) {
      logger.info(s"$this has finished, closing stream")
      obs.onCompleted()
    }
  }

  override def isFinished: Boolean = {
    remaining == 0
  }

  private def remaining = current.keys.filterNot(finished.contains).size

}

object GrpcManager {
  @volatile var currentManager: Option[Manager] = None
}

/**
 * Manages all the sessions. Main interface with the Spark server.
 */
class Manager extends Logging {

  logger.info("Manager starting")

  private var sessions: Map[SessionId, KSession] = Map.empty
  private lazy val listener = new KarpsListener(this)
  // For now, there is a unique session for everything, but it should be split
  // between each of the sessions.
  private lazy val sparkSession = SparkSession.builder().getOrCreate()

  def init(): Unit = {
    sparkSession.sparkContext.addSparkListener(listener)
    GrpcManager.currentManager = Some(this)
  }

  def create(name: SessionId): Unit = synchronized {
    if (sessions.contains(name)) {
      logger.info(s"Reconnecting to session ${name.id}")
    } else {
      logger.info(s"Creating new session ${name.id}")
      sessions += name -> KSession.create(name)
    }
  }
  
  def execute(
      session: SessionId,
      compId: ComputationId,
      data: Seq[UntypedNode],
      listener: Option[ComputationListener]): Unit = {
    logger.debug(s"Executing computation $compId on session $session")
    sessions(session).compute(compId, data, listener)
  }
  
  def status(p: GlobalPath): Option[ComputationResult] = {
    sessions.get(p.session).flatMap(_.status(p))
  }

  /**
   * The status of a whole group of computation.
   */
  def statusComputation(
      session: SessionId,
      computation: ComputationId): Option[BatchComputationResult] = {
    sessions.get(session).flatMap { ks =>
      ks.statusComputation(computation)
    }
  }
  

  def resourceStatus(session: SessionId, paths: Seq[HdfsPath]): Seq[HdfsResourceResult] = {
    sessions.get(session)
      .map(session => SourceStamps.getStamps(sparkSession, paths))
      .getOrElse(Seq.empty)
  }
  
}
