package org.karps.grpc

import scala.util.{Failure, Success}
import scala.util.Try

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.stub.StreamObserver

import org.karps.ComputationListener
import org.karps.structures._
import org.karps.brain.{Brain, CacheStatus}

import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.{graph => G}
import karps.core.interface.KarpsMainGrpc.KarpsMain


class GrpcListener(
    sessionId: SessionId,
    override val computationId: ComputationId,
    obs: StreamObserver[I.ComputationStreamResponse],
    targetPaths: Seq[Path],
    brain: Option[Brain]) extends ComputationListener with Logging {

  private var current: Map[Path, C.ComputationResult] = targetPaths.map { path =>
    val p = GlobalPath.from(sessionId, computationId, path)
    path -> ComputationResult.toProto(ComputationScheduled, p, Nil)
  }.toMap
  private var finished: Set[Path] = Set.empty

  private val baseMsg = I.ComputationStreamResponse(
    session = Some(SessionId.toProto(sessionId)),
    computation = Some(ComputationId.toProto(computationId)))

  def onComputation(comp: Computation): Unit = {
    // TODO: the computation is richer and contains some nodes that may not know about.
    logger.debug(s"$this: onComputation")
    val bcr = C.BatchComputationResult(targetPath=None, results=current.values.toSeq)
    obs.onNext(baseMsg.copy(results = Option(bcr)))
    // Do nothing, it is already done at init.
  }

  override def onAnalyzed(
      path: GlobalPath,
      stats: SparkComputationStats,
      locality: Locality): Unit = synchronized {
    val p = SparkComputationStats.toProto(stats)
    val cr = current(path.local)
    val cr2 = cr.copy(sparkStats=Some(p))
    current += path.local -> cr2
    // In the case of observables, we are not finished yet, as we wait for results.
    // No results expected for dataframes (just analysis).
    if (locality == Distributed) {
      finished += path.local
    }
    logger.debug(s"onAnalyzedDataFrame: got ${path.local} remaining: $remaining")
    obs.onNext(baseMsg.copy(
      results = Option(C.BatchComputationResult(targetPath=None, results=Seq(cr2)))
    ))
  }

  def onFinished(path: GlobalPath, result: Try[CellWithType]): Unit = {
    import C.ResultStatus._
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
      results = Option(C.BatchComputationResult(results=Seq(cr2)))
    ))
    if (isFinished) {
      logger.info(s"$this has finished, closing stream")
      obs.onCompleted()
    }
  }

  override def isFinished: Boolean = {
    remaining == 0
  }

  // Do not look at all the nodes, just the target nodes.
  private def remaining = targetPaths.filterNot(finished.contains).size

}

object GrpcListener {

}
