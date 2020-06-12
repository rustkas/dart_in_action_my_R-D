import 'models.dart';

abstract class DataAccess {
  Map<String, ExpenseType> get expenseTypes;
  List<Expense> get expenses;
  bool addOrUpdate(Expense expense);

  List<Expense> getExpensesByType(ExpenseType expenseType) {
    final result = <Expense>[];

    for (var ex in expenses) {
      // add all if no type is specified, or filter.
      if (ex.type == expenseType || null == expenseType) {
        result.add(ex);
      }
    }

    return result;
  }

  Map<ExpenseType, double> getAggregatedData() {
    final result = <ExpenseType, double>{};

    for (var expense in expenses) {
      if (result.containsKey(expense.type)) {
        result[expense.type] += expense.amount;
      } else {
        result[expense.type] = expense.amount;
      }
    }

    return result;
  }
}

typedef GetExpenseTypes = Map<String, ExpenseType> Function();
typedef GetExpenses = List<Expense> Function();

Map<String, ExpenseType> loadExpenseTypes(GetExpenseTypes dataSource) {
  return dataSource();
}

List<Expense> loadExpenses(GetExpenses dataSource) {
  return dataSource();
}
