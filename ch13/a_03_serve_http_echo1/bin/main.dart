import 'dart:io';

Future<void> main(List<String> arguments) async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv6,
    8080,
  );
  await for (var request in server) {
    handleRequest(request);
  }
}

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
}

void handleGet(HttpRequest request) {
  final res = request.response;
  final path = request.requestedUri.path;
  final method = request.method;
  if (path.startsWith('/echo/')) {
    writeTo(res, 'Echo: $method $path');
  } else {
    writeTo(res, 'Hello World');
  }
}

void writeTo(HttpResponse res, String text) {
  res
    ..statusCode=HttpStatus.ok
    ..write(text)
    ..close();
}
///////////////////////////
// dart bin/main.dart
// localhost:8080/echo/foo
// localhost:8080/other
