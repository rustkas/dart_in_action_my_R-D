import 'dart:io';

import 'package:handler/handler.dart';

Future<void> main(List<String> arguments) async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv6,
    8080,
  );
  
  print('Listening ${server.address}:${server.port}');
  await for (var request in server) {
    handleRequest(request);
  }
}

///////////////////////////
// dart bin/main.dart
// localhost:8080/echo/foo
// localhost:8080/other
