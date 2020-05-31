import 'dart:io';

String _host = InternetAddress.loopbackIPv6.host;
int _port = 8080;
Future main() async {
  HttpServer server;
  try {
    server = await HttpServer.bind(_host, _port);

    print('Listening on ${server.address.host}:${server.port}...');

    String path;
    ContentType contentType;
    await for (var req in server) {
      path = req.requestedUri.path;
      contentType = getConentType(path);
      if (!matchPath(path)) {
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
    print('Couldn\'t bind to port $_port: $e');
  }
}

bool matchPath(String path) {
  path = path.toLowerCase();
  return path.endsWith('.html') ||
      path.endsWith('.dart') ||
      path.endsWith('.css') ||
      path.endsWith('.js') ||
      path.endsWith('.ico') ||
      path.endsWith('.png') ||
      path.endsWith('.jpg') ||
      path.endsWith('.json');
}

ContentType getConentType(String path) {
  path = path.toLowerCase();
  if (path.endsWith('.html')) {
    return ContentType.html;
  } else if (path.endsWith('.json')) {
    return ContentType.json;
  } else if (path.endsWith('.ico') ||
      path.endsWith('.png') ||
      path.endsWith('.jpg')) {
    return ContentType.binary;
  }
  return ContentType.text;
}
// dart bin/main.dart
// localhost:8080/index.html
