import 'dart:async';

import 'package:dir_analysis/files.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    var analysisFolder;
    List<String> dynamicSourceFiles;

    // create modifiable argument list
    var args = <String>[];
    args.addAll(arguments);
    if (arguments.length > 1) {
      analysisFolder = args.removeAt(0);
      dynamicSourceFiles = args;

      final fileList = await getFileList(analysisFolder);
      if (fileList != null) {
        await analyzeFileList(fileList, dynamicSourceFiles);
      } else {
        print('$analysisFolder is not correct folder path');
      }
    }
  }
}
// dart bin/main.dart "C:\work\armstrong"
// dart bin/main.dart "C:\work\TGH26BC.htm"
// dart bin/main.dart "C:\work\u2"
// dart bin/main.dart "C:\work\pakages"
// dart bin/main.dart "C:\work\u2" fileSize.dart fileTypes.dart
