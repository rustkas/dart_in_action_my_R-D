import 'dart:html';

String w;

void main() {
  var a = 'Dart';
  var w_tmp = 'Привет';
  w = w_tmp;

  //print('$w, $a!');
  querySelector('#output').text = '$w, $a!';
}
