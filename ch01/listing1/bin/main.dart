void main() {
  var h = 'Hello';
  final w = 'World';
  print('$h $w');

  print(r'$h $w');

  var helloWorld = 'Hello ' 'World';
  print(helloWorld);

  print('${helloWorld.toUpperCase()}');
  print('Ответ равен ${5 + 10}');

  var multiline = '''
  <div id='greeting'>
   "Hello World"
  </div>''';
  print(multiline);

  var o = Object();
  print(o.toString());
  print('$o');
}
