package org.karps.brain

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import java.io.BufferedReader
import java.io.DataOutputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import scala.util.control.NonFatal
import org.apache.commons.io.IOUtils

import org.karps.brain.CacheStatus.NodeComputedSuccess
import org.karps.structures.{ComputationId, GlobalPath, SessionId, Path}
import org.karps.structures.ProtoUtils

import karps.core.{graph => G}
import karps.core.{api_internal => AI}

private[brain] case class NodeId private (private val s: String)

object NodeId {
  def fromProto(p: AI.NodeId): NodeId = {
    new NodeId(p.value)
  }

  def toProto(n: NodeId): AI.NodeId = {
    AI.NodeId(value=n.s)
  }
}

/**
 * Relies on a remote process to run the brain.
 */
class HaskellBrain(address: String, port: Int) extends Brain with Logging {

  private var successes: Set[GlobalPath] = Set.empty
  private var knownNodes: Map[GlobalPath, NodeId] = Map.empty

  override def updateStatus(g: GlobalPath, status: CacheStatus.NodeStatus): Unit = {
    status match {
      case NodeComputedSuccess =>
        this.synchronized {
          successes += g
        }
      case _ =>
    }
  }

  override def transform(
      session: SessionId,
      computationId: ComputationId,
      graph: G.Graph,
      requestedPaths: Seq[Path]): BrainResult = {
    try {
      transform0(session, computationId, graph, requestedPaths)
    } catch {
      case NonFatal(e) =>
        logger.warn("brain failure", e)
        BrainTransformFailure(e.toString)
    }
  }

  def transform0(
      session: SessionId,
      computationId: ComputationId,
      graph: G.Graph,
      requestedPaths: Seq[Path]): BrainResult = {
    val success_nodes = successes.toSeq
      .flatMap(gp => knownNodes.get(gp).map { nid =>
        AI.NodeMapItem(
          node=Some(NodeId.toProto(nid)),
          path=Some(Path.toProto(gp.local)),
          computation=Some(ComputationId.toProto(gp.computation)),
          session=Some(SessionId.toProto(gp.session))
        )
      })
    val ps = requestedPaths.map(Path.toProto)
    val request = AI.PerformGraphTransform(
      session=Some(SessionId.toProto(session)),
      computation=Some(ComputationId.toProto(computationId)),
      functionalGraph=Some(graph),
      availableNodes=success_nodes,
      requestedPaths=ps
    )
    val msg = ProtoUtils.toBytes(request)
    val url = new URL(s"http://$address:$port/perform_transform")
    logger.debug(s"Sending ${msg.length} bytes to $url: \n$request")
    val con = url.openConnection().asInstanceOf[HttpURLConnection]
    con.setRequestMethod("POST")
    con.setRequestProperty("User-Agent", "karps")
    con.setDoOutput(true)
    val wr = new DataOutputStream(con.getOutputStream)
    wr.write(msg)
    wr.flush()
    wr.close()
    val responseCode = con.getResponseCode
    logger.debug(s"transform: Got response code: $responseCode")
    val in = con.getInputStream
    val s = IOUtils.toByteArray(in)
    in.close()
    logger.debug(s"transform: Got response ${s.length} bytes back")
    val proto = ProtoUtils.fromBytes[AI.GraphTransformResponse](s).get
    logger.debug(s"transform: Got response: $proto")
    val compilerPhases = proto.steps.map(HaskellBrain.convertCompilationPhase)
    val nodeMap = proto.nodeMap.map { nm =>
      GlobalPath.from(
        SessionId.fromProto(nm.session.get).get,
        ComputationId.fromProto(nm.computation.get),
        Path.fromProto(nm.path.get)) -> NodeId.fromProto(nm.node.get)
    } .toMap
    knownNodes ++= nodeMap
    val messages = proto.messages.map(_.content)
    proto.pinnedGraph match {
      case Some(g) =>
        // The transform was successful
        BrainTransformSuccess(g, messages, compilerPhases)
      case None =>
        BrainTransformFailure("") // TODO
    }
  }
}

object HaskellBrain {
  def launch(): HaskellBrain = {
    // Just return the object for now
    // TODO: find a way to launch a process from here if it does not work yet.
    new HaskellBrain("localhost", 1234)
  }

  private def convertCompilationPhase(cs: AI.CompilerStep): G.CompilationPhaseGraph = {
    G.CompilationPhaseGraph(
      phaseName = cs.phase.toString(),
      graph = cs.graph,
      errorMessage = "",
      graphDef = cs.graphDef
    )
  }
}