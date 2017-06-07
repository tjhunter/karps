package org.karps.ops

import org.apache.hadoop.fs.{FileSystem, Path}
import org.apache.spark.sql.SparkSession

import scala.util.{Failure, Success, Try}

case class HdfsPath(s: String)

case class HdfsStamp(s: String)

case class HdfsResourceResult(
    stampReturnPath: String,
    stampReturnError: Option[String],
    stampReturn: Option[String])

object SourceStamps {

  def getStamps(sess: SparkSession, ps: Seq[HdfsPath]): Seq[HdfsResourceResult] = {
    val fs = FileSystem.get(sess.sparkContext.hadoopConfiguration)
    ps.map(getStamp(fs, _)).zip(ps).map {
      case (Success(s), p) => HdfsResourceResult(p.s, None, Option(s.s))
      case (Failure(e), p) =>
        HdfsResourceResult(p.s, Option(e.getMessage), None)
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
