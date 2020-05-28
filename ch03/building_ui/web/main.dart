import 'dart:html';

void main() {
  final bodyList = document.body.children;
  final title = HeadingElement.h2();
  bodyList.add(title);

  final itemInput = InputElement();
  itemInput.id = 'txt-item';
  itemInput.placeholder = 'Enter an item';
  bodyList.add(itemInput);

  final addButton = ButtonElement();
  addButton.id = 'btn-add';
  addButton.text = 'Add';
  bodyList.add(addButton);

  final itemContainer = DivElement();
  itemContainer.id = 'items';
  itemContainer.style.width = '300px';
  itemContainer.style.border = '1px solid black';
  itemContainer.innerHtml = '&nbsp;';
  bodyList.add(itemContainer);
}
