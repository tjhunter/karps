package org.karps

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import scala.concurrent.Future

import org.apache.spark.SparkContext
import org.apache.spark.scheduler.{SparkListener, SparkListenerStageCompleted, SparkListenerStageSubmitted}
import org.apache.spark.sql.SparkSession

import org.karps.ops.{HdfsPath, HdfsResourceResult, SourceStamps}
import org.karps.structures._
import karps.core.{interface => I}
import karps.core.{computation => C}
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
class GrpcManager(manager: Option[Manager]) extends KarpsMain with Logging {

  def this() = this(None)

  override def createSession(proto: I.CreateSessionRequest): Future[I.CreateSessionResponse] = {
    val sessionId = SessionId.fromProto(proto.requestedSession.get).get
    current.create(sessionId)
    Future.successful(I.CreateSessionResponse())
  }
  
  override def createComputation(protoIn: I.CreateComputationRequest): Future[I.CreateComputationResponse] = {
    val sessionId = SessionId.fromProto(protoIn.session.get).get
    val computationId =
      ComputationId.fromProto(protoIn.requestedComputation.get)
    val nodes =
      protoIn.graph.get.nodes
        .map(UntypedNode.fromProto).map(_.get)
    
    current.execute(sessionId, computationId, nodes)
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

  private def current: Manager = {
    manager.orElse(GrpcManager.currentManager).getOrElse {
      throw new Exception("No manager available")
    }
  }
}

object GrpcManager {
  @volatile var currentManager: Option[Manager] = None
}

/**
 * Manages all the sessions. Main interface with the server.
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
      data: Seq[UntypedNode]): Unit = {
    logger.debug(s"Executing computation $compId on session $session")
    sessions.get(session).get.compute(compId, data)
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
