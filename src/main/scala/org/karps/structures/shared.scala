package org.karps.structures

import scala.util.{Failure, Success, Try}

import karps.core.{graph => G}
import karps.core.{computation => C}


/**
 * The identifier of a spark session.
 *
 * @param id
 */
case class SessionId(id: String) extends AnyVal

object SessionId {
  def fromProto(p: C.SessionId): Try[SessionId] = {
    if (p.id == null) {
      Failure(new Exception("Empty session id"))
    } else { Success(SessionId(p.id)) }
  }

  def toProto(s: SessionId): C.SessionId = C.SessionId(s.id)
}

/**
 * The local path in a computation. Does not include the session or the computation.
 */
case class Path private (repr: Seq[String]) extends AnyVal {

  override def toString: String = repr.mkString("/")
}

object Path {
  def create(repr: Seq[String]): Path = {
    require(repr.size >= 1, repr)
    Path(repr)
  }
  
  def fromProto(p: G.Path): Path = {
    Path.create(p.path)
  }
  
  def toProto(p: Path): G.Path = G.Path(path=p.repr)
}

/**
 * The ID of a computation.
 * @param repr
 */
case class ComputationId(repr: String) extends AnyVal {
  def ranBefore(other: ComputationId): Boolean = repr < other.repr
}

object ComputationId {
  val UnknownComputation = ComputationId("-1")
  
  def fromProto(p: C.ComputationId): ComputationId = {
    ComputationId(p.id)
  }

  def toProto(c: ComputationId): C.ComputationId = {
    C.ComputationId(c.repr)
  }
}

case class GlobalPath private (
    session: SessionId,
    computation: ComputationId,
    local: Path) {
  override def toString: String = {
    val p = local.repr.mkString("/")
    s"//${session.id}/${computation.repr}/$p"
  }
}

object GlobalPath {
  def from(session: SessionId, cid: ComputationId, local: Path): GlobalPath = {
    // Do an extra check on the path to remove a spurious CID.
    if (local.repr.head == cid.repr) {
      require(local.repr.length >= 2, local)
      GlobalPath(session, cid, Path(local.repr.tail))
    }
    else GlobalPath(session, cid, Path(local.repr))
  }
}


sealed trait Locality
case object Distributed extends Locality
case object Local extends Locality

object Locality {
  def fromProto(l: G.Locality): Try[Locality] = l match {
    case G.Locality.LOCAL => Success(Local)
    case G.Locality.DISTRIBUTED => Success(Distributed)
    case G.Locality.Unrecognized(x) => Failure(new Exception(s"Unknown locality: $x"))
  }
}
