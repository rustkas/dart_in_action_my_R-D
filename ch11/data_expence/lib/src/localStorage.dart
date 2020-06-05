import 'dart:html';
import 'dart:convert';

import 'app.dart';
import 'data_access.dart';
import 'mocks/mock_expense_types.dart';
import 'models.dart';


class LocalStorage implements DataAccess {
  @override
  final Map<String, ExpenseType> expenseTypes;

  @override
  List<Expense> get expenses {
    var maxId = 0;

  var expenses = <Expense>[];
    for (var key in window.localStorage.keys) {
      if (key.startsWith('expense:')) {
        var value = window.localStorage[key];
        var map = jsonDecode(value);
        var expense = Expense.fromMap(map);
        expenses.add(expense);
        if (maxId < expense.id) {
          maxId = expense.id;
        }
      }
    }

    // set the static ID value on expense
    Expense.currentHighestId = maxId;

    return expenses;
  }

  LocalStorage() :
    expenseTypes = loadExpenseTypes(getMockExpenseTypes) // passing in the function in library scope
;
  /// add to the list. Returns true if it was adeed
  /// returns false if edited
  @override
  bool addOrUpdate(Expense expense) {
    var localStorageKey = 'expense:${expense.id}';
    var wasAdded = !window.localStorage.containsKey(localStorageKey);

    try {
      window.localStorage[localStorageKey] = expense.toJson();
    }
    catch (ex) {
      if (ex.name == 'QUOTA_EXCEEDED_ERR') {
        window.alert('Local storage not enabled');
      }
    }

    return wasAdded;
  }

  @override
  List<Expense> getExpensesByType(ExpenseType expenseType) {
    var result = <Expense>[];

    for (var ex in expenses) {
      // add all if no type is specified, or filter.
      if (ex.type == expenseType || expenseType == null) {

        result.add(ex);
      }
    }

    return result;
  }
}
