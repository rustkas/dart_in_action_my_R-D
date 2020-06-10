import 'dart:convert';
import 'dart:io';

import 'util.dart';

Future<void> fileContentHandler(HttpRequest request) async {
  final res = request.response;
  addHeaders(res);

  final filePath = request.uri.path.substring('/file'.length);
  print('GET: file content: $filePath');

  final file = File(filePath);
  final result = <String, String>{};
  if (await file.exists()) {
    result['content'] = await file.readAsString();
  } else {
    result['content'] = '--';
  }
  res.write(jsonEncode(result));
  await res.close();
}
