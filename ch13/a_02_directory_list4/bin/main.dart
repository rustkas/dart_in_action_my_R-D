/// Print folder's content.
/// Relative path.
/// Usign option's callback

import 'dart:io';

import 'package:args/args.dart';

final parser = makeArgParser();
/// stup for privent double print help information
var getHelp = false;
void main(List<String> arguments) {
  final options = parser.parse(arguments);
  //print(options.arguments);
  if (options.arguments.length != 2) {
    printHelp();
  } 
}

void printHelp([bool ok]) {
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
  parser.addOption('out', help: 'Output file to console : --out FILE');
  parser.addFlag('help',
      help: 'Get help', abbr: 'h', negatable: false, callback: printHelp);
  return parser;
}

void printDir(String folderPath) {
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

// dart bin/main.dart --list dart
// dart bin/main.dart --help