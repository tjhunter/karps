package org.karps.structures

import scala.util.{Failure, Success, Try}

import com.trueaccord.scalapb.{GeneratedMessage, Message, GeneratedMessageCompanion}
import com.trueaccord.scalapb.json._

import org.karps.OpExtra

object ProtoUtils {
  def checkField[X](x: X, fieldName: String): Try[X] = {
    if (x == null) {
      missingField(fieldName)
    } else {
      Success(x)
    }
  }
  
  def checkField[X](x: Option[X], fieldName: String): Try[X] = {
    if (x == None) {
      missingField(fieldName)
    } else {
      Success(x.get)
    }
  }

  def missingField[X](fieldName: String): Try[X] = {
    Failure(new Exception(s"Missing field $fieldName"))
  }
  
  def unrecognized[X](fieldName: String, x: Int): Try[X] = {
    Failure(new Exception(s"unrecognized value for $fieldName: $x"))
  }
  
  def sequence[T](xs : Seq[Try[T]]) : Try[Seq[T]] = (Try(Seq[T]()) /: xs) {
    (a, b) => a flatMap (c => b map (d => c :+ d))
  }
  
  def fromExtra[A <: GeneratedMessage with Message[A]](extra: OpExtra)(
implicit cmp: GeneratedMessageCompanion[A]): Try[A] = {
    Try(JsonFormat.fromJsonString[A](extra.content))
  }
}
