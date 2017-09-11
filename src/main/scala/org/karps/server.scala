package org.karps

import java.util.concurrent.Executors

import scala.concurrent.duration._
import scala.concurrent.{Await, ExecutionContext, Future}

import akka.actor.{Actor, ActorSystem, Props}
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import spray.can.Http
import spray.http.MediaTypes._
import spray.routing._
import io.grpc.{Server, ServerBuilder}

import org.karps.brain.HaskellBrain
import org.karps.grpc.{GrpcManager, GrpcInternalManager}
import org.karps.structures._
import org.karps.ops.{HdfsPath, HdfsResourceResult}

import karps.core.{interface => I}
import karps.core.{computation => C}
import karps.core.interface.KarpsMainGrpc
import karps.core.interface.KarpsMainGrpc.KarpsMain
import karps.core.api_internal.KarpsRestGrpc.KarpsRest


object Boot extends App {

  val karpsPort = 8081
  val interface = "localhost"
  val karpsGrpcPort = 8082

  SparkRegistry.setup()

  // we need an ActorSystem to host our application in
  implicit val system = ActorSystem("karps-on-spray-can")

  lazy val manager = {
    val m = new Manager()
    m.init()
    m
  }

  val executorService = Executors.newFixedThreadPool(10)
  implicit val executionContext = ExecutionContext.fromExecutorService(executorService)

  lazy val brain = HaskellBrain.launch()

  lazy val grpcManager = new GrpcManager(Some(manager), Some(brain))

  // This one does not need to be started, just to exist.
  // The GRPC part is not used.
  lazy val grpcInternalManager = new GrpcInternalManager(Some(manager))

  // create and start our service actor
  val service = system.actorOf(Props[KarpsRestActor], "demo-service")

  lazy val grpcService = new KarpsGrpcServer(executionContext, grpcManager)

  implicit val timeout = Timeout(5.seconds)
  // start a new HTTP server on port 8080 with our service actor as the handler
  val rest = Future {
    IO(Http) ? Http.Bind(service, interface = interface, port = karpsPort)
  }

  val grpc = Future {
    grpcService.start()
    grpcService.blockUntilShutdown()
  }

  Await.result(for {
    _ <- rest
    _ <- grpc
  } yield  {}, 100000.hours)
}

// we don't implement our route structure directly in the service actor because
// we want to be able to test it independently, without having to spin up an actor
class KarpsRestActor extends Actor with KarpsRestService {

  // TODO: move outside an actor.
  override val manager = Boot.manager

  override val grpcMain = Boot.grpcManager

  override val grpcInternal = Boot.grpcInternalManager

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  override def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  override def receive = runRoute(myRoute)
}


class KarpsGrpcServer(executionContext: ExecutionContext, manager: GrpcManager) extends Logging {
  private var server: Server = null

  def start(): Unit = {
    server = ServerBuilder.forPort(Boot.karpsGrpcPort)
      .addService(KarpsMainGrpc.bindService(manager, executionContext))
        .build.start()
    logger.info(s"GRPC server started, listening on port ${Boot.karpsGrpcPort}")
    sys.addShutdownHook {
      logger.info(s"Exit hook called: Stopping GRPC server")
      stop()
      logger.info(s"Exit hook called: GRPC server has been stopped")
    }
  }

  private def stop(): Unit = {
    if (server != null) {
      server.shutdown()
    }
  }

  def blockUntilShutdown(): Unit = {
    if (server != null) {
      server.awaitTermination()
    }
  }
}

// The route implemented here correspond to the subset of REST routes.
// They expect and return bytestrings with raw protobufs.
trait KarpsRestService extends HttpService with Logging {

  val manager: Manager

  val grpcMain: KarpsMain

  val grpcInternal: KarpsRest

