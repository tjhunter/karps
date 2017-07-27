package org.karps.structures

import scala.util.{Failure, Success, Try}

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}

import karps.core.{graph => G}
import karps.core.{computation => C}


// The extra information provided to an operation.
// It is a JSON string that usually maps to a protobuf structure.
case class OpExtra(content: String)

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
        checkField(x.content, "content").map(OpExtra.apply)
      case None => Success(OpExtra(""))
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
}

