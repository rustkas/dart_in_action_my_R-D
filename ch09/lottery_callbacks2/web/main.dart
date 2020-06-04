import 'dart:html';

import 'package:lottery/lottery.dart';

final results = <int>[];

void main() {
  getWinningNumber((int result1) {
    updateResult(1, result1);

    getWinningNumber((int result2) {
      updateResult(2, result2);

      getWinningNumber((int result3) {
        updateResult(3, result3);

        results.add(result1);
        results.add(result2);
        results.add(result3);
        var resultString = getResultsString(results, 'Drawn numbers are: ');
        document.getElementById('winningNumbers').text = resultString;
      });
    });
  });
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
