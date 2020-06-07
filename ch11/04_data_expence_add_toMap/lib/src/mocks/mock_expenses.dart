import '../models.dart';

List<Expense> getMockExpenses() {
  final expenses = <Expense>[];

  var expense = Expense()
    ..type = ExpenseType('Books', 'BK')
    ..amount = 40.0
    ..detail = 'Dart in Action'
    ..date = DateTime(2012, 07, 22, 10, 15, 55, 100)
    ..itemActions = {Action.edit, Action.delete}
    ..isClaimed = true;
  expenses.add(expense);

  expense = Expense()
    ..type = ExpenseType('Travel', 'TRV')
    ..amount = 50.0
    ..detail = 'Taxi from airport'
    ..date = DateTime(2012, 07, 23, 10, 15, 55, 100)
    ..itemActions = {Action.edit, Action.delete}
    ..isClaimed = false;
  expenses.add(expense);

  expense = Expense()
    ..type = ExpenseType('Hotel', 'HT')
    ..amount = 150.0
    ..detail = 'City Hotel'
    ..date = DateTime(2012, 07, 24, 10, 15, 55, 100)
    ..isClaimed = false;
  expenses.add(expense);

  expense = Expense()
    ..type = ExpenseType('Travel', 'TRV')
    ..amount = 55.0
    ..detail = 'Taxi to airport'
    ..date = DateTime(2012, 07, 24, 10, 15, 55, 100)
    ..isClaimed = false;
  expenses.add(expense);

  return expenses;
}
