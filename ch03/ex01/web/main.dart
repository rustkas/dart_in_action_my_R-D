import 'dart:html';

void main() {
  final childNodes = document.body.nodes;
  final h2 = Element.html('<h2 id="title">Pack<em>List</em></h2>');
  final div = Element.tag('div');

  childNodes.add(h2);
  childNodes.add(div);
}
//webdev serve
