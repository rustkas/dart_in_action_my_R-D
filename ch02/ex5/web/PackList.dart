import 'dart:html';

void main() {
  final title = Element.html('<h2>PackList</h2>');
  final InputElement itemInput = Element.tag('input');
  itemInput
    ..id = 'txt-item'
    ..placeholder = 'Enter an item'
    ..onKeyPress.listen((event) {
      if (event.keyCode == 13) {
        addItem();
      }
    });
  ;

  final ButtonElement addButton = Element.tag('button');
  addButton
        ..id = 'btn-add'
        ..text = 'Add'
        ..onClick.listen((event) => addItem())
      // ..onClick.listen((MouseEvent event) {
      //   window.alert('Я тоже умею обрабатывать события');
      // })
      // ..onClick.listen((event) => window.alert('И я!'))
      ;

  addButton.addEventListener('click', myEventListenerFunction);
  addButton.removeEventListener('click', myEventListenerFunction);

  final DivElement itemContainer = Element.tag('div');
  itemContainer
    ..id = 'items'
    ..style.width = '300px'
    ..style.border = '1px solid black';

  // itemContainer.children.addAll([
  //   Element.html('<div class="item">Camera</div>'),
  //   Element.html('<div class="item">Passport</div>'),
  // ]);

  document.body.children.addAll([title, itemInput, addButton, itemContainer]);
}

void addItem() {
  final itemInputList = document.getElementsByTagName('input');
  final InputElement itemInput = itemInputList[0];
  final DivElement itemContainer = querySelector('#items');
  final packItem = PackItem(itemInput.value);
  //packItem.uiElement = Element.tag('div');
  itemContainer.children.add(packItem.uiElement);
  // final itemText = itemInput.value;
  // final listElement = Element.html('<div class='item'>${itemText}<div>');
  // itemContainer.children.add(listElement);
  itemInput.value = '';
}

dynamic myEventListenerFunction(Event event) {
  addItem();
}

class PackItem {
  final String itemText;
  DivElement _uiElement;
  bool _isPacked = false;

  bool get isPacked => _isPacked;

  set isPacked(value) {
    _isPacked = value;
    if (_isPacked) {
      uiElement.classes.add('packed');
    } else {
      uiElement.classes.remove('packed');
    }
  }

  DivElement get uiElement {
    _uiElement ??= () {
      final DivElement newElement = Element.tag('div');
      newElement.classes.add('item');
      newElement.text = itemText;
      // _uiElement.on.click.add( (event) => isPacked = !isPacked);
      newElement.onClick.listen((event) => isPacked = !isPacked);
      return newElement;
    }();
    return _uiElement;
  }
  //set uiElement(DivElement value) => _uiElement = value;

  PackItem(this.itemText) {
    //empty constructor body
  }
}
