import 'dart:html';

void main() {
  var children = document.body.children;
  children
    ..add(Element.html('<h2>PackList</h2>'))
    ..add(Element.tag('input'))
    ..add(Element.tag('button'))
    ..add(Element.tag('div'));

}
