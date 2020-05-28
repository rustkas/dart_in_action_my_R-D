import 'dart:html';

import 'package:lottery_synch/lottery.dart';

void main() {
  final num1_button = document.getElementById('ball1');
  final num2_button = document.getElementById('ball2');
  final num3_button = document.getElementById('ball3');
  final bodyList = document.body.children;

  final ButtonElement startButton = Element.html('<button>Start</button>');
  bodyList.add(startButton);

  startButton.onClick.listen((e) {
    startButton.disabled = true;

    // each call to getWinningNumber will block
    final num1 = getWinningNumber();
    num1_button.text = num1.toString();
    final num2 = getWinningNumber();
    num2_button.text = num2.toString();
    final num3 = getWinningNumber();
    num3_button.text = num3.toString();
  });

  var resetButton = ButtonElement();
  resetButton.text='Replay';
  bodyList.add(resetButton);
  resetButton.onClick.listen((e) {
    startButton.disabled = false;
    num1_button.text = '';
    num2_button.text = '';
    num3_button.text = '';
  });
}
