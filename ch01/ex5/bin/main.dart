import 'dart:io';

void main() {
  var messageA;
  var messageB = 'Привет';

  print('$messageA');
  print('$messageB');

  final messageC = 'Как тебя зовут?';
  print('$messageC');

 final input = stdin.readLineSync();
  stdout.writeln('Желаю Тебе успехов в изучении Dart, $input!');

}
// dart bin/main.dart
