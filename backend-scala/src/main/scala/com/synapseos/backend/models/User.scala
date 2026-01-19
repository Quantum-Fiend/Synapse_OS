package com.synapseos.backend.models

import spray.json.DefaultJsonProtocol

case class User(id: String, username: String, passwordHash: String, email: String)
case class UserLogin(username: String, password: String)
case class UserRegister(username: String, email: String, password: String)
case class AuthToken(token: String, expiresIn: Long)

object UserJsonProtocol extends DefaultJsonProtocol {
  implicit val userFormat = jsonFormat4(User)
  implicit val userLoginFormat = jsonFormat2(UserLogin)
  implicit val userRegisterFormat = jsonFormat3(UserRegister)
  implicit val authTokenFormat = jsonFormat2(AuthToken)
}
