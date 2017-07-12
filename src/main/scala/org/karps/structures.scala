package org.karps

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
// import spray.json.DefaultJsonProtocol._

import org.karps.structures._
import karps.core.{graph => G}
import karps.core.{computation => C}

case class SparkComputationStats(
    rddInfo: Seq[RDDInfo])

object SparkComputationStats {
//   implicit val formatter = jsonFormat1(SparkComputationStats.apply)
}

/**
 * The results for a complete computation.
 */
case class BatchComputationResult(
    target: GlobalPath,
    results: Seq[(GlobalPath, Seq[GlobalPath], ComputationResult)])

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
}


// The extra information provided to an operation.
// It is a JSON string that usually maps to a protobuf structure.
case class OpExtra(content: String)

case class UntypedNode(
    locality: Locality,
    path: Path,
    op: String,
    parents: Seq[Path],
    logicalDependencies: Seq[Path],
    extra: OpExtra,
    _type: AugmentedDataType) {

  def ppString: String = {
    val ps = parents.map(p => "\n    - " + p).mkString("")
    val deps = logicalDependencies.map(p => "\n    - " + p).mkString("")
    s"""{
       |  path: $path
       |  op: $op
       |  parents:$ps
       |  dependencies:$deps
       |  extra:$extra
       |  (type):${_type}
       |  (locality): $locality
       |}
     """.stripMargin
  }
}

object UntypedNode {
  def pprint(s: Seq[UntypedNode]): String = s.map(_.ppString).mkString("\n")
}

