import 'dart:html';

import 'package:lottery_callbacks/lottery.dart';

void main() {
// example 1 - stand-alone callbacks
 getWinningNumber( (int result1) => updateResult(1, result1));
 getWinningNumber( (int result2) => updateResult(2, result2));
 getWinningNumber( (int result3) => updateResult(3, result3));

//  example 2.1
 final results = <int>[];

 void addAndDisplay(int result) {
   results.add(result);
   if (results.length == 3) {
     var resultString = getResultsString(results, 'Drawn numbers are: ');
     document.getElementById('winningNumbers').text = resultString;
   }
 }

 getWinningNumber( (int result1) {
   updateResult(1, result1);
   addAndDisplay(result1);
 });

 getWinningNumber( (int result2) {
   updateResult(2, result2);
   addAndDisplay(result2);
 });

 getWinningNumber( (int result3) {
   updateResult(3, result3);
   addAndDisplay(result3);
 });
}

void updateResult(int ball, int result) {
  document.getElementById('ball$ball').text = '$result';
}
