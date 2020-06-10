
import 'dart:convert';
import 'dart:io';

import 'util.dart';

Future<void> updateFileContent(HttpRequest request) async {
  final res = request.response;
  addHeaders(res);
  final filePath = request.uri.path.substring('/file'.length);

  final file = File(filePath);
  if (!await file.exists()) {
    print('File $file is not exist');
    return;
  }
  var dataBytes = <int>[];

  var fileContent = '';
  request.listen(
    (data) {
      dataBytes.addAll(data);
    },
    onDone: () {
      var content = utf8.decode(dataBytes, allowMalformed: false);
      try {
        fileContent = content.substring('fileContent='.length);
       file.writeAsString(fileContent);
      } catch (e) {
        print(e.toString());
      }
    },
  );

  res.write('ok');
  await res.close();
}
