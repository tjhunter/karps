package org.karps.structures

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import karps.core.{graph => G}
import karps.core.{computation => C}

case class SparkComputationStats(
    rddInfo: Seq[RDDInfo])

object SparkComputationStats {
  def toProto(scs: SparkComputationStats): C.SparkStats = {
    C.SparkStats(scs.rddInfo.map(RDDInfo.toProto))
  }
}

/**
 * The results for a complete computation.
 */
case class BatchComputationResult(
    target: GlobalPath,
    results: Seq[(GlobalPath, Seq[GlobalPath], ComputationResult)])

object BatchComputationResult {
  def toProto(bcr: BatchComputationResult): C.BatchComputationResult = {
    val res = bcr.results.map { case (k, deps, s) =>
      ComputationResult.toProto(s, k, deps)
    }
    C.BatchComputationResult(
      targetPath = Some(Path.toProto(bcr.target.local)),
      results = res)
  }
}    

/**
 * The state of a computation on an observable.
 */
sealed trait ComputationResult

// The computation has been inserted into the scheduler.
case object ComputationScheduled extends ComputationResult

// A task has been created for the execution item.
case class ComputationRunning(stats: Option[SparkComputationStats]) extends ComputationResult

// This item has finished to execute.
// It could either be that was only doing some analysis (dataframes),
// or that it produced a result (observables).
// Using algebraic rows to maximize the correctness of the resulting computations.
case class ComputationDone(
    result: Option[CellWithType],
    stats: Option[SparkComputationStats]) extends ComputationResult

case class ComputationFailed(msg: Throwable) extends ComputationResult

object ComputationResult {
  // Given two results, returns the one that is the most relevant.
  // Since computations are cached, we always reserve an old result, even if the
  // cache is updated with a restart result.
  def replaceWithMostUseful(m1: ComputationResult, m2: ComputationResult): ComputationResult = {
    if (priority(m1) < priority(m2)) { m2 } else { m1 }
  }

  private def priority(m: ComputationResult): Int = m match {
    case _: ComputationFailed => 0
    case ComputationScheduled => 1
    case ComputationRunning(None) => 2
    case ComputationRunning(Some(_)) => 3
    case _: ComputationDone => 4
  }
  
  def toProto(
      c: ComputationResult,
      path: GlobalPath,
      deps: Seq[GlobalPath]): C.ComputationResult = {
    import C.ResultStatus._
    val x = c match {
      case ComputationScheduled =>
        C.ComputationResult(status=SCHEDULED)
      case ComputationRunning(stats) =>
        C.ComputationResult(status=RUNNING)
      case ComputationDone(cwt, stats) =>
        C.ComputationResult(
          status=FINISHED_SUCCESS,
          finalResult = cwt.map(CellWithType.toProto),
          sparkStats = stats.map(SparkComputationStats.toProto))
      case ComputationFailed(e) =>
        C.ComputationResult(status=FINISHED_FAILURE)
          .withFinalError(e.getLocalizedMessage)
    }
    x.copy(localPath = Some(Path.toProto(path.local)), dependencies=deps.map(_.local).map(Path.toProto))
  }
}
