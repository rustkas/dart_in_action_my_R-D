import 'dart:html';

void main() {
  var paragraphContent = 'Some about box text';
  final infoBoxDiv = Element.html(''' 
<div id='infoBox'>
<h3>About PackList</h3> 
<p>$paragraphContent</p>
</div>''');
  final childNodes = document.body.nodes;
  childNodes.add(infoBoxDiv);

  final myValue = 1234;
  final myString = '<p>$myValue</p>';
  final myOtherString = '<p>${myValue + 1}</p>';
  final myStringElement = Element.html(myString);
  final myOtherStringElement = Element.html(myOtherString);
  childNodes.add(myStringElement);
  childNodes.add(myOtherStringElement);
}