  val myRoute =
    path("rest_proto" / "CreateComputation") {
      post {
        entity(as[Array[Byte]]) { req =>
          val proto = ProtoUtils.fromBytes[I.CreateComputationRequest](req).get
          logger.debug(s"Requesting CreateComputation: $proto")
          val proto2 = Await.result(grpcInternal.createComputation(proto), 10.hours)
          complete(ProtoUtils.toBytes(proto2))
        }
      }
    } ~
    path("rest_proto" / "CreateSession") {
      post {
        entity(as[Array[Byte]]) { req =>
          val proto = ProtoUtils.fromBytes[I.CreateSessionRequest](req).get
          logger.debug(s"Requesting CreateSession: $proto")
          val proto2 = Await.result(grpcMain.createSession(proto), 10.hours)
          complete(ProtoUtils.toBytes(proto2))
        }
      }
    } ~
      path("rest_proto" / "ComputationStatus") {
        post {
          entity(as[Array[Byte]]) { req =>
            val proto = ProtoUtils.fromBytes[I.ComputationStatusRequest](req).get
            logger.debug(s"Requesting ComputationStatus: $proto")
            val proto2 = Await.result(grpcInternal.computationStatus(proto), 10.hours)
            complete(ProtoUtils.toBytes(proto2))
          }
        }
      } ~
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
    }
//    path("sessions" / Segment / "create") { sessionIdTxt =>
//      val sessionId = SessionId(sessionIdTxt)
//      post {
//        manager.create(sessionId)
//        complete("xxx")
//      }
//    } ~
//    path("resources_status" / Segment ) { sessionIdTxt =>
//      val sessionId = SessionId(sessionIdTxt)
//
//      post {
//        entity(as[String]) { req =>
//          val proto = ProtoUtils.fromString[I.ResourceStatusRequest](req).get
//          logger.debug(s"Requesting status for paths $proto")
//          val ps = proto.resources.map(_.uri).map(HdfsPath.apply)
//          val sessionId = SessionId.fromProto(proto.session.get).get
//
//          val s = manager.resourceStatus(sessionId, ps)
//          s.foreach(st => logger.debug(s"Status received: $st"))
//          val res = I.ResourceStatusResponse(hdfs=s.map(HdfsResourceResult.toProto))
//          val json = ProtoUtils.toJsonString(res)
//          complete(json)
//        }
//      }
//    } ~
//    path("computations" / Segment / Segment / "create") { (sessionIdTxt, computationIdTxt) =>
//      val sessionId = SessionId(sessionIdTxt)
//      val computationId = ComputationId(computationIdTxt)
//
//      post {
//        entity(as[String]) { jsonIn =>
//          logger.info(s"JSON request from http: $jsonIn")
//          val protoIn = ProtoUtils.fromString[I.CreateComputationRequest](jsonIn).get
//          logger.info(s"Proto request from http: $protoIn")
//          val sessionId = SessionId.fromProto(protoIn.session.get).get
//          val computationId =
//            ComputationId.fromProto(protoIn.requestedComputation.get)
//          val nodes =
//            protoIn.graph.get.nodes
//              .map(UntypedNode.fromProto).map(_.get)
//
//          manager.execute(sessionId, computationId, nodes, None)
//          val protoOut = I.CreateComputationResponse()
//          val jsonOut = ProtoUtils.toJsonString(protoOut)
//          complete(jsonOut)
//        }
//      }
//    } ~
//    path("computations_status" / Segment / Segment / Rest ) {
//        (sessionIdTxt, computationIdTxt, rest) =>
//      val sessionId = SessionId(sessionIdTxt)
//      val computationId = ComputationId(computationIdTxt)
//      if (rest.isEmpty) {
//        // We are being asked for the computation
//        get {
//          respondWithMediaType(`application/json`) {
//            complete {
//              val s = manager.statusComputation(sessionId, computationId).getOrElse(
//                throw new Exception(s"$sessionId $computationId"))
//              val proto = BatchComputationResult.toProto(s)
//              val js = ProtoUtils.toJsonString(proto)
//              logger.info(s"status request: session=$sessionId comp=$computationId s=$s " +
//                s"proto=$proto js=$js")
//              js
//            }
//          }
//        }
//      } else {
//        // Asking for a given element.
//        val p = Path.create(rest.split("/"))
//        val gp = GlobalPath.from(sessionId, computationId, p)
//
//        get {
//          respondWithMediaType(`application/json`) {
//            complete {
//              val s = manager.status(gp).getOrElse(throw new Exception(gp.toString))
//              val proto = ComputationResult.toProto(s, gp, Nil)
//              val js = ProtoUtils.toJsonString(proto)
//              logger.info(s"status request: session=$sessionId comp=$computationId s=$s " +
//                s"proto=$proto js=$js")
//              js
//            }
//          }
//        }
//      }
//    }
}
