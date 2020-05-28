import 'dart:html';

void main() {
  var children = document.body.children;
  InputElement itemInput = Element.tag('input');
  itemInput.placeholder = 'Enter an item';
  ButtonElement addButton = Element.tag('button');
  addButton.text = 'Add';
  addButton.id = 'add-btn';
  children
    ..add(Element.html('<h2>PackList</h2>'))
    ..add(itemInput)
    ..add(addButton)
    ..add(Element.tag('div'));
}
