import 'dart:convert';
import 'dart:io';

import 'package:server/static_server.dart';

Future main() async {
  final connections = <int, WebSocket>{};

  /// Utf8 encoder instance
  const utf8 = Utf8Encoder();

  /// Container of message for the clients
  final data = {'action': 'CLIENT_COUNT_REFRESH', 'connectedClients': 0};

  /// Client messages sending
  void sendUpdatedConnectionCount() {
    data['connectedClients'] = connections.length;
    final message = jsonEncode(data);

    for (var clientConnection in connections.values) {
      clientConnection.addUtf8Text(utf8.convert(message));
    }
  }

  /// WebSocker listener
  void onWebSocketData(WebSocket client) async {
    var key = client.hashCode;
    if (!connections.containsKey(key)) {
      connections[key] = client;
      sendUpdatedConnectionCount();
      client.listen((data) {
        client.add('Echo: $data');
      }, onError: (o, e) {
        print(o);
        print('---------------');
        print(e);
      }, onDone: () {
        // connection is closed
        connections.remove(key);
        sendUpdatedConnectionCount();
      });
    }
  }

  var server;
  try {
    server = await HttpServer.bind('127.0.0.1', 8088);
    server.transform(WebSocketTransformer()).listen(onWebSocketData);
    print('listening...');
  } catch (e) {
    print('Couldn\'t bind to port $port: $e');
  }
}

// dart bin/main.dart
// localhost:8080
