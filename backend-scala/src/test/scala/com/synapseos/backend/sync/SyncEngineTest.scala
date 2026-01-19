package com.synapseos.backend.sync

import akka.actor.testkit.typed.scaladsl.ScalaTestWithActorTestKit
import akka.http.scaladsl.model.ws.TextMessage
import com.synapseos.backend.models.SyncEvent
import org.scalatest.wordspec.AnyWordSpecLike

class SyncEngineTest extends ScalaTestWithActorTestKit with AnyWordSpecLike {

  "SyncEngine" must {
    "broadcast events to all connected subscribers" in {
      val syncActor = spawn(SyncEngine())
      val probe1 = createTestProbe[akka.http.scaladsl.model.ws.Message]()
      val probe2 = createTestProbe[akka.http.scaladsl.model.ws.Message]()

      syncActor ! SyncEngine.Connect("user1", probe1.ref)
      syncActor ! SyncEngine.Connect("user2", probe2.ref)

      val event = SyncEvent("cursor_move", "user1", "workspace1", "{\"x\": 10, \"y\": 20}")
      syncActor ! SyncEngine.Broadcast(event)

      probe1.expectMessageType[TextMessage]
      probe2.expectMessageType[TextMessage]
    }
  }
}
