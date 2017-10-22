package org.karps.ops

import scala.util.{Failure, Success, Try}

import org.apache.hadoop.fs.{FileSystem, Path}

import org.apache.spark.sql.SparkSession

import karps.core.{api_internal => AI, io => IO}

case class HdfsPath(s: String)

case class HdfsStamp(s: String)


sealed trait HdfsResourceResult {
  val path: HdfsPath
}
case class HdfsResourceSuccess(path: HdfsPath, stamp: HdfsStamp) extends HdfsResourceResult
case class HdfsResourceFailure(path: HdfsPath, cause: String) extends HdfsResourceResult

object HdfsResourceResult {

  def toProto(r: HdfsPath): IO.ResourcePath = IO.ResourcePath(uri=r.s)

  def toProto(r: HdfsStamp): IO.ResourceStamp = IO.ResourceStamp(data=r.s)

  def toProto(r: HdfsResourceSuccess): AI.ResourceStatus = {
    AI.ResourceStatus(
      resource = Option(toProto(r.path)),
      stamp = Option(toProto(r.stamp)))
  }

  def toProto(r: HdfsResourceFailure): AI.AnalyzeResourceResponse.FailedStatus = {
    AI.AnalyzeResourceResponse.FailedStatus(
      resource = Option(toProto(r.path)),
      error = r.cause
    )
  }

  def toProto(r: Seq[HdfsResourceResult]): AI.AnalyzeResourceResponse = {
    AI.AnalyzeResourceResponse(
      successes = r.collect { case x: HdfsResourceSuccess => toProto(x) },
      failures = r.collect { case x: HdfsResourceFailure => toProto(x) }
    )
  }
}    
    
object SourceStamps {

  def getStamps(sess: SparkSession, ps: Seq[HdfsPath]): Seq[HdfsResourceResult] = {
    val fs = FileSystem.get(sess.sparkContext.hadoopConfiguration)
    ps.map(getStamp(fs, _)).zip(ps).map {
      case (Success(s), p) => HdfsResourceSuccess(p, s)
      case (Failure(e), p) => HdfsResourceFailure(p, e.toString)
    }
  }

  private def getStamp(fs: FileSystem, p: HdfsPath): Try[HdfsStamp] = {
    Try {
      val p2 = new Path(p.s)
      val s = fs.getFileStatus(p2)
      HdfsStamp(s.getModificationTime.toString)
    }
  }
}
