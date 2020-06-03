import 'dart:html';

void main() {
  
  final InputElement itemInput = Element.tag('input');
  final ButtonElement addButton = Element.tag('button');
  final children = document.body.children;

  itemInput.placeholder = 'Enter an item';
  
  addButton
    ..text = 'Add'
    ..id = 'add-btn';
  children
    ..add(Element.html('<h2>PackList</h2>'))
    ..add(itemInput)
    ..add(addButton)
    ..add(Element.tag('div'));
}
