import 'dart:html';

import 'package:data_expence/dartexpense.dart';
import 'package:data_expence/src/data_access.dart';
import 'package:data_expence/src/localStorage.dart';
import 'package:data_expence/src/mocks/mock_data.dart';

void main() {
  final uiContainer = document.getElementById('dartexpense');
  DataAccess dataSource = LocalStorage();
  if (dataSource.expenses.isNotEmpty) {
    app = AppController(uiContainer, dataSource);
  } else {
    dataSource = LocalStorage.load(MockData().expenses);
    app = AppController(uiContainer, dataSource);
  }
}
// webdev serve
