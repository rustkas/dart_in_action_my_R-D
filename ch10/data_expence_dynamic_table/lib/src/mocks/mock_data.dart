import '../app.dart';
import '../data_access.dart';
import '../models.dart';

import 'mock_expense_types.dart';
import 'mock_expenses.dart';

class MockData implements DataAccess {
  @override
  final Map<String, ExpenseType> expenseTypes;
  final Map<int, Expense> _expenses;

  @override
  List<Expense> get expenses => _expenses.values.toList();
  

  MockData()
      :
        // constructor initializer block
        expenseTypes = loadExpenseTypes(
            getMockExpenseTypes), // passing in the function in library scope
        _expenses = <int, Expense>{} {
    var tmpExpenses = loadExpenses(
        getMockExpenses); // passing in the function in library scope

    //transfer the list of expenses into a map so that we can lookup by id later
    for (var ex in tmpExpenses) {
      _expenses[ex.id] = ex;
    }
  }

  /// add to the list. Returns true if it was adeed
  /// returns false if edited
  @override
  bool addOrUpdate(Expense expense) {
    var wasAdded = false;

    if (_expenses.containsKey(expense.id) == false) {
      print('adding new item');
      wasAdded = true;
    }

    _expenses[expense.id] = expense;

    return wasAdded;
  }

  @override
  Map<int, Expense> expensesMap;

  @override
  set expenseTypes(Map<String, ExpenseType> expenseTypes) {
    print(expenseTypes);
  }
}
