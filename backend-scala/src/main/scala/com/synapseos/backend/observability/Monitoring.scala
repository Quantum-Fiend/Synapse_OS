package com.synapseos.backend.observability

import akka.http.scaladsl.server.Directives._
import akka.http.scaladsl.model.{StatusCodes, HttpEntity, ContentTypes}
import org.slf4j.LoggerFactory

object Monitoring {
  private val logger = LoggerFactory.getLogger(getClass)

  val route =
    path("health") {
      get {
        logger.info("Health check requested")
        complete(StatusCodes.OK, HttpEntity(ContentTypes.`application/json`, "{\"status\": \"UP\"}"))
      }
    } ~
    path("metrics") {
      get {
        // Return dummy metrics for demonstration
        complete(StatusCodes.OK, "synapse_active_connections 42\nsynapse_events_processed 1000")
      }
    }
}
