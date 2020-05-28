import 'dart:html';

void main() {
  final title = Element.html('<h2 id="title">Pack<em>List</em></h2>');
  final InputElement itemInput = Element.tag('input');
  final ButtonElement addButton = Element.tag('button');
  final DivElement itemContainer = Element.tag('div');

  addButton.text = 'Ok';

  final elements = document.body.children;
  final newElements = [title, itemInput, addButton, itemContainer];
  elements.addAll(newElements);
}
