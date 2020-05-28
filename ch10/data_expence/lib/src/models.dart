import 'dart:convert';

abstract class JsonSerializable {
  String toJson();
}

/// Model class representing an expense item
class Expense implements JsonSerializable {
  int _id;
  int get id => _id;
  ExpenseType type;
  DateTime date;
  num amount = 0;
  String detail;
  bool isClaimed = false;

  /// ctor
  /// set the next id value
  Expense() {
    _id = _getNextId();
  }

  /// ctor
  /// build up the object from a json string
  Expense.fromJson(String json) {
    var values = jsonDecode(json);

    _id = values['id'];
    if (values.containsKey('date')) {
      date = DateTime.parse(values['date']);
    }
    amount = values['amount'];
    detail = values['detail'];
    isClaimed = values['isClaimed'];
    if (values.containsKey('expenseTypeName')) {
      type = ExpenseType(values['expenseTypeName'], values['expenseTypeCode']);
    }
  }

  /// convert the object into a json string
  @override
  String toJson() {
    var values = <String, Object>{};
    values['id'] = _id;
    if (date != null) {
      values['date'] = date.toString();
    }
    values['amount'] = amount;
    values['detail'] = detail;
    values['isClaimed'] = isClaimed;
    if (type != null) {
      values['expenseTypeName'] = type.name;
      values['expenseTypeCode'] = type.code;
    }

    return JsonEncoder().convert(values);
  }

  @override
  int get hashCode => _id;

  /// shared across all instances
  static int _nextIdValue = 1;

  /// return the next Id value
  static int _getNextId() => _nextIdValue++;
}

/// Used to list the type of expenses
class ExpenseType {
  final String name;
  final String code;

  const ExpenseType(this.name, this.code);

  @override
  String toString() {
    return '${super.toString()}: $name, $code';
  }

  @override
  bool operator ==(other) {
    if (other is ExpenseType) {
      return name == other.name && code == other.code;
    }
    return false;
  }
}
