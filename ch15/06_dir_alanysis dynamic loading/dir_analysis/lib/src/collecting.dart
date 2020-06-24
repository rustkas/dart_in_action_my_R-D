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

// Analyze files in the list recursively
Future<void> analyzeFileList(
    List<String> fileList, List<String> dynamicSourceFiles) async {
  var counter = 0;
  final fileTypesReceivePort = ReceivePort();

  for (var sourceFileName in dynamicSourceFiles) {
    await Isolate.spawnUri(Uri.file(sourceFileName), <String>[], fileTypesReceivePort.sendPort);
  }
  
  fileTypesReceivePort.listen((results) async {
    if (results is SendPort) {
      results.send(fileList);
    } else if (results is Map) {
      results.forEach((key, value) {
        print('${key}\t|\t${value}');
      });

      counter++;
      if (counter >= 2) {
        fileTypesReceivePort.close();
      }
    }
  });
}
