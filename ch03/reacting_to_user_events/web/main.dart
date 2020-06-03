import 'dart:html';

void main() {
  final bodyList = document.body.children;
  var title = HeadingElement.h2();
  title.text = 'PackList';
  bodyList.add(title);

  final itemInput = InputElement();
  itemInput.id = 'txt-item';
  itemInput.placeholder = 'Enter an item';
  itemInput.onKeyPress.listen((event) {
    if (event.keyCode == 13) {
      addItem();
    }
  });
  document.body.children.add(itemInput);

  final addButton = ButtonElement();
  addButton.id = 'btn-add';
  addButton.text = 'Add';
  addButton.onClick.listen((event) => addItem());
  document.body.children.add(addButton);

  final itemContainer = DivElement();
  itemContainer
    ..id = 'items'
    ..style.width = '300px'
    ..style.border = '1px solid black'
    ..innerHtml = '&nbsp;';
  document.body.children.add(itemContainer);
}

void addItem() {
  final itemInputList = document.getElementsByTagName('input');
  InputElement itemInput = itemInputList[0];
  DivElement itemContainer = document.getElementById('items');
  var itemText = itemInput.value;
  var listElement = Element.html("<div class='item'>${itemText}<div>");
  itemContainer.children.add(listElement);
  itemInput.value = '';
}
