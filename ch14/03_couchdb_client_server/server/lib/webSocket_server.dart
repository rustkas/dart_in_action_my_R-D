library static_server;

import 'dart:convert';
import 'dart:io';

import 'package:model/model.dart';

import 'couchdb.dart';

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
    server.transform(WebSocketTransformer()).listen(_onWebSocketData);
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
void _onWebSocketData(WebSocket client) async {
  final key = client.hashCode;

  if (!connections.containsKey(key)) {
    connections[key] = client;
    CouchDbHandler dbHandler;

    try {
      dbHandler =
          CouchDbHandler(host: 'localhost', port: 5984, dbName: 'expensedb');
      await dbHandler.isInit;
    } on Exception catch (e, s) {
      print('Exeption: $e');
      print('Stacktrace: $s');
    }

    sendUpdatedConnectionCount();
    client.listen((message) async {
      if (message is String) {
        var data = jsonDecode(message);
        if (data is Map) {
          switch (data['action']) {
            case 'SYNC':
              for (var clientConnection in connections.values) {
                if (clientConnection.hashCode != client.hashCode) {
                  clientConnection.add(message);
                }
              } // for

              //Update DB information
              Map expenseMap = data['expense'];
              if (expenseMap != null) {
  
                if (dbHandler != null) {
                  // print('WebSocket. Add or update Expense: $expenseMap');
                  var expenseInfo = await dbHandler.addOrUpdate(expenseMap);
                  // print('expense info: $expenseInfo');
                  var data = {};
                  data['action'] = 'SYNC';
                  data['expense'] = expenseInfo;
                  final jsonData = jsonEncode(data);

                  // send updated info to all websockets
                  for (var clientConnection in connections.values) {
                    clientConnection.add(jsonData);
                    
                  }
                }
              }
              break;
            case 'LOAD':
              _loadData(dbHandler, client);
              break;
            default:
              break;
          } // switch
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

void _loadData(CouchDbHandler dbHandler, WebSocket conn) {
  dbHandler.loadData().then((List<Map> expenses) {
    _sendDataToWebSocket(expenses, conn, 'LOAD');
  });
}

/// Send Expense to the client
void _sendDataToWebSocket(List<Map> expenses, WebSocket conn, String action) {
  var data = {};
  data['action'] = action;
  data['expenses'] = expenses;
  var nextId = Expense.currentHighestId;

  data['nextId'] = nextId;
  var jsonData = jsonEncode(data);
  conn.add(jsonData);
}
