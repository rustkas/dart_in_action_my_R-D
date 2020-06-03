import 'dart:html';

String w;

void main() {
  final a = 'Dart';
  final w_tmp = 'Привет';
  w = w_tmp;

  print('$w, $a!');
  querySelector('#output').text = '$w, $a!';
}
