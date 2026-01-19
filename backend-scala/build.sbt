name := "synapse-backend"

version := "0.1.0-SNAPSHOT"

scalaVersion := "2.13.12"

val akkaVersion = "2.8.5"
val akkaHttpVersion = "10.5.3"

libraryDependencies ++= Seq(
  "com.typesafe.akka" %% "akka-actor-typed" % akkaVersion,
  "com.typesafe.akka" %% "akka-stream" % akkaVersion,
  "com.typesafe.akka" %% "akka-http" % akkaHttpVersion,
  "com.typesafe.akka" %% "akka-http-spray-json" % akkaHttpVersion,
  "com.github.jwt-scala" %% "jwt-spray-json" % "9.4.4",
  "org.mindrot" % "jbcrypt" % "0.4",
  "org.postgresql" % "postgresql" % "42.7.1",
  "org.flywaydb" % "flyway-core" % "9.22.3",
  "com.typesafe.slick" %% "slick" % "3.4.1",
  "com.typesafe.slick" %% "slick-hikaricp" % "3.4.1",
  "ch.qos.logback" % "logback-classic" % "1.4.14",
  "org.scalatest" %% "scalatest" % "3.2.17" % Test
)
