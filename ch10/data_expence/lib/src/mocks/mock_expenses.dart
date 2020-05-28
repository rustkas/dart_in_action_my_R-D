import '../models.dart';

List<Expense> getMockExpenses() {
  final expenses = <Expense>[];

  var expense = Expense();
  expense.type = const ExpenseType('Books', 'BK');
  expense.amount = 40.0;
  expense.detail = 'Dart in Action';
  expense.date = DateTime(2012, 07, 22, 10, 15, 55, 100);
  expense.isClaimed = true;
  expenses.add(expense);

  expense = Expense();
  expense.type = const ExpenseType('Travel', 'TRV');
  expense.amount = 50.0;
  expense.detail = 'Taxi from airport';
  expense.date = DateTime(2012, 07, 23, 10, 15, 55, 100);
  expense.isClaimed = false;
  expenses.add(expense);

  expense = Expense();
  expense.type = const ExpenseType('Hotel', 'HT');
  expense.amount = 150.0;
  expense.detail = 'City Hotel';
  expense.date = DateTime(2012, 07, 24, 10, 15, 55, 100);
  expense.isClaimed = false;
  expenses.add(expense);

  expense = Expense();
  expense.type = const ExpenseType('Travel', 'TRV');
  expense.amount = 55.0;
  expense.detail = 'Taxi to airport';
  expense.date = DateTime(2012, 07, 24, 10, 15, 55, 100);
  expense.isClaimed = false;
  expenses.add(expense);
  
  return expenses;
}
