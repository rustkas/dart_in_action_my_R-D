import 'dart:html';

void main() {
  final bodyList = document.body.children;
  final title = HeadingElement.h2();
  bodyList.add(title);

  final itemInput = InputElement();
  itemInput
    ..id = 'txt-item'
    ..placeholder = 'Enter an item';
  bodyList.add(itemInput);

  final addButton = ButtonElement();
  addButton
   ..id = 'btn-add'
   ..text = 'Add';
  bodyList.add(addButton);

  final itemContainer = DivElement();
  itemContainer
    ..id = 'items'
    ..style.width = '300px'
    ..style.border = '1px solid black'
    ..innerHtml = '&nbsp;';
  bodyList.add(itemContainer);
}
