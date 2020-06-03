import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  final results = parser.parse(arguments);

  print('${Platform.script}');

  print('Count of arguments - ${results.arguments.length}');
  print(results.arguments);
}
// dart bin/a_01_options.dart hello world
