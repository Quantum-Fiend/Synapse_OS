package com.synapseos.backend.models

import spray.json.DefaultJsonProtocol

case class SyncEvent(
  eventType: String, // "cursor_move", "doc_update", "whiteboard_draw", "presence"
  userId: String,
  workspaceId: String,
  payload: String // JSON string of specific event data
)

case class PresenceEvent(
  userId: String,
  username: String,
  status: String // "online", "away", "offline"
)

object SyncJsonProtocol extends DefaultJsonProtocol {
  implicit val syncEventFormat = jsonFormat4(SyncEvent)
  implicit val presenceEventFormat = jsonFormat3(PresenceEvent)
}
