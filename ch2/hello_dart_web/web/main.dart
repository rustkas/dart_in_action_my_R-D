import 'dart:html';

void main() {
  var text = 'Hello Dart for Web';
  Element h1 = document.getElementsByTagName('h1')[0];
  h1.innerText = text;
  
}
