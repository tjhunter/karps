package org.karps.ops

import scala.util.{Failure, Success, Try}

import org.apache.hadoop.fs.{FileSystem, Path}
import org.apache.spark.sql.SparkSession

import karps.core.{interface => I}
import karps.core.{computation => C}

case class HdfsPath(s: String)

case class HdfsStamp(s: String)

case class HdfsResourceResult(
    stampReturnPath: HdfsPath,
    stampReturnError: Option[String],
    stampReturn: Option[HdfsStamp])

object HdfsResourceResult {
  def toProto(r: HdfsResourceResult): I.HdfsResourceStatus = {
    var x = I.HdfsResourceStatus(
      path = Some(C.ResourcePath(r.stampReturnPath.s)))
    for (txt <- r.stampReturnError) {
      x = x.withError(txt)
    }
    for (s <- r.stampReturn) {
      x = x.withReturn(s.s)
    }
    x
  }
}    
    
object SourceStamps {

  def getStamps(sess: SparkSession, ps: Seq[HdfsPath]): Seq[HdfsResourceResult] = {
    val fs = FileSystem.get(sess.sparkContext.hadoopConfiguration)
    ps.map(getStamp(fs, _)).zip(ps).map {
      case (Success(s), p) => HdfsResourceResult(p, None, Option(s))
      case (Failure(e), p) =>
        HdfsResourceResult(p, Option(e.getMessage), None)
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
