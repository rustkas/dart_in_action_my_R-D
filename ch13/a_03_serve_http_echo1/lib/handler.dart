library handler;

import 'dart:io';

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
