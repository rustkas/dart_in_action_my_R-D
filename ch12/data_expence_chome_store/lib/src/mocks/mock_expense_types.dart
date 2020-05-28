


import '../models.dart';

Map<String, ExpenseType> getMockExpenseTypes() {
  Map expenseTypes = <String, ExpenseType>{};
  expenseTypes['TRV'] = const ExpenseType('Travel','TRV');
  expenseTypes['BK'] =  const ExpenseType('Books','BK');
  expenseTypes['HT'] = const ExpenseType('Hotel','HT');
  return expenseTypes;
}
