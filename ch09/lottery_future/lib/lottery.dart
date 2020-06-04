library lottery;

import 'dart:async';
import 'dart:math' show Random;

typedef Callback = void Function(int winningNumber);
final r = Random();

Future<int> getFutureWinningNumber() {
  var numberCompleter = Completer<int>();

  _getWinningNumber((winningNumber) {
    numberCompleter.complete(winningNumber);
  });

  return numberCompleter.future;
}

void _getWinningNumber(Callback callback) {
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
    str.write(results[i]);
    if (i != results.length - 1) {
      str.write(', ');
    }
  }

  return str.toString();
}
