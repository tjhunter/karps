package org.karps

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import org.apache.spark.SparkContext
import org.apache.spark.scheduler.{SparkListener, SparkListenerStageCompleted, SparkListenerStageSubmitted}
import org.apache.spark.sql.SparkSession
import org.karps.ops.{HdfsPath, HdfsResourceResult, SourceStamps}
import org.karps.structures.CellWithType

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
