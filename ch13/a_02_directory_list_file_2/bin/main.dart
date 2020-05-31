/// Print folder's content.
/// Relative path.
/// Usign option's callback
/// Using print file content by 'print' function

import 'dart:io';

import 'package:args/args.dart';

final parser = makeArgParser();

/// stup for privent double printing help information
var getHelp = false;
void main(List<String> arguments) {
  final options = parser.parse(arguments);
  //print(options.arguments);
  if (options.arguments.length != 2) {
    //printHelp();
  }
}

void printHelp(bool pass) {
  // wrong calling. Just ignore it.
  if (!pass) {
    return;
  }

  if (!getHelp) {
    getHelp = true;
    print('Dart Directory Lister');
    print(parser.usage);
  }
}

void outputFile(String filePath) {
  print(filePath);
}

ArgParser makeArgParser() {
  final parser = ArgParser();

  parser.addOption('list',
      help: 'List files and directories: --list DIR', callback: printDir);
  parser.addOption('out',
      help: 'Output file to console : --out FILE', callback: printFile);
  parser.addFlag('help', help: 'Get help', abbr: 'h', callback: printHelp);
  return parser;
}

void printDir(String folderPath) {
  // wrong calling. Just ignore it.
  if (null == folderPath) {
    return;
  }
  var directory = Directory(folderPath);

  directory.exists().then((bool exists) {
    if (exists) {
      print('|------------------------------');
      print('|Directory content:');
      print('|------------------------------');
      directory.list().listen(
        (FileSystemEntity entity) {
          // print(entity.path);
          if (entity is File) {
            print('|<FILE>| ${entity.path}');
          } else if (entity is Directory) {
            print('|<DIR> | ${entity.path}');
          }
        },
        onDone: () {
          print('Finished');
        },
      );
    }
  });
}

void printFile(String filePath) {
  // wrong calling. Just ignore it.
  if (null == filePath) {
    return;
  }

  final file = File(filePath);
  file.exists().then((bool exists) {
    if (exists) {
      final inputStream = file.openRead();
      final sb = StringBuffer();
      inputStream.listen(
        (data) {
          if (data != null) {
            sb.write(String.fromCharCodes(data));
          }
        },
        onDone: () {
          print(sb.toString());
        },
      );
    }
  });
}


// dart bin/main.dart --out dart/options.dart
// dart bin/main.dart --out bin/main.dart
// dart bin/main.dart --help
