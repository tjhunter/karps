package org.karps

import java.net.InetSocketAddress
import java.util.concurrent.Executors

import scala.concurrent.duration._
import scala.concurrent.{Await, ExecutionContext, Future}

import akka.actor.{Actor, ActorSystem, Props}
import akka.io.IO
import akka.pattern.ask
import akka.util.Timeout
import com.typesafe.scalalogging.slf4j.{StrictLogging => Logging}
import io.grpc.netty.NettyServerBuilder
import io.grpc.{Server, ServerBuilder}
import spray.can.Http
import spray.routing._

import org.karps.brain.HaskellBrain
import org.karps.grpc.{GrpcInternalManager, GrpcManager}
import org.karps.structures._

import karps.core.api_internal.KarpsRestGrpc.KarpsRest
import karps.core.interface.KarpsMainGrpc
import karps.core.interface.KarpsMainGrpc.KarpsMain
import karps.core.{api_internal => AI, interface => I}

import spark.core.JavaExports


object Boot extends App {

  val karpsPort = 8081
  val interface = "localhost"
  val karpsGrpcPort = 8082
  val grpcInterface = Option("localhost")

  val main = new EntryPoint(
    karpsPort = 8081,
    interface = "localhost",
    karpsGrpcPort = 8082,
    grpcInterface = Some("localhost")
  )

  main.startBlock()

}

/**
 * The main entry point for running karps.
 *
 * This file provides 2 interfaces:
 *  - a GRPC interface for most GRPC communication
 *  - a small, trimmed dowon interface that is used by the Haskell client,
 *    and that will be deprecated soon.
 *
 * The implemented interface is described in 'interface.proto'
 *
 * @param karpsPort the port for the REST interface
 * @param interface the binding address for the REST interface
 * @param karpsGrpcPort the port for the GRPC interface
 * @param grpcInterface the binding address for the GRPC interface
 */
class EntryPoint(
    val karpsPort: Int,
    val interface: String,
    val karpsGrpcPort: Int,
    val grpcInterface: Option[String]) extends Logging {

  // Threading and scheduling
  implicit val timeout = Timeout(5.seconds)
  val executorService = Executors.newFixedThreadPool(10)
  implicit val executionContext = ExecutionContext.fromExecutorService(executorService)
  // Actor system
  // we need an ActorSystem to host our application in
  implicit val system = ActorSystem("karps-on-spray-can")
  // create and start our service actor
  val p = Props(classOf[KarpsRestActor], manager, grpcManager, grpcInternalManager)
  val service = system.actorOf(p, "demo-service")

  // Karps services
  lazy val manager = {
    val m = new Manager()
    m.init()
    m
  }

  lazy val brain = HaskellBrain.launch()

  lazy val grpcManager = new GrpcManager(Some(manager), Some(brain))

  // This one does not need to be started, just to exist.
  // The GRPC part is not used.
  lazy val grpcInternalManager = new GrpcInternalManager(Some(manager))

  lazy val grpcService = new KarpsGrpcServer(executionContext, grpcManager, karpsGrpcPort,
    grpcInterface)

  def startBlock(): Unit = {
    // Install the registry.
    SparkRegistry.setup()

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


}

// we don't implement our route structure directly in the service actor because
// we want to be able to test it independently, without having to spin up an actor
class KarpsRestActor(
    override val manager: Manager,
    override val grpcMain: KarpsMain,
    override val grpcInternal: KarpsRest) extends Actor with KarpsRestService {

  // the HttpService trait defines only one abstract member, which
  // connects the services environment to the enclosing actor or test
  override def actorRefFactory = context

  // this actor only runs our route, but you could add
  // other things here, like request stream processing
  // or timeout handling
  override def receive = runRoute(myRoute)
}


class KarpsGrpcServer(
    executionContext: ExecutionContext,
    manager: GrpcManager,
    karpsGrpcPort: Int,
    address: Option[String]) extends Logging {
  private var server: Server = null

  def start(): Unit = {
    val ser = address match {
      case Some(x) =>
        NettyServerBuilder.forAddress(new InetSocketAddress(x, karpsGrpcPort))
      case None => ServerBuilder.forPort(karpsGrpcPort)
    }
    server = ser
        .addService(KarpsMainGrpc.bindService(manager, executionContext))
        .build.start()
    logger.info(s"GRPC server $server started, listening on port ${karpsGrpcPort}")
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
    path("rest_proto" / "ResourceStatus") {
      post {
        entity(as[Array[Byte]]) { req =>
          val proto = ProtoUtils.fromBytes[AI.AnalyzeResourcesRequest](req).get
          logger.debug(s"Requesting ComputationStatus: $proto")
          val proto2 = Await.result(grpcInternal.resourceStatus(proto), 10.hours)
          complete(ProtoUtils.toBytes(proto2))
        }
      }
    }
}
