import 'dart:html';

import 'package:lottery/lottery.dart';
void main() {
  getWinningNumber( (int result1) {

    updateResult(1, result1);

    getWinningNumber( (int result2) {

      updateResult(2, result2);

      getWinningNumber( (int result3 ) {
        updateResult(3, result3);

        final winningNumbers = <int>[];
        winningNumbers.add(result1);
        winningNumbers.add(result2);
        winningNumbers.add(result3);
        var resultString = getResultsString(winningNumbers, 'Drawn numbers are: ');
        document.getElementById('winningNumbers').text = resultString;
      });

    });

  });
}

void updateResult(int ball, int result) {
  document.getElementById('ball$ball').text = '$result';
}
