import 'dart:convert';
import 'dart:io';

import 'util.dart';

void folderListHandler(HttpRequest request) {
  final res = request.response;
  addHeaders(res);
  final folderPath = request.uri.path.substring('/folder'.length);
  print('GET: folder: $folderPath');
  final list = Directory(folderPath).list();

  final dirList = <String>[];
  final fileList = <String>[];
  list.listen(
    (FileSystemEntity entity) {
      if (entity is File && entity.path.endsWith('.dart')) {
        // only show Dart files
        fileList.add(_getPath(entity.path));
      } else if (entity is Directory) {
        dirList.add(_getPath(entity.path));
      }
    },
    onDone: () {
      final result = <String, List>{};
      result['files'] = fileList;
      result['dirs'] = dirList;
      print('on done');
      res.write(jsonEncode(result));
      res.close();
    },
  );
}

String _getPath(String path) {
  return path.replaceAll('\\', r'\');
}
