import 'dart:html';
import 'package:data_expence/dartexpense.dart';

void main() {
  final uiContainer = document.getElementById('dartexpense');
  final dataSource = MockData();
  app = AppController(uiContainer, dataSource);
}
// webdev serve
