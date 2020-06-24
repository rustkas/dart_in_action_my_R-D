import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

const utf8Encoder = Utf8Encoder();

/// Return file list in the [folderPath]
Future<List<String>> getFileList(String folderPath) {
  var completer = Completer<List<String>>();

  if (!FileSystemEntity.isDirectorySync(folderPath)) {
    completer.complete(null);
  } else {
// this is an example of using Directory.fromRawPath factory
    final directory = Directory.fromRawPath(utf8Encoder.convert(folderPath));
    directory.exists().then((bool exists) {
      if (!exists) {
        completer.complete(null);
        return completer.future;
      }
      final fileList = <String>[];
      final lister = directory.list();

      lister.listen((file) => fileList.add(file.path),
          onDone: () => completer.complete(fileList));
    });
  }

  return completer.future;
}

String isolateName;
// Analyze files in the list recursively
Future<void> analyzeFileList(List<String> fileList) async {
  
  isolateName = 'Default isolate';
  await Isolate.spawn(getFileTypesEntryPoint, 'FileTypes isolate');
  await Isolate.spawn(getFileSizesEntryPoint, 'FileSizes isolate');
  print(isolateName);
  
  for (var i = 0; i < 100000; i++) {}
}

void getFileTypesEntryPoint(String message) {
  isolateName = message;
  print(isolateName);
}

void getFileSizesEntryPoint(String message) {
  isolateName = message;
  print(isolateName);
}
