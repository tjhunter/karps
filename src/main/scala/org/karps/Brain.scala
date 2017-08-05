package org.karps

import scala.util.Try

import org.karps.CacheStatus.NodeStatus
import org.karps.structures.{ComputationId, GlobalPath, SessionId}
import karps.core.{graph => G}

/**
 * This interface takes functional graphs of computations and
 * returns graphs that are pinned to specified execution devices.
 *
 * There is currently only Spark.
 *
 * The current implementation launches an external process that
 * implements all the compiler logic.
 */
trait Brain {

  /**
   * Sends an update to the brain about the completion of a
   * calculation.
   */
  def updateStatus(g: GlobalPath, status: NodeStatus): Unit

  def transform(
      session: SessionId,
      computationId: ComputationId,
      graph: G.Graph): Try[G.Graph] // TODO: change: multiple graphs, warnings, etc.
}


object CacheStatus {
  sealed trait NodeStatus
  case object NodeComputedSuccess extends NodeStatus
  case object NodeComputedFailure extends NodeStatus
}
