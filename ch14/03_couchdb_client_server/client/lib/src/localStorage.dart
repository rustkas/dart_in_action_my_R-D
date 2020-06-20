import 'dart:html';
import 'dart:convert';

import 'package:model/model.dart';

import 'data_access.dart';
import 'mocks/mock_expense_types.dart';


class LocalStorage extends DataAccess {
  @override
  final Map<String, ExpenseType> expenseTypes;

  @override
  List<Expense> get expenses {
    var maxId = 0;

    final expenses = <Expense>[];
    try {
      for (var key in window.localStorage.keys) {
        if (key.startsWith('expense:')) {
          final value = window.localStorage[key];
          // print('local storage key = $key value=$value');
          final map = jsonDecode(value);
          final expense = Expense.fromMap(map);
          expenses.add(expense);
          if (maxId < expense.id) {
            maxId = expense.id;
          }
        }
      }
    } on DomException catch (_) {
      print('Can not read data from local storage');
    }
    // set the static ID value on expense
    Expense.currentHighestId = maxId;

    return expenses;
  }

  LocalStorage()
      : expenseTypes = loadExpenseTypes(
            getMockExpenseTypes) // passing in the function in library scope
  ;
  factory LocalStorage.load(expenses) {
    final newITem = LocalStorage();
    if (null != expenses) {
      for (var item in expenses) {
        newITem.addOrUpdate(item);
      }
    }
    return newITem;
  }

  /// add to the list. Returns true if it was adeed
  /// returns false if edited
  @override
  bool addOrUpdate(Expense expense) {
    final localStorageKey = 'expense:${expense.id}';
    final wasAdded = !window.localStorage.containsKey(localStorageKey);

    try {
      window.localStorage[localStorageKey] = expense.toJson();
    } on DomException catch (ex) {
      if (ex.name == 'QUOTA_EXCEEDED_ERR') {
        window.alert('Local storage not enabled');
      }
    }

    return wasAdded;
  }
}
