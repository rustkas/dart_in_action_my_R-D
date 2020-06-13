library static_server;

import 'dart:convert';
import 'dart:io';

const int port = 8088;

final connections = <int, WebSocket>{};

/// Utf8 encoder instance
const utf8 = Utf8Encoder();

/// Container of message for the clients
final data = {'action': 'CLIENT_COUNT_REFRESH', 'connectedClients': 0};

var server;

Future<void> webSocketServer() async {
  try {
    server = await HttpServer.bind('127.0.0.1', port);
    server.transform(WebSocketTransformer()).listen(onWebSocketData);
    print('listening...');
  } catch (e) {
    print('Couldn\'t bind to port $port: $e');
  }
}


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
  final key = client.hashCode;
  if (!connections.containsKey(key)) {
    connections[key] = client;
    // print('webSocker key = $key, mapSize = ${connections.length},keys = ${connections.keys}');
    sendUpdatedConnectionCount();
    client.listen((message) {
      if (message is String) {
        var data = jsonDecode(message);
        if (data is Map && data['action'] == 'SYNC') {
          for (var clientConnection in connections.values) {
            if (clientConnection.hashCode != client.hashCode) {
              // print('other webSocker key = ${clientConnection.hashCode}, mapSize = ${connections.length}, keys = ${connections.keys}');
              clientConnection.add(message);
            }
          } // for
        } // if
      } // if
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

