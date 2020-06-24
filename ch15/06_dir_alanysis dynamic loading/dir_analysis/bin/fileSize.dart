import 'dart:io';
import 'dart:isolate';

// Don't run this file directly, it is loaded dynamically.
Future<void> main(List<String> message, SendPort sendPort) async {
  if (sendPort != null) {
    _getFileSizesEntryPoint(sendPort);
  }
}

void _getFileSizesEntryPoint(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((fileList) {
    final totalSizes = _getFileSizes(fileList);

    // tune result for pritty print
    final newMap = totalSizes
        .map((key, value) => MapEntry(key, format(value / 1024 / 1024)));

    print('=== Total sizes (in MB) ===');
    print('Type\t|\tSize (MB)');
    sendPort.send(newMap);
  });
}

/// Format doube to xx.xx sring format
String format(double n) {
  var fraction = n - n.toInt();
  if (fraction == 0.0) {
    return n.toString();
  }
  var twoDigitFraction = (fraction * 100).truncateToDouble().toInt();
  return '${n.toInt()}.$twoDigitFraction';
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
