package org.karps.structures

import org.apache.spark.sql.Row
import org.karps._
// import spray.json.DefaultJsonProtocol._
// import spray.json.{DefaultJsonProtocol, JsArray, JsBoolean, JsNull, JsNumber, JsString, JsValue}

// case class UntypedNodeJson(
//     locality: String,
//     path: Seq[String],
//     op: String,
//     parents: Seq[Seq[String]],
//     logicalDependencies: Seq[Seq[String]],
//     extra: JsValue,
//     _type: JsValue) {
//   def ppString: String = {
//     val ps = parents.map(p => "\n    - " + Path.create(p)).mkString("")
//     val deps = logicalDependencies.map(p => "\n    - " + Path.create(p)).mkString("")
//     s"""{
//        |  path: $path
//        |  op: $op
//        |  parents:$ps
//        |  dependencies:$deps
//        |  extra:$extra
//        |  (type):${_type}
//        |  (locality): $locality
//        |}
//      """.stripMargin
//   }
// }

// case class ComputationResultWithIdJson(
//     localPath: Seq[String],
//     pathDependencies: Seq[Seq[String]],
//     result: ComputationResultJson) extends Serializable

// case class BatchComputationResultJson(
//     targetLocalPath: Seq[String], // The target node
//     results: List[ComputationResultWithIdJson])
// 
// object BatchComputationResultJson {
//    def fromResult(status: BatchComputationResult): BatchComputationResultJson = {
//      val res = status.results.map { case (k, deps, s) =>
//        ComputationResultWithIdJson(
//          k.local.repr,
//          deps.map(_.local.repr),
//          ComputationResultJson.fromResult(s))}
//      BatchComputationResultJson(status.target.local.repr, res.toList)
//    }
// }

// case class ComputationResultJson(
//     status: String, // scheduled, running, finished_success, finished_failure
//     finalError: Option[String], // TODO: better formatting
//     finalResult: Option[CellWithType],
//     stats: Option[SparkComputationStats]) extends Serializable
// 
// object ComputationResultJson {
// 
// //   implicit val computationResultJsonFormatter = jsonFormat4(ComputationResultJson.apply)
// //   implicit val formatter1 = jsonFormat3(ComputationResultWithIdJson.apply)
// //   implicit val formatter2 = jsonFormat2(BatchComputationResultJson.apply)
// 
//   val empty = ComputationResultJson(null, None, None, None)
// 
//   def fromResult(status: ComputationResult): ComputationResultJson = status match {
//     case ComputationScheduled =>
//       empty.copy(status="scheduled")
//     case ComputationRunning(stats) =>
//       empty.copy(status="running", stats=stats)
//     case ComputationDone(cwt, stats) =>
//       empty.copy(status="finished_success", finalResult = cwt, stats=stats)
//     case ComputationFailed(e) =>
//       empty.copy(status="finished_failure", finalError = Some(e.getLocalizedMessage))
//   }
// }


// object UntypedNodeJson2 {
//   def pprint(s: Seq[UntypedNodeJson]): String = s.map(_.ppString).mkString("\n")
// }
