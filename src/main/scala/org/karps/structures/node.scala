package org.karps.structures

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
// import spray.json.DefaultJsonProtocol._

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
}

