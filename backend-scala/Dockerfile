# Stage 1: Build
FROM sbtsoft/sbt:1.9.7-jdk17 AS build
WORKDIR /app
COPY . .
RUN sbt compile

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target /app/target
# In a real setup, we'd use sbt-native-packager to create a lean executable
# For this flagship, we'll assume a standard jar execution or sbt run wrapper
EXPOSE 8080
ENTRYPOINT ["sbt", "run"]
