# SynapseOS Test Plan & Operational Manual

This document outlines the testing strategy and verification steps for SynapseOS.

## 🧪 Testing Tiers

### 1. Unit Testing
- **Backend**: Run `sbt test` to execute ScalaTest suites for `AuthService` and `SyncEngine`.
- **Frontend**: Run `flutter test` to execute Bloc and widget tests.

### 2. Integration Testing
- **WebSocket Loopback**: 
  - Start the backend: `sbt run`
  - Use a WebSocket tool (e.g., Postman) to connect to `ws://localhost:8080/ws/{token}`.
  - Send a `SyncEvent` JSON and verify it is broadcasted to other connections.

### 3. Database & Persistence
- Start services: `docker-compose up -d postgres`
- Run backend: The Flyway migrations will automatically run on startup (ensure DB config is set in `application.conf`).

## 🛠 Manual Verification Walkthrough

### Scenario: User Registration & Login
1. Start the Backend server.
2. Send a POST request to `http://localhost:8080/auth/register` with:
   ```json
   { "username": "dev_user", "email": "dev@synapse.os", "password": "secure_password" }
   ```
3. Copy the returned `token`.
4. Use the token to log in at `http://localhost:8080/auth/login`.

### Scenario: Multi-user Whiteboard Sync
1. Launch two instances of the Flutter app (or use mock WebSocket clients).
2. Connect both to the same `workspaceId` via WebSockets using the `token`.
3. Perform a "draw" action in client A.
4. Verify client B receives a `whiteboard_draw` event with matching coordinates.

## 📋 Status Checklist
- [x] Backend Routes (Akka HTTP)
- [x] Real-time Sync (WebSockets)
- [x] Authentication (JWT/BCrypt)
- [x] Persistence Layer (Slick/Flyway)
- [x] Frontend UI (Flutter/Bloc)
- [x] DevOps (Docker/CI)
