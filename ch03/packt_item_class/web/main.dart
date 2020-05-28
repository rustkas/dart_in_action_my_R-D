import 'dart:html';

void main() {
  final bodyList = document.body.children;
  final title = Element.html('<h2>PackList</h2>');
  bodyList.add(title);

  final itemInput = InputElement();
  itemInput
    ..id = 'txt-item'
    ..placeholder = 'Enter an item'
    ..onKeyPress.listen((event) {
      if (event.keyCode == 13) {
        addItem();
      }
    });
  bodyList.add(itemInput);

  final addButton = ButtonElement();
  addButton
    ..id = 'btn-add'
    ..text = 'Add'
    ..onClick.listen((event) => addItem());
  bodyList.add(addButton);

  final itemContainer = DivElement();
  itemContainer
    ..id = 'items'
    ..style.width = '300px'
    ..style.border = '1px solid black'
    ..innerHtml = '&nbsp;';
  bodyList.add(itemContainer);
}

void addItem() {
  final itemInputList = document.getElementsByTagName('input');
  InputElement itemInput = itemInputList[0];
  DivElement itemContainer = document.getElementById('items');
  final itemText = itemInput.value;
  final listElement = Element.html("<div class='item'>${itemText}<div>");
  itemContainer.children.add(listElement);
  itemInput.value = '';
}

class PackItem {
  var itemText;
  var uiElement;

  PackItem(this.itemText);
}
