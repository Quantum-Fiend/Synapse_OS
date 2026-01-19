package com.synapseos.backend.sync

import akka.actor.typed.{ActorRef, ActorSystem}
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.model.ws.{Message, TextMessage}
import akka.http.scaladsl.server.Directives._
import akka.stream.OverflowStrategy
import akka.stream.scaladsl.{Flow, Sink, Source}
import com.synapseos.backend.models.SyncEvent
import com.synapseos.backend.models.SyncJsonProtocol._
import spray.json._
import scala.collection.mutable

object SyncEngine {
  sealed trait Command
  case class Connect(userId: String, replyTo: ActorRef[Message]) extends Command
  case class Disconnect(userId: String) extends Command
  case class Broadcast(event: SyncEvent) extends Command

  def apply(): Behaviors.Receive[Command] = {
    val subscribers = mutable.Map[String, ActorRef[Message]]()

    Behaviors.receiveMessage {
      case Connect(userId, replyTo) =>
        subscribers.put(userId, replyTo)
        Behaviors.same
      case Disconnect(userId) =>
        subscribers.remove(userId)
        Behaviors.same
      case Broadcast(event) =>
        val message = TextMessage(event.toJson.compactPrint)
        subscribers.values.foreach(_ ! message)
        Behaviors.same
    }
  }
}

class SyncHandler(authService: com.synapseos.backend.services.AuthService)(implicit system: ActorSystem[Nothing]) {
  private val syncActor = system.systemActorOf(SyncEngine(), "sync-engine")

  def flow(userId: String): Flow[Message, Message, Any] = {
    val (actorRef, source) = Source.actorRef[Message](
      completionMatcher = PartialFunction.empty,
      failureMatcher = PartialFunction.empty,
      bufferSize = 100,
      overflowStrategy = OverflowStrategy.dropTail
    ).preMaterialize()

    syncActor ! SyncEngine.Connect(userId, actorRef)

    val sink = Sink.foreach[Message] {
      case TextMessage.Strict(text) =>
        try {
          val event = text.parseJson.convertTo[com.synapseos.backend.models.SyncEvent]
          syncActor ! SyncEngine.Broadcast(event)
        } catch {
          case e: Exception => system.log.error(s"Failed to parse event: $text, error: ${e.getMessage}")
        }
      case _ => // Ignore binary messages for now
    }.mapMaterializedValue(_ => syncActor ! SyncEngine.Disconnect(userId))

    Flow.fromSinkAndSource(sink, source)
  }

  val route =
    path("ws" / Segment) { token =>
      authService.validateToken(token) match {
        case Some(userId) => handleWebSocketMessages(flow(userId))
        case None => complete(akka.http.scaladsl.model.StatusCodes.Unauthorized)
      }
    }
}
