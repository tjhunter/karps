package org.karps.grpc


import scala.concurrent.Future

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.stub.StreamObserver

import org.karps.Manager
import org.karps.structures.{ComputationId, _}
import org.karps.brain.{Brain, BrainTransformSuccess}

import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.{graph => G}
import karps.core.interface.KarpsMainGrpc.KarpsMain
import karps.core.api_internal.KarpsRestGrpc.KarpsRest

/**
 * Wrapper for all the GRPC calls.
 *
 * A manager may not be available immediately.
 */
class GrpcManager(
    manager: Option[Manager],
    brain: Option[Brain]) extends KarpsMain with KarpsRest with Logging {

  def this() = this(None, None)

  override def createSession(proto: I.CreateSessionRequest): Future[I.CreateSessionResponse] = {
    val sessionId = SessionId.fromProto(proto.requestedSession.get).get
    current.create(sessionId)
    Future.successful(I.CreateSessionResponse())
  }

  override def createComputation(protoIn: I.CreateComputationRequest): Future[I.CreateComputationResponse] = {
    createComputation(protoIn, None)
    val protoOut = I.CreateComputationResponse()
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

  override def resourceStatus(req: I.ResourceStatusRequest): Future[I.ResourceStatusResponse] = ???

  override def streamCreateComputation(
      request: I.CreateComputationRequest,
      responseObserver: StreamObserver[I.ComputationStreamResponse]): Unit = {
    createComputation(request, Some(responseObserver))
  }

  private def current: Manager = {
    manager.orElse(GrpcManager.currentManager).getOrElse {
      throw new Exception("No manager available")
    }
  }

  private def createComputation(
      protoIn: I.CreateComputationRequest,
      responseObserver: Option[StreamObserver[I.ComputationStreamResponse]]): Unit = {
    val sessionId = SessionId.fromProto(protoIn.session.get).get
    logger.debug(s"createComputation: sessionId=$sessionId")
    val computationId = ComputationId.fromProto(protoIn.requestedComputation.get)
    logger.debug(s"createComputation: computationId=$computationId")
    logger.debug(s"createComputation: protoIn=$protoIn")
    // Conversion from functional graph to pinned graph.
    val functionalGraph = protoIn.graph.get
    val requestedPaths = protoIn.requestedPaths.map(Path.fromProto)
    val pinnedGraph: G.Graph = brain match {
      case Some(b) => b.transform(sessionId, computationId, functionalGraph, requestedPaths) match {
        case BrainTransformSuccess(g2, msgs) =>
          logger.info(s"Used brain to optimize the graph, messages:")
          for (msg <- msgs) {
            logger.info(s"- $msg")
          }
          g2
        case x =>
          logger.info(s"Brain failed to optimized graph, messages: $x")
          val e = new Exception(x.toString)
          for (obs <- responseObserver) {
            obs.onError(e)
          }
          throw new Exception(e)
      }
      case None => // Just assume the current graph is good enough
        functionalGraph
    }
    val nodes = pinnedGraph.nodes
      .map(UntypedNode.fromProto)
      .map(_.get)
    logger.debug(s"createComputation: nodes=$nodes")
    val sortedNodes = UntypedNode.sortTopo(nodes)
    logger.debug(s"createComputation: sorted nodes=$nodes")
    val l = responseObserver.map(obs =>
      new GrpcListener(sessionId, computationId, obs, sortedNodes.map(_.path), brain))
    logger.debug(s"createComputation: observers: $l")
    current.execute(sessionId, computationId, sortedNodes, l)
  }
}

object GrpcManager {
  @volatile var currentManager: Option[Manager] = None
}