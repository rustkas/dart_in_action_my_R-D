/// Print folder's content.
/// Absolute path.

import 'dart:io';

import 'package:args/args.dart';

final parser = makeArgParser();

void main(List<String> arguments) {
  final options = parser.parse(arguments);
  //print(options.arguments);
  if (options.arguments.length != 2) {
    printHelp();
  } else if (options.arguments[0] == '--list') {
    listDir(options.arguments[1]);
  } else if (options.arguments[0] == '--out') {
    outputFile(options.arguments[1]);
  } else if (options.arguments[0] == '--help' || options.arguments[0] == 'h') {
    printHelp();
  }
}

void printHelp() {
  print('Dart Directory Lister');
  print(parser.usage);
}

void listDir(String folderPath) {
  final directory = Directory(folderPath);
  directory.exists().then((bool exists) {
    if (exists) {
      final absoluteFolderPath = directory.resolveSymbolicLinksSync();
      printDir(absoluteFolderPath);
    }
  });
}

void outputFile(String filePath) {
  print(filePath);
}

ArgParser makeArgParser() {
  final parser = ArgParser();

  parser.addOption('list', help: 'List files and directories: --list DIR'
      , callback: printDir
      );
  parser.addOption('out', help: 'Output file to console : --out FILE');
  parser.addFlag('help', help: 'Get help', abbr: 'h', negatable: false);
  return parser;
}

void printDir(String folderPath) {
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

// dart bin/main.dart --list dart
