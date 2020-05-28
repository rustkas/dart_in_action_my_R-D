import 'dart:html';

void main() {
  final title = Element.html('<h2>PackList</h2>');
  final InputElement itemInput = Element.tag('input');
  itemInput
    ..id = 'txt-item'
    ..placeholder = 'Enter an item';

  final ButtonElement addButton = Element.tag('button');
  addButton
    ..id = 'btn-add'
    ..text = 'Add';

  final DivElement itemContainer = Element.tag('div');
  itemContainer
    ..id = 'items'
    ..style.width = '300px'
    ..style.border = '1px solid black';

  itemContainer.children.addAll([
    Element.html('<div>Camera</div>'),
    Element.html('<div>Passport</div>'),
  ]);

  document.body.children.addAll([title, itemInput, addButton, itemContainer]);
}
