# ADR-001: Real-Time Synchronization Protocol

## Status
Accepted

## Context
SynapseOS requires low-latency, bidirectional communication for features like live cursor tracking and multi-user whiteboard drawing.

## Decision
We chose **WebSockets** as the primary synchronization protocol.

## Rationale
- **Low Latency**: Once established, WebSockets have minimal per-message overhead compared to HTTP polling.
- **Bidirectional**: Allows the server to push updates instantly without client requests.
- **Resource Efficiency**: Reduces the number of HTTP headers sent per update.

## Consequences
- Requires persistent connections on the server (handled by Akka Actors).
- Needs robust connection management and graceful handling of disconnects.
- Token validation must be handled during the initial handshake or first message.
