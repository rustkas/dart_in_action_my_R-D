import 'dart:html';

import 'package:lottery_future3/lottery.dart';

void main() {
  final f1 = getFutureWinningNumber();
  final f2 = getFutureWinningNumber();
  final f3 = getFutureWinningNumber();

   f1.then((result1) {
   updateResult(1, result1);

   f2.then((result2) {
     updateResult(2, result2);

     f3.then((result3) {
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
