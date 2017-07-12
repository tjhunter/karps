package org.karps

import scala.concurrent.duration._

import akka.actor.{Actor, ActorSystem, Props}
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import com.trueaccord.scalapb.json.JsonFormat
import spray.can.Http
import spray.http.MediaTypes._
import spray.httpx.SprayJsonSupport
import spray.json.DefaultJsonProtocol
import spray.routing._

import org.karps.structures._
import org.karps.ops.{HdfsPath, HdfsResourceResult}
import karps.core.{interface => I}

object Boot extends App {

  val karpsPort = 8081
  val interface = "localhost"

  SparkRegistry.setup()

  // we need an ActorSystem to host our application in
  implicit val system = ActorSystem("karps-on-spray-can")

  // create and start our service actor
  val service = system.actorOf(Props[MyServiceActor], "demo-service")

  implicit val timeout = Timeout(5.seconds)
  // start a new HTTP server on port 8080 with our service actor as the handler
  IO(Http) ? Http.Bind(service, interface = interface, port = karpsPort)
}

// we don't implement our route structure directly in the service actor because
// we want to be able to test it independently, without having to spin up an actor
class MyServiceActor extends Actor with MyService {

  // TODO: move outside an actor.
  val manager = {
    val m = new Manager()
    m.init()
    m
  }

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  def receive = runRoute(myRoute)
}


case class Person(name: String, favoriteNumber: Int)


// this trait defines our service behavior independently from the service actor
trait MyService extends HttpService with Logging {

  val manager: Manager

  val myRoute =
    path("") {
      get {
        respondWithMediaType(`text/html`) { // XML is marshalled to `text/xml` by default, so we simply override here
          complete {
            <html>
              <body>
                <h1>Say hello to <i>spray-routing</i> on <i>spray-can</i>!</h1>
              </body>
            </html>
          }
        }
      }
    } ~
    path("sessions" / Segment / "create") { sessionIdTxt =>
      val sessionId = SessionId(sessionIdTxt)
      post {
        manager.create(sessionId)
        complete("xxx")
      }
    } ~
    path("resources_status" / Segment ) { sessionIdTxt =>
      val sessionId = SessionId(sessionIdTxt)

      post {
        entity(as[String]) { req =>
          val proto = ProtoUtils.fromString[I.ResourceStatusRequest](req).get
          logger.debug(s"Requesting status for paths $proto")
          val ps = proto.resources.map(_.uri).map(HdfsPath.apply)
          val sessionId = SessionId.fromProto(proto.session.get).get
          
          val s = manager.resourceStatus(sessionId, ps)
          s.foreach(st => logger.debug(s"Status received: $st"))
          val res = I.ResourceStatusResponse(hdfs=s.map(HdfsResourceResult.toProto))
          val json = JsonFormat.toJsonString(res)
          complete(json)
        }
      }
    } ~
    path("computations" / Segment / Segment / "create") { (sessionIdTxt, computationIdTxt) =>
      val sessionId = SessionId(sessionIdTxt)
      val computationId = ComputationId(computationIdTxt)

      post {
        entity(as[String]) { jsonIn =>
          val protoIn = ProtoUtils.fromString[I.CreateComputationRequest](jsonIn).get
          val sessionId = SessionId.fromProto(protoIn.session.get).get
          val computationId =
            ComputationId.fromProto(protoIn.requestedComputation.get)
          val nodes =
            protoIn.graph.get.nodes
              .map(UntypedNode.fromProto).map(_.get)
          
          manager.execute(sessionId, computationId, nodes)
          val protoOut = I.CreateComputationResponse()
          val jsonOut = JsonFormat.toJsonString(protoOut)
          complete(jsonOut)
        }
      }
    } ~
    path("computations_status" / Segment / Segment / Rest ) {
        (sessionIdTxt, computationIdTxt, rest) =>
      val sessionId = SessionId(sessionIdTxt)
      val computationId = ComputationId(computationIdTxt)
      if (rest.isEmpty) {
        // We are being asked for the computation
        get {
          complete {
            val s = manager.statusComputation(sessionId, computationId).getOrElse(
              throw new Exception(s"$sessionId $computationId"))
            val proto = BatchComputationResult.toProto(s)
            JsonFormat.toJsonString(proto)
          }
        }
      } else {
        // Asking for a given element.
        val p = Path.create(rest.split("/"))
        val gp = GlobalPath.from(sessionId, computationId, p)

        get {
          complete {
            val s = manager.status(gp).getOrElse(throw new Exception(gp.toString))
            val proto = ComputationResult.toProto(s, gp, Nil)
            JsonFormat.toJsonString(proto)
          }
        }
      }
    }
}
