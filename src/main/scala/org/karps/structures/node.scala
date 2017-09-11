package org.karps.structures

import scala.util.{Failure, Success, Try}
import org.apache.commons.codec.binary.Base64;

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import karps.core.{graph => G}
import karps.core.{computation => C}


// The extra information provided to an operation.
// It is a JSON string that usually maps to a protobuf structure.
case class OpExtra(content: Array[Byte], content64: Array[Byte])

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
  
  def fromProto(n: G.Node): Try[UntypedNode] = {
    import ProtoUtils._
    val extra = n.opExtra match {
      case Some(x) =>
        val f64 = checkField(x.contentBase64, "content_base64")
        var o = OpExtra(Array.empty, Array.empty)
        for (s <- f64) {
          o = o.copy(content64 = Base64.decodeBase64(s))
        }
        checkField(x.content, "content").map(bs => o.copy(content=bs.toByteArray))
      case None => Success(OpExtra(Array.empty, Array.empty))
    }
    val parents = n.parents.map(Path.fromProto)
    val deps = n.logicalDependencies.map(Path.fromProto)
    val adtt = checkField(n.inferedType, "type").flatMap(AugmentedDataType.fromProto)
    for {
      loc <- Locality.fromProto(n.locality)
      p <- checkField(n.path, "path").map(Path.fromProto)
      n <- checkField(n.opName, "op_name")
      x <- extra
      adt <- adtt
    } yield {
      UntypedNode(loc, p, n, parents, deps, x, adt)
    }
  }

  /**
   * Returns a sequence of nodes sorted in topological order.
   */
  def sortTopo(seq: Seq[UntypedNode]): Seq[UntypedNode] = {
    sortTopo0(seq.map { n => n -> (n.logicalDependencies ++ n.parents).toSet })
  }

  private def sortTopo0(seq: Seq[(UntypedNode, Set[Path])]): Seq[UntypedNode] = {
    if (seq.isEmpty) {
      return Nil
    }
    // Find all the nodes that have no parents.
    val (ready0, todo) = seq.partition(_._2.isEmpty)
    val ready = ready0.map(_._1)
    val readyPaths = ready.map(_.path).toSet
    val seq2 = todo.map { case (n, ps) => n -> (ps -- readyPaths)}
    ready ++ sortTopo0(seq2)
  }
}

