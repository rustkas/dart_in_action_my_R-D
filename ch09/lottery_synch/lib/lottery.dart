library lottery;

import 'dart:math' show Random;

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
