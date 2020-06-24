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
Isolate isolate1;
Isolate isolate2;

// Analyze files in the list recursively
Future<void> analyzeFileList(List<String> fileList) async {
  
  final receivePort = ReceivePort();
  isolateName = 'Default isolate';

  isolate1 = await Isolate.spawn(getFileTypesEntryPoint, receivePort.sendPort);
  isolate2 = await Isolate.spawn(getFileSizesEntryPoint, receivePort.sendPort);
  var counter = 0;
  print(isolateName);
  receivePort.listen((message) {
    print(message);
    counter++;
    if (counter >= 2) {
      
      isolate1.kill(priority: Isolate.immediate);
      isolate2.kill(priority: Isolate.immediate);
      isolate1 = null;
      isolate2 = null;
      receivePort.close();
    }
  });
  //for (var i = 0; i < 100000; i++) {}
}

void getFileTypesEntryPoint(SendPort sendPort) {
  sendPort.send('FileTypes isolate');
}

void getFileSizesEntryPoint(SendPort sendPort) {
  sendPort.send('FileSizes isolate');
}
