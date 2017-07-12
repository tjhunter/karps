package org.karps.structures

import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
// import spray.json.DefaultJsonProtocol._
import org.apache.spark.rdd.RDD

import karps.core.{graph => G}
import karps.core.{computation => C}


case class RDDId private (repr: Int) extends AnyVal

object RDDId {
  def fromRDD(rdd: RDD[_]): RDDId = new RDDId(rdd.id)

  implicit object MyOrdering extends Ordering[RDDId] {
    override def compare(x: RDDId, y: RDDId): Int = x.repr.compare(y.repr)
  }
}

/**
 * Some basic information about RDDs that is exposed and sent to clients.
 */
case class RDDInfo private (
  id: RDDId,
  className: String,
  repr: String, // A human-readable representation of the RDD
  parents: Seq[RDDId])

object RDDInfo {
  def fromRDD(rdd: RDD[_]): RDDInfo = {
    val parents = rdd.dependencies.map(_.rdd).map(RDDId.fromRDD)
    new RDDInfo(
      RDDId.fromRDD(rdd),
      rdd.getClass.getSimpleName,
      rdd.toString(),
      parents)
  }
}
