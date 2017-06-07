package org.karps

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.karps.structures.CellWithType
import spray.json.DefaultJsonProtocol._

/**
 * The identifier of a spark session.
 *
 * @param id
 */
case class SessionId(id: String) extends AnyVal

/**
 * The local path in a computation. Does not include the session or the computation.
 */
case class Path private (repr: Seq[String]) extends AnyVal {

  override def toString: String = repr.mkString("/")
}

object Path {
  def create(repr: Seq[String]): Path = {
    require(repr.size >= 1, repr)
    Path(repr)
  }
}

/**
 * The ID of a computation.
 * @param repr
 */
case class ComputationId(repr: String) extends AnyVal {
  def ranBefore(other: ComputationId): Boolean = repr < other.repr
}

object ComputationId {
  val UnknownComputation = ComputationId("-1")
}

case class GlobalPath private (
    session: SessionId,
    computation: ComputationId,
    local: Path) {
  override def toString: String = {
    val p = local.repr.mkString("/")
    s"//${session.id}/${computation.repr}/$p"
  }
}

object GlobalPath {
  def from(session: SessionId, cid: ComputationId, local: Path): GlobalPath = {
    // Do an extra check on the path to remove a spurious CID.
    if (local.repr.head == cid.repr) {
      require(local.repr.length >= 2, local)
      GlobalPath(session, cid, Path(local.repr.tail))
    }
    else GlobalPath(session, cid, Path(local.repr))
  }
}

/**
 * A computation is a unit of computations (as the name suggests).
 *
 * It has a number of inputs, all with no parents, and it has a single output that is
 * an observable.
 *
 * @param id
 * @param items
 */
class Computation private (
    val id: ComputationId,
    // The items are assumed to form a DAG and be presented in topological order.
    // (the first elements are the first to be processed, the last is the final
    // observable).
    val items: Seq[ExecutionItem]) {

  import Computation._

  // TODO(?) should be extended to all the elements we need to track such as caching, files, ...
  lazy val trackedItems: Seq[ExecutionItem] = items.filter(_.locality == Local)

  lazy val output: ExecutionItem = {
    items.filter(_.locality == Local).lastOption.getOrElse {
      throw new Exception(s"computation $id: Could not find a local node in the list $items")
    }
  }

  lazy val itemDependencies: Map[GlobalPath, Seq[GlobalPath]] = {
    // We do not track nodes that have side effects for now.
    val trackedPaths = items.map(_.path)
    // Include all the dependencies (parents and logical)
    val deps = items.map { item =>
      item.path -> (item.logicalDependencies ++ item.dependencies).map(_.path)
    }.toMap
    trackedItemDeps(trackedPaths, items.map(_.path), deps)
  }

  override def toString: String = {
    s"Computation(id=${id.repr}, items=$items)"
  }
}

object Computation {

  /**
   * Checks that all the items are presented in topological order.
   */
  @throws[KarpsException]
  private def checkTopological(items: Seq[ExecutionItem]): Unit = {
    var seen: Set[GlobalPath] = Set.empty
    for (item <- items) {
      for (parentPath <- item.dependencies.map(_.path)) {
        if (!seen.contains(parentPath)) {
          KarpsException.fail(s"Element out of topological order:" +
            s"parent dependency $parentPath expected before ${item.path}")
        }
      }
      for (parentPath <- item.logicalDependencies.map(_.path)) {
        if (!seen.contains(parentPath)) {
          KarpsException.fail(s"Element out of topological order:" +
            s" logical dependency $parentPath expected before ${item.path}")
        }
      }
      seen = seen + item.path
    }
  }

  def create(id: ComputationId, items: Seq[ExecutionItem]): Computation = {
    checkTopological(items)
    assert(items.last.locality == Local, items)
    new Computation(id, items)
  }

  private type DepMap = Map[GlobalPath, Seq[GlobalPath]]

  // A map of dependencies between local elements.
  private def trackedItemDeps(
      localPaths: Seq[GlobalPath],
      allPaths: Seq[GlobalPath],
      deps: DepMap): DepMap = {
    val targetSet = localPaths.toSet
    // Compute a map for all the nodes, and then filter out for the useful elements.
    var intermediateDep: DepMap = Map.empty
    var finalDep: DepMap = Map.empty
    // Assume a topological order here.
    for (path <- allPaths) {
      // Compute the set of dependencies in all cases:
      val localDeps = deps.getOrElse(path, Seq.empty)
      // All the immediate dependencies in the target set are added
      // For the intermediate dependencies, we add their closure
      val inTarget = localDeps.filter(targetSet.contains)
      val outTarget = localDeps.filterNot(targetSet.contains)
        .flatMap(intermediateDep.get)
        .flatten
      val depClosure = inTarget ++ outTarget

      val filtDepClosure = depClosure.distinct
      if (targetSet.contains(path)) {
        finalDep += path -> filtDepClosure
      } else {
        intermediateDep += path -> filtDepClosure
      }
    }
    finalDep
  }
}

class ResultCache(
  private val map: Map[GlobalPath, ComputationResult] = Map.empty,
  private val latestValues: Map[(SessionId, Path), ComputationId] = Map.empty) extends Logging {

  def status(p: GlobalPath): Option[ComputationResult] = {
    if (p.computation == ComputationId.UnknownComputation) {
      latestValues.get((p.session, p.local)).flatMap { cid =>
        map.get(p.copy(computation = cid))
      }
    } else {
      map.get(p)
    }
  }

  def computationStatus(
      session: SessionId,
      computation: ComputationId): BatchComputationResult = {
    val x = map.keys.filter(gp => gp.computation == computation && gp.session == session)
    val l = x.flatMap { k =>
      val res = status(k)
      res.map(y => (k, Nil, y))
    }   .toList
    BatchComputationResult(null, l)
  }

  def finalResult(path: GlobalPath): Option[CellWithType] = {
    map.get(path) match {
      case Some(ComputationDone(cell, _)) => cell
      case _ => None
    }
  }

  def update(ups: Seq[(GlobalPath, ComputationResult)]): ResultCache = {
    var m = this
    for ((p, cr) <- ups) {
      // Do not forget this is fixed point...
      m = m.update(p, cr)
    }
    m
  }

  override def toString: String = {
    s"ResultCache: $map $latestValues"
  }

  private def update(path: GlobalPath, computationResult: ComputationResult): ResultCache = {
    // We may have already run a computation before.
    // If it did not end up in a failure, we are not going to recompute it.
    val bestResult = map.get(path) match {
      case Some(oldRes) =>
        ComputationResult.replaceWithMostUseful(oldRes, computationResult)
      case _ => computationResult
    }
    if (bestResult == computationResult) {
      logger.debug(s"ResultCache: update: $path -> $bestResult")
    }
    val m = map + (path -> bestResult)
    val latest = latestValues.get(path.session -> path.local) match {
        // We have seen a younger value.
      case Some(x) if path.computation.ranBefore(x) => latestValues
      case _ =>
        // We got a new value, update the index
        latestValues + ((path.session -> path.local) -> path.computation)
    }
    new ResultCache(m, latest)
  }
}

case class SparkComputationStats(
    rddInfo: Seq[RDDInfo])

object SparkComputationStats {
  implicit val formatter = jsonFormat1(SparkComputationStats.apply)
}

sealed trait Locality
case object Distributed extends Locality
case object Local extends Locality

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
