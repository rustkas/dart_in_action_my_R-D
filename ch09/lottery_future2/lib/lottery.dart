library lottery;

import 'dart:async';

import 'dart:math' show Random;

final r = Random();
Future<int> getFutureWinningNumber() {
  final numberCompleter = Completer<int>();

  getWinningNumber((winningNumber) {
    numberCompleter.complete(winningNumber);
  });

  return numberCompleter.future;
}

void getWinningNumber(void Function(int winningNumber) callback) {
  final millisecs = r.nextInt(2000) + 10;
  print('waiting: $millisecs ms');
  Timer(Duration(milliseconds: millisecs), () {
    final number = r.nextInt(59) + 1;
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
