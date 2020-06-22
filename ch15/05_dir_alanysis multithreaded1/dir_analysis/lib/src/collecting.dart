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
Future<void> analyzeFileList(List<String> fileList) async {
  await _doAction(_getFileTypesEntryPoint, fileList);
  await _doAction(_getFileSizesEntryPoint, fileList);
}

/// Do independent action with specified functionality `action`
Future<void> _doAction(Function(SendPort) action, List<String> fileList) async {
  final fileTypesReceivePort = ReceivePort();

  await Isolate.spawn(action, fileTypesReceivePort.sendPort);
  
  fileTypesReceivePort.listen((results) async {
    if (results is SendPort) {
      results.send(fileList);
    } else if (results is Map) {
      results.forEach((key, value) {
        print('${key}\t|\t${value}');
      });

      fileTypesReceivePort.close();
    }
  });
}

void _getFileTypesEntryPoint(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((fileList) {
    final typeCount = _getFileTypes(fileList);
    print('=== Type count ===');
    print('Type\t|\tCount');

    sendPort.send(typeCount);
  });
}

void _getFileSizesEntryPoint(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((fileList) {
    final totalSizes = _getFileSizes(fileList);
    print('=== Total sizes (in MB) ===');
    sendPort.send(totalSizes);
  });
}

//
Map<String, int> _getFileTypes(List<String> fileList) {
  var result = <String, int>{};
  for (var fileName in fileList) {
    if (FileSystemEntity.isDirectorySync(fileName)) {
      _collectFileTypes(result, Directory(fileName).listSync());
    } else {}
    _collectFileTypeAndNumber(File(fileName), result);
  }
  return result;
}

Map<String, int> _getFileSizes(List<String> fileList) {
  var result = <String, int>{};

  for (var fileName in fileList) {
    if (FileSystemEntity.isDirectorySync(fileName)) {
      _collectFileSizes(result, Directory(fileName).listSync());
    } else {
      _collectFileSizeAndExtension(File(fileName), result);
    }
  }

  return result;
}

Map<String, int> _collectFileTypes(
    Map<String, int> result, List<FileSystemEntity> fileList) {
  for (var item in fileList) {
    if (FileSystemEntity.isDirectorySync(item.path)) {
      _collectFileTypes(result, Directory(item.path).listSync());
    } else {
      _collectFileTypeAndNumber(item, result);
    }
  }
  return result;
}

Map<String, int> _collectFileSizes(
    Map<String, int> result, List<FileSystemEntity> fileList) {
  for (var item in fileList) {
    if (FileSystemEntity.isDirectorySync(item.path)) {
      _collectFileSizes(result, Directory(item.path).listSync());
    } else {
      _collectFileSizeAndExtension(File(item.path), result);
    }
  }
  return result;
}

void _collectFileTypeAndNumber(FileSystemEntity file, Map<String, int> result) {
  final fileName = _getFileName(file);
  final extension = _getFileExtension(fileName);
  if (result.containsKey(extension)) {
    result[extension]++;
  } else {
    result[extension] = 1;
  }
}

void _collectFileSizeAndExtension(File file, Map<String, int> result) {
  final fileName = _getFileName(file);
  final extension = _getFileExtension(fileName);
  final fileSize = file.lengthSync();
  if (result.containsKey(extension)) {
    result[extension] += fileSize;
  } else {
    result[extension] = fileSize;
  }
}

/// Return file name
String _getFileName(FileSystemEntity fileEntity) {
  return (fileEntity.path.split(Platform.pathSeparator).last);
}

String _getFileExtension(String filename) {
  var extSeparator = filename.lastIndexOf('.') + 1;
  extSeparator = extSeparator == -1 ? 0 : extSeparator;
  return filename.substring(extSeparator, filename.length).toLowerCase();
}
