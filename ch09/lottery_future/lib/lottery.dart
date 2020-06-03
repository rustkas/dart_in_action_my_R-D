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
