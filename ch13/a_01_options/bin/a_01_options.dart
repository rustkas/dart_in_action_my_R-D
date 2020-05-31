import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  final results = parser.parse(arguments);

  //   Options options = new Options();
  // print(options.executable);
  // print(options.script);
  print('${Platform.script}');

  // List<String> args = options.arguments;
  // print(options.arguments);
print('Count of arguments - ${results.arguments.length}');
  print(results.arguments);
}
// dart bin/a_01_options.dart hello world
