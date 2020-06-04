import 'models.dart';

typedef GetExpenseTypes = Map<String,ExpenseType> Function();
typedef GetExpenses = List<Expense> Function();


Map<String, ExpenseType> loadExpenseTypes(GetExpenseTypes dataSource) {
  return dataSource();
}


List<Expense> loadExpenses(GetExpenses dataSource) {
  return dataSource();
}
