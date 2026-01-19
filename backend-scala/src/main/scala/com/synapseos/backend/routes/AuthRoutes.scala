package com.synapseos.backend.routes

import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.model.StatusCodes
import com.synapseos.backend.models._
import com.synapseos.backend.models.UserJsonProtocol._
import com.synapseos.backend.services.AuthService
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport._

class AuthRoutes(authService: AuthService) {
  val routes =
    pathPrefix("auth") {
      concat(
        path("register") {
          post {
            entity(as[UserRegister]) { reg =>
              authService.register(reg) match {
                case Right(token) => complete(token)
                case Left(error) => complete(StatusCodes.BadRequest, error)
              }
            }
          }
        },
        path("login") {
          post {
            entity(as[UserLogin]) { login =>
              authService.login(login) match {
                case Right(token) => complete(token)
                case Left(error) => complete(StatusCodes.Unauthorized, error)
              }
            }
          }
        }
      )
    }
}
