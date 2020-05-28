library lottery;

import 'dart:async';
import 'dart:math';

int getWinningNumber() {
  final r = Random();

  final millisecs = r.nextInt(2000) + 10;
  print('blocking for: $millisecs ms');
  final endMs = DateTime.now().millisecondsSinceEpoch + millisecs;
  var currentMs = DateTime.now().millisecondsSinceEpoch;
  while (currentMs < endMs) {
    currentMs = DateTime.now().millisecondsSinceEpoch;
  }

  final winningNumber = r.nextInt(59) + 1;
  print('pulled out number: $winningNumber');
  return winningNumber;
}

//getWinningNumber(Function callback(int winningNumber)) {
//
//  Random r = new Random();
//
//  int millisecs = r.nextInt(2000) + 10;
//  print('waiting: $millisecs ms');
//
//  window.setTimeout(() {
//    var number = r.nextInt(59) + 1;
//    print('drawn number: $number');
//    callback(number);
//  }, millisecs);
//
//
//}

// String getResultsString(List<int> results, String message) {
//   final str = StringBuffer();
//   str.write(message);

//   for (var i = 0; i < results.length; i++) {
//     var currentResult = results[i];
//     str.write(currentResult);
//     if (i != results.length - 1) str.write(', ');
//   }

//   return str.toString();
// }

// Future<String> slowlySortResults(List<int> results) {
//   Completer completer = Completer<String>();
//   Timer(Duration(seconds: 2), () {
//     results.sort((val1, val2) => val1 < val2 ? -1 : 1);

//     var str = getResultsString(results, 'Confirmed numbers are: ');

//     completer.complete(str);
//   });

//   return completer.future;
// }
