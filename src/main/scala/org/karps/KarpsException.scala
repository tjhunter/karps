package org.karps

/**
 * An internal exception caused by a programming error inside Karps.
 * @param cause some useful message
 */
class KarpsException(cause: String) extends Exception(cause) {
}

object KarpsException {
  @throws[KarpsException]("always")
  def fail(msg: String, cause: Exception = null): Nothing = {
    throw new KarpsException(msg)
  }
}
