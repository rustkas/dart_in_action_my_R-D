import 'dart:io';

import 'file_content_handler.dart';
import 'folder_list_handler.dart';
import 'static_file_handle.dart';

String _host = InternetAddress.loopbackIPv4.host;
int _port = 4040;

Future<void> listen() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(_host, _port);
    print('Listening $_host:$_port...');
    await for (var req in server) {
      print('handleGet(request);');
      handleRequest(req);
    }
    print('Listening on ${server.address.host}:${server.port}...');
  } catch (e) {
    print('Couldn\'t bind to port $_port: $e');
  }
}

/// Analyze request methods
void handleRequest(HttpRequest request) {
  try {
    if (request.method == 'GET') {
      handleGet(request);
      
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request: ${request.method}.')
        ..close();
    }
  } catch (e) {
    print('Exception in handleRequest: $e');
  }
  print('Request handled.');
}

void handleGet(HttpRequest request) {
  final path = request.requestedUri.path;
  if (path.startsWith('/static')) {
    staticFileHandle(request);
  } else if (path.startsWith('/folder')) {
    folderListHandler(request);
  } else if (path.startsWith('/file')) {
    fileContentHandler(request);
  }
}
