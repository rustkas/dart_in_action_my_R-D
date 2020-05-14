import 'dart:html';

void main() {
  final myString1 = '''
 <div>
<p>a multiline string</p>
</div>''';

  var myString2 = '<div>' '<p>a string</p>' '</div>';

  final title1 = Element.html(myString1);
  final title2 = Element.html(myString2);
  document.body.children.addAll([title1, title2]);
}
