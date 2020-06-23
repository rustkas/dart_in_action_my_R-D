import 'dart:io';
import 'dart:isolate';

/// Don't run this file directly, it is loaded dynamically.
void main(List<String> message, SendPort sendPort) {
  
  if (sendPort != null) {
    _getFileTypesEntryPoint(sendPort);
  }
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

void _collectFileTypeAndNumber(FileSystemEntity file, Map<String, int> result) {
  final fileName = _getFileName(file);
  final extension = _getFileExtension(fileName);
  if (result.containsKey(extension)) {
    result[extension]++;
  } else {
    result[extension] = 1;
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
