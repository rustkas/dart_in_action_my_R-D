library lottery;

import 'dart:async';
import 'dart:math' show Random;

typedef Callback = void Function(int winningNumber);
final r = Random();
void getWinningNumber(Callback callback) {
  final millisecs = r.nextInt(2000) + 10;
  print('waiting: $millisecs ms');
  Timer(Duration(milliseconds: millisecs), () {
    var number = r.nextInt(59) + 1;
    print('drawn number: $number');
    callback(number);
  });
}

String getResultsString(List<int> results, String message) {
  final str = StringBuffer();
  str.write(message);

  for (var i = 0; i < results.length; i++) {
    var currentResult = results[i];
    str.write(currentResult);
    if (i != results.length - 1) str.write(', ');
  }

  return str.toString();
}
