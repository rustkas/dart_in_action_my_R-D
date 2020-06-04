import 'dart:html';
import 'package:lottery_future/lottery.dart';

final results = <int>[];

void main() {
  final f1 = getFutureWinningNumber();
  final f2 = getFutureWinningNumber();
  final f3 = getFutureWinningNumber();

  // example 3 - stand-alone futures
  f1.then((result) => updateResult(1, result));
  f2.then((result) => updateResult(2, result));
  f3.then((result) => updateResult(3, result));
}

void updateResult(int ball, int result) {
  document.getElementById('ball$ball').text = '$result';
  addAndDisplay(result);
}

void addAndDisplay(int result) {
  results.add(result);
  if (results.length == 3) {
    var resultString = getResultsString(results, 'Drawn numbers are: ');
    document.getElementById('winningNumbers').text = resultString;
  }
}
