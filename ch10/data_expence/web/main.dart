import 'dart:html';
import 'package:data_expence/dartexpense.dart';

void main() {
  final uiContainer = document.getElementById('dartexpense');
  final dataSource = MockData();
  final app1 = AppController(uiContainer, dataSource);
  
  app = app1;
  ;
}
