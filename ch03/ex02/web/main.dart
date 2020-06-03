import 'dart:html';

void main() {
  final childNodes = document.body.nodes;

  final divMultilineString = '''<div>
<p>a multiline string</p>
</div>''';
  final divMultilineElement = Element.html(divMultilineString);

  childNodes.add(divMultilineElement);
/*

*/
  final divMultilineString2 = '''<div>
<p>a multiline string</p>
</div>''';
  final divMultilineElement2 = Element.html(divMultilineString2);
  childNodes.add(divMultilineElement2);
}
