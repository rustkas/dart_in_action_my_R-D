import 'dart:html';

void main() {
  var button = Element.tag('button');
  button.text = 'Click me';
  button.onClick.listen((event) {
    var buttonList = document.getElementsByTagName('button');
    window.alert('There is ${buttonList.length}');
  });
  document.body.children.add(button);
}
// webdev serve
// localhost:8080
