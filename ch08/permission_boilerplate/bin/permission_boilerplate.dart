import 'dart:convert';

void main() {
  var jsonString = '''
  [
    {"charlieKey":"2012-07-23","aliceKey":"2012-08-16"}
  ]
  ''';
  List<dynamic> lastLogonMap = jsonDecode(jsonString);
  Map firstScore = lastLogonMap[0];
  print(firstScore['charlieKey']);
  jsonString = jsonEncode(lastLogonMap);
  print(jsonString);
}
