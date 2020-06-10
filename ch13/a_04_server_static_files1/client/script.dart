import 'dart:io';

import 'package:static_server/static_server.dart';

Future main() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(host, port);

    print('Listening on ${server.address.host}:${server.port}...');

    String path;
    ContentType contentType;
    await for (var req in server) {
      path = req.requestedUri.path;
      contentType = getConentType(path);
      if (!matchPath(path)) {
        print('reject $path');
        continue;
      }
      final reqFilePath = './client${req.requestedUri.path}';
      final file = File(reqFilePath);
      if (!await file.exists()) {
        print('File $path does not exist');
        continue;
      }
      var data;
      if (contentType == ContentType.binary) {
        data = await file.readAsBytes();
      } else {
        data = await file.readAsString();
      }

      req.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = contentType
        ..write(data);

      await req.response.close();
    }
  } catch (e) {
    print('Couldn\'t bind to port $port: $e');
  }
}

// dart bin/main.dart
// localhost:8080/index.html
// localhost:8080/script.dartimport 'dart:io';

import 'package:static_server/static_server.dart';

Future main() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(host, port);

    print('Listening on ${server.address.host}:${server.port}...');

    String path;
    ContentType contentType;
    await for (var req in server) {
      path = req.requestedUri.path;
      contentType = getConentType(path);
      if (!matchPath(path)) {
        print('reject $path');
        continue;
      }
      final reqFilePath = './client${req.requestedUri.path}';
      final file = File(reqFilePath);
      if (!await file.exists()) {
        print('File $path does not exist');
        continue;
      }
      var data;
      if (contentType == ContentType.binary) {
        data = await file.readAsBytes();
      } else {
        data = await file.readAsString();
      }

      req.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = contentType
        ..write(data);

      await req.response.close();
    }
  } catch (e) {
    print('Couldn\'t bind to port $port: $e');
  }
}

// dart bin/main.dart
// localhost:8080/index.html
// localhost:8080/index.html
// localhost:8080/favicon.ico
// localhost:8080/script.js
