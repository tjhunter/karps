package org.karps.grpc


import scala.concurrent.Future

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.stub.StreamObserver
import io.grpc.Status

import org.karps.Manager
import org.karps.structures.{ComputationId, _}
import org.karps.brain.{Brain, BrainTransformSuccess, BrainTransformFailure}

import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.{graph => G}
import karps.core.{api_internal => AI}
import karps.core.interface.KarpsMainGrpc.KarpsMain
import karps.core.api_internal.KarpsRestGrpc.KarpsRest

/**
 * Wrapper for all the GRPC calls.
 *
 * A manager may not be available immediately.
 */
class GrpcManager(
    manager: Option[Manager],
    brain: Option[Brain]) extends KarpsMain with Logging {

  def this() = this(None, None)

  override def createSession(proto: I.CreateSessionRequest): Future[I.CreateSessionResponse] = {
    val sessionId = SessionId.fromProto(proto.requestedSession.get).get
    current.create(sessionId)
    Future.successful(I.CreateSessionResponse())
  }

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
    GrpcManager.createComputation(current, brain, protoIn, responseObserver)
  }
}

object GrpcManager extends Logging {
  @volatile var currentManager: Option[Manager] = None

  def createComputation(
      current: Manager,
      brain: Option[Brain],
      protoIn: I.CreateComputationRequest,
      responseObserver: Option[StreamObserver[I.ComputationStreamResponse]]): I.CreateComputationResponse = {
    val sessionId = SessionId.fromProto(protoIn.session.get).get
    logger.debug(s"createComputation: sessionId=$sessionId")
    val computationId = ComputationId.fromProto(protoIn.requestedComputation.get)
    logger.debug(s"createComputation: computationId=$computationId")
    logger.debug(s"createComputation: protoIn=$protoIn")
    // Conversion from functional graph to pinned graph.
    val functionalGraph = protoIn.graph.get
    val requestedPaths = protoIn.requestedPaths.map(Path.fromProto)
    val (pinnedGraph: G.Graph, phases: Seq[G.CompilationPhaseGraph]) = brain match {
      case Some(b) => b.transform(sessionId, computationId, functionalGraph, requestedPaths) match {
        case BrainTransformSuccess(g2, msgs, steps) =>
          logger.info(s"Used brain to optimize the graph, messages:")
          for (msg <- msgs) {
            logger.info(s"- $msg")
          }
          g2 -> steps
        case BrainTransformFailure(msg) =>
          logger.info(s"Brain failed to optimize graph, messages: $msg")
          val s = Status.UNKNOWN.withDescription(msg)
          val e = s.asException()
          for (obs <- responseObserver) {
            // TODO: send the graph and the results back before throwing an error.
            obs.onError(e)
          }
          throw new Exception(e)
      }
      case None => // Just assume the current graph is good enough, no compilation is happening
        functionalGraph -> Nil
    }
    // Send to the observer the result of the compilation.
    for (obs <- responseObserver) {
      obs.onNext(I.ComputationStreamResponse(
        session =  Option(SessionId.toProto(sessionId)),
        computation = Option(ComputationId.toProto(computationId)),
        startGraph = protoIn.graph,
        pinnedGraph = Option(pinnedGraph),
        compilationResult = Option(I.CompilationResult(
          compilationGraph=phases
        ))
      ))
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
    I.CreateComputationResponse()
  }
}