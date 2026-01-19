package com.synapseos.backend.services

import com.synapseos.backend.models._
import org.mindrot.jbcrypt.BCrypt
import pdi.jwt.{JwtAlgorithm, JwtClaim, JwtSprayJson}
import spray.json._
import java.time.Clock
import java.util.UUID
import scala.collection.mutable

class AuthService(secretKey: String, expiresIn: Long) {
  private val users = mutable.Map[String, User]() // In-memory storage for prototype
  private implicit val clock: Clock = Clock.systemUTC

  def register(reg: UserRegister): Either[String, AuthToken] = {
    if (users.values.exists(_.username == reg.username)) {
      Left("Username already exists")
    } else {
      val id = UUID.randomUUID().toString
      val passwordHash = BCrypt.hashpw(reg.password, BCrypt.gensalt())
      val newUser = User(id, reg.username, passwordHash, reg.email)
      users.put(id, newUser)
      Right(generateToken(newUser))
    }
  }

  def login(login: UserLogin): Either[String, AuthToken] = {
    users.values.find(_.username == login.username) match {
      case Some(user) if BCrypt.checkpw(login.password, user.passwordHash) =>
        Right(generateToken(user))
      case _ =>
        Left("Invalid username or password")
    }
  }

  def generateToken(user: User): AuthToken = {
    val claim = JwtClaim(
      content = JsObject("userId" -> JsString(user.id), "username" -> JsString(user.username)).compactPrint,
      expiration = Some(System.currentTimeMillis() / 1000 + expiresIn)
    )
    val token = JwtSprayJson.encode(claim, secretKey, JwtAlgorithm.HS256)
    AuthToken(token, expiresIn)
  }

  def validateToken(token: String): Option[String] = {
    JwtSprayJson.decode(token, secretKey, Seq(JwtAlgorithm.HS256)).toOption.map { claim =>
      claim.content.parseJson.asJsObject.getFields("userId") match {
        case Seq(JsString(userId)) => userId
        case _ => ""
      }
    }
  }
}
