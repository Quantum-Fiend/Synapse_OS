package com.synapseos.backend.persistence

import slick.jdbc.PostgresProfile.api._
import com.synapseos.backend.models._
import scala.concurrent.Future

class UserDAO(db: Database) {
  private class UsersTable(tag: Tag) extends Table[User](tag, "users") {
    def id = column[String]("id", O.PrimaryKey)
    def username = column[String]("username", O.Unique)
    def email = column[String]("email", O.Unique)
    def passwordHash = column[String]("password_hash")
    def * = (id, username, passwordHash, email).mapTo[User]
  }

  private val users = TableQuery[UsersTable]

  def findById(id: String): Future[Option[User]] = db.run(users.filter(_.id === id).result.headOption)
  def findByUsername(username: String): Future[Option[User]] = db.run(users.filter(_.username === username).result.headOption)
  def create(user: User): Future[Int] = db.run(users += user)
}
