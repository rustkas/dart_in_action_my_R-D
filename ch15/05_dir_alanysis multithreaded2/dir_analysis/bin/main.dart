import 'dart:async';

import 'package:dir_analysis/files.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    for (var folderPath in arguments) {
      final fileList = await getFileList(folderPath);
      if (fileList != null) {
        await analyzeFileList(fileList);
      } else {
        print('$folderPath is not correct folder path');
      }
    }
  }
}
// dart bin/main.dart "C:\work\armstrong"
// dart bin/main.dart "C:\work\TGH26BC.htm"
// dart bin/main.dart "C:\work\u2"
// dart bin/main.dart "C:\work\pakages"
