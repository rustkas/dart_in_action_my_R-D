import 'dart:io';

import 'file_content_handler.dart';
import 'folder_list_handler.dart';
import 'static_file_handle.dart';
import 'update_file.dart';

String _host = InternetAddress.loopbackIPv4.host;
int _port = 4040;

Future<void> listen() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(_host, _port);
    print('Listening $_host:$_port...');
    await for (var req in server) {
      _handleRequest(req);
    }
    print('Listening on ${server.address.host}:${server.port}...');
  } catch (e) {
    print('Couldn\'t bind to port $_port: $e');
  }
}

/// Analyze request methods
void _handleRequest(HttpRequest request) {
  try {
    switch (request.method) {
      case 'GET':
        _handleGet(request);
        break;
      case 'POST':
        _handlePost(request);
        break;
      default:
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

void _handleGet(HttpRequest request) {
  final path = request.requestedUri.path;
  if (path.startsWith('/static')) {
    staticFileHandle(request);
  } else if (path.startsWith('/folder')) {
    folderListHandler(request);
  } else if (path.startsWith('/file')) {
    fileContentHandler(request);
  }
}

void _handlePost(HttpRequest request) {
  updateFileContent(request);
}
