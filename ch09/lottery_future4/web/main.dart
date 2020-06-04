import 'dart:html';

import 'package:lottery_future4/lottery.dart';

final results = <int>[];

void main() {
  final f1 = getFutureWinningNumber();
  final f2 = getFutureWinningNumber();
  final f3 = getFutureWinningNumber();

  f1.then((result) => updateResult(1, result));
  f2.then((result) => updateResult(2, result));
  f3.then((result) => updateResult(3, result));

  Future.wait([f1, f2, f3]).then((List winningNumbers) {
    var resultString = getResultsString(winningNumbers, 'Drawn numbers are: ');
    document.getElementById('winningNumbers').innerHtml = resultString;
  });
}

void updateResult(int ball, int result) {
  document.getElementById('ball$ball').text = '$result';
  addAndDisplay(result);
}

void addAndDisplay(int result) {
  results.add(result);
  if (results.length == 3) {
    final resultString = getResultsString(results, 'Drawn numbers are: ');
    document.getElementById('winningNumbers').text = resultString;
  }
}
