package com.synapseos.backend

import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import com.synapseos.backend.services.AuthService
import com.synapseos.backend.routes.AuthRoutes
import com.synapseos.backend.sync.SyncHandler
import scala.util.{Failure, Success}

object Main extends App {
  implicit val system = ActorSystem(Behaviors.empty, "synapse-backend")
  implicit val executionContext = system.executionContext

  // Configuration (In production, load these from application.conf)
  val jwtSecret = "your_production_ready_secret_key"
  val jwtExpiresIn = 24 * 3600L // 24 hours

  val authService = new AuthService(jwtSecret, jwtExpiresIn)
  val authRoutes = new AuthRoutes(authService)
  val syncHandler = new SyncHandler(authService)
  val monitoringRoute = com.synapseos.backend.observability.Monitoring.route

  // In production, initialize Database.forConfig("db") here
  // val db = Database.forConfig("db")
  // val userDAO = new com.synapseos.backend.persistence.UserDAO(db)

  val route =
    concat(
      monitoringRoute,
      authRoutes.routes,
      syncHandler.route
    )

  val bindingFuture = Http().newServerAt("0.0.0.0", 8080).bind(route)

  bindingFuture.onComplete {
    case Success(binding) =>
      val address = binding.localAddress
      system.log.info(s"Server online at http://${address.getHostString}:${address.getPort}/")
    case Failure(ex) =>
      system.log.error("Failed to bind HTTP endpoint, terminating system", ex)
      system.terminate()
  }
}
