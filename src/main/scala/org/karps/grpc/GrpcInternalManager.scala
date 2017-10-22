package org.karps.grpc


import scala.concurrent.Future

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import org.karps.Manager
import org.karps.structures.{ComputationId, _}
import org.karps.ops.{HdfsResourceResult, HdfsPath}

import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.{api_internal => AI}
import karps.core.api_internal.KarpsRestGrpc.KarpsRest

/**
 * Wrapper for all the GRPC calls.
 *
 * A manager may not be available immediately.
 */
class GrpcInternalManager(
    manager: Option[Manager]) extends KarpsRest with Logging {

  def this() = this(None)

  override def createComputation(protoIn: I.CreateComputationRequest): Future[I.CreateComputationResponse] = {
    // Make sure to not call the brain here.
    // This is a special path for the haskell client which embeds the compiler already.
    val protoOut = GrpcManager.createComputation(current, None, protoIn, None)
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

  override def resourceStatus(req: AI.AnalyzeResourcesRequest): Future[AI.AnalyzeResourceResponse] = {
    val sessionId = SessionId.fromProto(req.session.get).get
    val ps = req.resources.map(_.uri).map(HdfsPath.apply)
    val res = current.resourceStatus(sessionId, ps)
    Future.successful(HdfsResourceResult.toProto(res))
  }

  private def current: Manager = {
    manager.orElse(GrpcManager.currentManager).getOrElse {
      throw new Exception("No manager available")
    }
  }
}
