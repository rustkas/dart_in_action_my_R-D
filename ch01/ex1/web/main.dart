import 'dart:html';

// Making web version of "Hello, World"
void main() {
  final a = 'Dart';
  final w = 'Привет';

  print('Я:\t $w, $a!');
  print('$a:\t ' '$w!');

  var div = DivElement();
  div.text = 'Я:\t $w, $a!';
  document.body.children.add(div);
  div = DivElement();
  div.text = '$a:\t ' '$w!';
  document.body.children.add(div);
}
// pub get
// webdev serve
