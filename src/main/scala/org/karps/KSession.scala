package org.karps

import java.util.concurrent.Executors

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.apache.spark.sql.Row
import org.karps.row.AlgebraicRow
import org.karps.structures._

import scala.util.control.NonFatal
import scala.util.{Failure, Success, Try}



/**
 * The execution of a sequence of Spark operations.
 *
 * @param id
 */
class KSession(val id: SessionId) extends Logging {

  import KSession._

  private val executor = Executors.newSingleThreadExecutor()

  @volatile
  private[this] var state = State(new ResultCache, Map.empty)

  def compute(
      compId: ComputationId,
      raw: Seq[UntypedNode]): Unit = synchronized {
    logger.debug(s"Getting computation info (raw):\n" + UntypedNode.pprint(raw))
    def currentResults() = { state.results }
    val items = GlobalRegistry.registry.getItems(raw, id, compId, currentResults)
    logger.debug(s"Getting computation info (parsed and sorted):\n" + items.map(_.path))
    val computation = Computation.create(compId, items)
    state = state.add(compId, computation)
    update()
  }

  def status(p: GlobalPath): Option[ComputationResult] = state.results.status(p)

  def statusComputation(compId: ComputationId): Option[BatchComputationResult] = {
    state.queue.get(compId).map { comp =>
      val p = comp.output.path
      val x = state.results.computationStatus(id, compId).copy(target = p)
      val withDeps = x.results.map { case (p2, _, res) =>
        (p2, comp.itemDependencies.getOrElse(p2, Nil), res)
      }
      x.copy(results = withDeps)
    }
  }

  private def notifyFinished(path: GlobalPath, result: Try[CellWithType]): Unit = synchronized {
    result match {
      case Success(cwt) =>
        logger.debug(s"Item $path finished with a success]")
        // Extract the current stats to add them to the result.
        val stats = state.results.status(path) match {
          case Some(ComputationRunning(st)) => st
          case _ => None
        }
        state = state.updateResult(path, ComputationDone(Some(cwt), stats))
      case Failure(e: KarpsException) =>
        logger.warn(s"Item $path finished with an identified internal failure: $e", e)
        state = state.updateResult(path, ComputationFailed(e))
      case Failure(e) =>
        logger.error(s"Item $path finished with a failure: $e", e)
        state = state.updateResult(path, ComputationFailed(e))
    }
    update()
  }

  /**
   * In the case of datasets, we do not get results, but we just compute a plan
   * as a side effect.
   */
  private def notifyFinishedAnalyzed(
      path: GlobalPath,
      stats: SparkComputationStats): Unit = synchronized {
    state = state.updateResult(path, ComputationDone(None, Some(stats)))
    update()
  }

  private def notifyExecutingInSpark(path: GlobalPath, stats: SparkComputationStats): Unit = synchronized {
    state = state.updateResult(path, ComputationRunning(Some(stats)))
  }

  private def update(): Unit = synchronized {
    // Find some nodes that could be processed:
    val next = offerNext(state)
    if (next.isEmpty) {
      logger.debug("Nothing to do")
      return
    }
    logger.debug(s"Considering the following items to run: ${next.map(_.path)}")
    val nowRunning = next.map(i => i.path -> ComputationRunning(None))
    state = state.updateResults(nowRunning)
    val tasks = next.flatMap { item =>
      // Check that there was no failure before, otherwise we short-circuit the
      // computation and produce a failure.
      // The logical dependencies are also included in the failures.
      val previousFailures = (item.dependencies ++ item.logicalDependencies)
        .map(_.path)
        .filter { p =>
          state.results.status(p) match {
            case Some(_: ComputationDone) => false
            case Some(_: ComputationFailed) => true
            case None => false // Drop nodes that do not require computations.
            case x => KarpsException.fail(s"status: $x for path $p")
          }
      }
      // Check that all the parents are a success
      if (previousFailures.nonEmpty) {
        logger.debug(s"Preemptive failure of ${item.path} previous=$previousFailures, state=" +
          s"${state.results}")
        // Directly register this task as a failure.
        val t = new KarpsException(
          s"Computation aborted because a dependency failed: $previousFailures")
        state = state.updateResult(item.path, ComputationFailed(t))
        None
      } else {
        val runnable = new TaskRunnable(item, this)
        logger.debug(s"${item.path}: created runnable $runnable")
        Some(runnable)
      }
    }
    tasks.foreach(executor.submit)
  }
}

