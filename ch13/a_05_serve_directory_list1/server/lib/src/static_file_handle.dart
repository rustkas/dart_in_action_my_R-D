import 'dart:io';

Future<void> staticFileHandle(HttpRequest request) async {
  var fileName = request.requestedUri.path;
  print('GET: Static File: $fileName');
  if (!fileName.endsWith('.html')) {
    return;
  }
  final res = request.response;
  final file = File(fileName);
  if (await file.exists()) {
    res.headers.contentType = ContentType.html;
    try {
      await res.addStream(file.openRead());
      res.statusCode = HttpStatus.ok;
    } catch (e) {
      print('Couldn\'t read file: $e');
      exit(-1);
    }
  } else {
    print('Can\'t open ${file.path}');
    res.statusCode = HttpStatus.notFound;
  }
  await res.close();
}
