package org.karps

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.apache.spark.SparkContext
import org.apache.spark.scheduler.{SparkListener, SparkListenerStageCompleted, SparkListenerStageSubmitted}
import org.apache.spark.sql.SparkSession
import org.karps.ops.{HdfsPath, HdfsResourceResult, SourceStamps}
import org.karps.structures.UntypedNodeJson

class KarpsListener(manager: Manager) extends SparkListener with Logging {
  override def onStageCompleted(stageCompleted: SparkListenerStageCompleted): Unit = {
    logger.debug(s"stage completed: $stageCompleted")
  }

  override def onStageSubmitted(stageSubmitted: SparkListenerStageSubmitted): Unit = {
    logger.debug(s"stage submitted: $stageSubmitted")
  }
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
