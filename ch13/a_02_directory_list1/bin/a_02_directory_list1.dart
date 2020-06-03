/// Organise command project structure.
/// 
import 'package:args/args.dart';

final parser = makeArgParser();

void main(List<String> arguments) {
  final options = parser.parse(arguments);
  //print(options.arguments);
  if (options.arguments.length != 2) {
    printHelp();
  }
  else if (options.arguments[0] == '--list') {
    listDir(options.arguments[1]);
  } else if (options.arguments[0] == '--out') {
    outputFile(options.arguments[1]);
  }else if (options.arguments[0] == '--help' || options.arguments[0] == 'h') {
    printHelp();
  }
}

void printHelp() {
  print('Dart Directory Lister');
  print(parser.usage);
}

void listDir(String folderPath) {
  print(folderPath);
}

void outputFile(String filePath) {
  print(filePath);
}

ArgParser makeArgParser() {
  final parser = ArgParser();

  parser.addOption('list', help: 'List files and directories: --list DIR');
  parser.addOption('out', help: 'Output file to console : --out FILE');
  parser.addFlag('help',
      help: 'Get help', abbr: 'h', negatable: false);
  return parser;
}
// dart bin/a_02_directory_list1.dart --list list-test
// dart bin/a_02_directory_list1.dart --out file-test
// dart bin/a_02_directory_list1.dart --help
// dart bin/a_02_directory_list1.dart h
