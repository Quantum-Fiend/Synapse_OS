import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:synapseos_flutter/core/network/api_endpoints.dart';

class SyncServiceClient {
  WebSocketChannel? _channel;
  final Function(Map<String, dynamic>) onEventReceived;

  SyncServiceClient({required this.onEventReceived});

  void connect(String userId) {
    final uri = Uri.parse('${ApiEndpoints.wsBase}/$userId');
    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen((message) {
      final data = jsonDecode(message);
      onEventReceived(data);
    }, onError: (error) {
      print('WebSocket Error: $error');
    }, onDone: () {
      print('WebSocket Closed');
    });
  }

  void sendEvent(String eventType, String workspaceId, String userId, Map<String, dynamic> payload) {
    if (_channel != null) {
      final event = {
        'eventType': eventType,
        'userId': userId,
        'workspaceId': workspaceId,
        'payload': jsonEncode(payload),
      };
      _channel!.sink.add(jsonEncode(event));
    }
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
