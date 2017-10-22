package org.karps.grpc

import scala.annotation.tailrec
import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.stub.StreamObserver

import org.karps.ComputationListener
import org.karps.brain.{Brain, CacheStatus}
import org.karps.structures._

import karps.core.{computation => C, interface => I, profiling => P}


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
  // The list of all the events that are currently in flight.
  // They get eventually purged as the
  // Head == latest
  private var events: List[(GlobalPath, P.NodeComputationEvent)] = Nil

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

  override def onStarting(path: GlobalPath): Unit = synchronized {
    val stamp = System.nanoTime()
    events ::= path -> P.NodeComputationEvent(
      event = P.NodeComputationEvent.Event.BeginComputation(P.NodeComputationBeginEvent()),
      localPath = Some(Path.toProto(path.local)),
      timestamp = stamp
    )
  }

  override def onAnalyzed(
      path: GlobalPath,
      stats: SparkComputationStats,
      locality: Locality): Unit = synchronized {
    val stamp = System.nanoTime()
    events ::= path -> P.NodeComputationEvent(
      event = P.NodeComputationEvent.Event.EndComputation(P.NodeComputationEndEvent()),
      localPath = Some(Path.toProto(path.local)),
      timestamp = stamp
    )
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
    val stamp = System.nanoTime()
    events ::= path -> P.NodeComputationEvent(
      event = P.NodeComputationEvent.Event.EndComputation(P.NodeComputationEndEvent()),
      localPath = Some(Path.toProto(path.local)),
      timestamp = stamp
    )

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
      // Send the profiling informatino first.
      val trace = P.ComputationTrace(
        chromeEvents = GrpcListener.buildChromeEvent(events),
        computationEvents = events.map(_._2).sortBy(_.timestamp)
      )
      logger.info(s"$this has finished: trace: $trace")
      obs.onNext(baseMsg.copy(
        computationTrace = Some(trace)
      ))
      obs.onCompleted()
    }
  }

  override def isFinished: Boolean = {
    remaining == 0
  }

  // Do not look at all the nodes, just the target nodes.
  private def remaining = targetPaths.filterNot(finished.contains).size
}

object GrpcListener extends Logging {
  /**
   * Takes a list of events and turns it into a list of chrome events.
   * It tries to guess the number of parallel processes that are running.
   */
  def buildChromeEvent(
      current: List[(GlobalPath, P.NodeComputationEvent)]): List[P.ChromeTraceEvent] = {
    val process = current.headOption
      .map(_._1).map(g => s"${g.session.id}:${g.computation.repr}")
      .getOrElse("<unknown session>:<unknown computation>")

    // There can be duplicates for starts and stops.
    // Take the earliest start and the latest end.
    val eventPairs = current.groupBy(_._1).mapValues { l =>
      val events2 = l.map(_._2).sortBy(_.timestamp)
      val begin = events2.find(_.event.isBeginComputation)
      val end = events2.filter(_.event.isEndComputation).lastOption
      begin -> end
    }   .toList.flatMap {
      case (p, (Some(b), Some(e))) => Some((p, b, e))
      case _ => None
    }
    // The number of slots that we ended up using.
    // TODO: debug the value here
    val numSlots = 2 * maxOverlaps(eventPairs.map(z => (z._2.timestamp, z._3.timestamp)))
    logger.debug(s"buildChromeEvent: numSlots=$numSlots")
    // Given the number of slots, simulate an allocation of the elements:
    val allocations = allocate(
      eventPairs.map(z => (z._1.local.toString, z._2.timestamp, z._3.timestamp)),
      numSlots)
    // Attribute the events to each slot.
    // This is pretty simple currently, just round-robin.
    val events = eventPairs.flatMap { case (p, b, e) =>
        val cte = P.ChromeTraceEvent(
          name=p.local.toString,
          pid=process,
          tid=allocations(p.local.toString).toString
        )
        List(
          cte.withPh("B").withTs(b.timestamp/1000),
          cte.withPh("E").withTs(e.timestamp/1000)
        )
    }
    events
  }

  private def maxOverlaps(s: Seq[(Long, Long)]): Int = {
    var current: Int = 0
    var max: Int = 0
    // They are all assumed to be different
    val s2 = s.flatMap { case (start, end) => Seq(Left(start), Right(end)) }
      .sortBy(_.fold(identity, identity))
    s2.foreach {
      case Left(x) => current += 1; max = math.max(current, max)
      case Right(x) => current -= 1
    }
    max
  }

  private def toLong(x: Either[Long, Long]) = x.fold(identity, identity)

  // Given a list of events (identified by a string) and a number of slots, assign a slot to
  // each of the events.
  private def allocate(s: Seq[(String, Long, Long)], numSlots: Int): Map[String, Int] = {
    logger.debug(s"allocate: s=$s")
    val s2 = s.flatMap { case (p, start, end) => Seq(p -> Left(start), p -> Right(end)) }
      // Remove some potential duplicate events
      .groupBy(z => z._1 -> toLong(z._2)).values.map(_.head)
      .toSeq
      .sortBy(_._2.fold(identity, identity))
      .toList
    logger.debug(s"allocate: s2=$s2")
    val current = (0 until numSlots).map(idx => idx -> None).toMap
    allocate0(s2, current, Map.empty)
  }

  @tailrec
  private def allocate0(
      l: List[(String, Either[Long, Long])],
      currentEmpty: Map[Int, Option[String]], // The string is the name of the last element here.
      done: Map[String, Int]): Map[String, Int] = l match {
    case Nil => done
    case (path, Right(_)) :: t =>
      // Mark that slot as empty.
      logger.debug(s"allocate0: right $path : currentEmpty=$currentEmpty done=$done")
      val assigned = done(path)
      val dct2 = currentEmpty + (assigned -> Some(path))
      allocate0(t, dct2, done)
    case (path, Left(_)) :: t =>
      // Find a slot
      // TODO: we should have a better allocation strategy based on the similarity between
      // the node names.
      // This way, we can have something that looks like flame graphs.
      logger.debug(s"allocate0: left $path : currentEmpty=$currentEmpty done=$done")
      val assigned = currentEmpty.keySet.min
      val done2 = done + (path -> assigned)
      val dct2 = currentEmpty - assigned
      allocate0(t, dct2, done2)
  }
}
