import 'dart:html';

void main() {
  final paragraphContent = 'список предметов';
  final infoBoxDiv = Element.html(''' s (три знака кавычки)
  <div id='infoBox'>
  <h3>About PackList</h3>
  <p>$paragraphContent</p>
</div>''');

  // final title = Element.html('<h2>PackList</h2>');
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

  final myValue = 1234;
  final myString = '<p>$myValue</p>';
  final myOtherString = '<p>${myValue + 1}</p>';

  itemContainer.children.addAll([
    Element.html('<div>Camera</div>'),
    Element.html('<div>Passport</div>'),
    Element.html('<div>$myString</div>'),
    Element.html('<div>$myOtherString</div>')
  ]);
  final DivElement itemContainer2 = Element.html(
      '<div id="items" style="width:300px;border:1px solid black">&nbsp</div>');
  document.body.children.addAll(
      [infoBoxDiv, itemInput, addButton, itemContainer, itemContainer2]);
}
