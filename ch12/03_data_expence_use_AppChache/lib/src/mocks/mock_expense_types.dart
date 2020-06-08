import '../models.dart';

Map<String, ExpenseType> getMockExpenseTypes() {
  Map expenseTypes = <String, ExpenseType>{};
  expenseTypes['TRV'] = ExpenseType('Travel','TRV');
  expenseTypes['BK'] =  ExpenseType('Books','BK');
  expenseTypes['HT'] = ExpenseType('Hotel','HT');
  return expenseTypes;
}
