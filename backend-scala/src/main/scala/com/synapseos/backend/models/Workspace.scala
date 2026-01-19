package com.synapseos.backend.models

import spray.json.DefaultJsonProtocol

object WorkspaceRoles {
  val OWNER = "owner"
  val ADMIN = "admin"
  val MEMBER = "member"
  val VIEWER = "viewer"
}

case class Workspace(id: String, name: String, ownerId: String)
case class WorkspaceMember(workspaceId: String, userId: String, role: String)

object WorkspaceJsonProtocol extends DefaultJsonProtocol {
  implicit val workspaceFormat = jsonFormat3(Workspace)
  implicit val workspaceMemberFormat = jsonFormat3(WorkspaceMember)
}