object KSession extends Logging {
  // The state of a session.
  // All the computations being run, and all the results calculated so far (or a way to
  // access these).
  private case class State(
      results: ResultCache,
      queue: Map[ComputationId, Computation]) extends Logging {

    def add(computationId: ComputationId, computation: Computation): State = {
      logger.debug(s"Adding computation: $computationId")
      logger.debug(s"Adding computation: trackedItems: ${computation.trackedItems.map(_.path)}")
      computation.itemDependencies.foreach { case (p, l) =>
        logger.debug(s"Adding computation: dependencies: $p -> $l")
      }
      // Adding all the tracked nodes to the state as scheduled, so that inbound
      // state requests can already come in while spark finishes to initialize.
      // This is only tracking the observables.
      val stateUp = computation.trackedItems.map(item => item.path -> ComputationScheduled)
      val up = results.update(stateUp)

      copy(
        queue = queue + (computationId -> computation),
        results = up)
    }

    def updateResults(up: Seq[(GlobalPath, ComputationResult)]): State = {
      up.foreach { case (p, r) => logger.debug(s"updateResults: $p -> ${r.getClass.getSimpleName}")}
      copy(results=results.update(up))
    }

    def updateResult(p: GlobalPath, cr: ComputationResult): State = {
      updateResults(Seq(p -> cr))
    }
  }

  private class TaskRunnable(
      item: ExecutionItem,
      session: KSession) extends Runnable with Logging {

    logger.debug(s"Created runnable $this")

    override def run(): Unit = {
      logger.debug(s"$this: entering run")
      try {
        logger.info(s"Trying to access RDD info for $this")
        // Force the materialization of the dependencies first.
        for (it <- item.dependencies) {
          it.dataframe
          it.logical
        }
        logger.info(s"logical: ${item.logical.hashCode()} \n${item.logical}")
        for (c <- item.logical.children) {
          logger.info(s"logical child: ${c.hashCode()} \n$c")
        }
        logger.info(s"$this: schema=${item.dataframe.schema} ${item.rectifiedDataFrameSchema}")
        logger.info(s"physical: ${item.executedPlan}")
        item.dataframe.explain(true)
        logger.info(s"Spark info for $this: rdd=${item.rddId} dependencies=${item.RDDDependencies}")
        val stats = SparkComputationStats(item.RDDDependencies)
        session.notifyExecutingInSpark(item.path, stats)
        if (item.locality == Local) {
          logger.info(s"Getting internal rows: ${item.collectedInternal}")
          logger.info(s"$this: output schema is:")
          item.dataframe.printSchema()
          logger.info(s"$this: Corrected schema is:\n${item.rectifiedDataFrameSchema}")
          logger.info(s"Getting rows: ${item.collected}")
          val rows = item.collected
          logger.debug(s"Got rows: $rows")
          val head = rows.head
          // Convert back to a cell associated to the overall type.
          // We could get the struct type from the dataframe, but as an extra precaution, it is
          // recomputed from the rectified schema.
          val cwt = CellWithType.denormalizeFromRow(head, item.rectifiedDataFrameSchema)
          logger.debug(s"run: head=$head")
          logger.debug(s"run: cwt=$cwt")
          session.notifyFinished(item.path, cwt)
        } else {
          // It is just a dataframe that we analyzed
          session.notifyFinishedAnalyzed(item.path, stats)
        }
      } catch {
        case NonFatal(e) =>
          session.notifyFinished(item.path, Failure(e))
        case t: Throwable =>
          logger.error(s"Got throwable: $t")
          throw t
      }
      logger.debug(s"Finished runnable $this")
    }

    override def toString = {
      s"Runnable[${item.path}]"
    }
  }

  def create(id: SessionId): KSession = {
    new KSession(id)
  }

  private def offerNext(state: State): Seq[ExecutionItem] = {
    state.queue.values.flatMap { comp =>
      val items = offerComp(state.results, comp)
      if (items.nonEmpty) {
        val paths = items.map(_.path)
        logger.debug(s"Computation ${comp.id}: items available for processing: $paths")
      }
      items
    } .toSeq
  }

  private def offerComp(cache: ResultCache, comp: Computation): Seq[ExecutionItem] = {
    // Look at all the nodes of a computation and see what is available
    def isAvailable(item: ExecutionItem): Boolean = cache.status(item.path) match {
      case Some(ComputationScheduled) => true
      case None => true
      case _ => false // In all the other cases, it is executing or it has been executed
    }

    def isFinished(optRes: Option[ComputationResult]): Boolean = optRes match {
      case Some(_: ComputationDone) => true
      case Some(_: ComputationFailed) => true
      case _ => false
    }

    // Return all the computations that are free to run, and for which the results have
    // finished to compute.
//    comp.trackedItems.filter(isAvailable).filter { item =>
//      comp.trackedItemDependencies(item.path)
//        .map(cache.status)
//        .forall(isFinished)
//    }
    comp.items.filter(isAvailable).filter { item =>
      comp.itemDependencies(item.path)
        .map(cache.status)
        .forall(isFinished)
    }
  }

}
