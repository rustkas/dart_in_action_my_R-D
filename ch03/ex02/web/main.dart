import 'dart:html';

void main() {
  var childNodes = document.body.nodes;

  var divMultilineString = '''<div>
<p>a multiline string</p>
</div>''';
  final divMultilineElement = Element.html(divMultilineString);

  childNodes.add(divMultilineElement);
/*

*/
  var divMultilineString2 = '''<div>
<p>a multiline string</p>
</div>''';
  final divMultilineElement2 = Element.html(divMultilineString2);
  childNodes.add(divMultilineElement2);
}
