import 'dart:html';

void main() {
  final bodyList = document.body.children;
  final title = Element.html('<h2>PackList</h2>');
  bodyList.add(title);

  final itemInput = InputElement();
  itemInput.id = 'txt-item';
  itemInput.placeholder = 'Enter an item';
  itemInput.onKeyPress.listen((event) {
    if (event.keyCode == 13) {
      addItem();
    }
  });
  bodyList.add(itemInput);

  final addButton = ButtonElement();
  addButton.id = 'btn-add';
  addButton.text = 'Add';
  addButton.onClick.listen((event) => addItem());
  bodyList.add(addButton);

  final itemContainer = DivElement();
  itemContainer.id = 'items';
  itemContainer.style.width = '300px';
  itemContainer.style.border = '1px solid black';
  itemContainer.innerHtml = '&nbsp;';
  bodyList.add(itemContainer);
}

void addItem() {
  print('add item');
  final itemInputList = document.getElementsByTagName('input');
  final InputElement itemInput = itemInputList[0];
  final DivElement itemContainer = document.getElementById('items');
  final packItem = PackItem(itemInput.value);
  itemContainer.children.add(packItem.uiElement);
  itemInput.value = '';
}

class PackItem {
  var itemText;
  DivElement _uiElement;

  var _isPacked = false;

  bool get isPacked => _isPacked;

  set isPacked(value) {
    _isPacked = value;
    if (_isPacked == true) {
      uiElement.classes.add('packed');
    } else {
      uiElement.classes.remove('packed');
    }
  }

  DivElement get uiElement {
    if (_uiElement == null) {
      _uiElement = DivElement();
      _uiElement.classes.add('item');
      _uiElement.text = itemText;
      _uiElement.onClick.listen((event) => isPacked = !isPacked);
    }
    return _uiElement;
  }

  PackItem(this.itemText);
}
