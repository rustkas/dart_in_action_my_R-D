import 'dart:convert';

abstract class JsonSerializable {
  /// convert the object into a json string
  String toJson();
}

/// Model class representing an expense item
class Expense<K, V> implements JsonSerializable, Map {
  int _id;
  int get id => _id;
  ExpenseType type;
  DateTime date;
  num amount = 0;
  String detail;
  var isClaimed = false;
  Set<Action> itemActions = <Action>{Action.edit};

  /// ctor
  /// set the next id value
  Expense() {
    _id = _getNextId();
  }

  /// ctor
  /// build up the object from a json string
  Expense.fromJson(String json) {
    final values = jsonDecode(json);

    _id = values['id'];
    if (values.containsKey('date')) {
      date = DateTime.parse(values['date']);
    }
    amount = values['amount'];
    detail = values['detail'];
    isClaimed = values['isClaimed'] ?? false;
    if (values.containsKey('expenseTypeName')) {
      type = ExpenseType(values['expenseTypeName'], values['expenseTypeCode']);
    }
    if (values.containsKey('expenseActions')) {
      itemActions.clear();
      for (var item in values['expenseActions']) {
        itemActions.add(Action.getAction(item['name']));
      }
    }
  }

  @override
  String toJson() {
    final values = <String, Object>{};
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
    values['expenseActions'] = itemActions.toList(growable: false);

    return jsonEncode(values);
  }

  @override
  int get hashCode => _id;

  /// shared across all instances
  static int _nextIdValue = 1;

  /// return the next Id value
  static int _getNextId() => _nextIdValue++;

  /// Map implementation methods:
  @override
  List get keys {
    return ['id', 'amount', 'expenseType', 'date', 'detail', 'isClaimed'];
  }

  @override
  Object operator [](key) {
    if (key == 'id') {
      return id;
    } else if (key == 'amount') {
      return amount;
    } else if (key == 'expenseType') {
      return type.toMap();
    } else if (key == 'date') {
      return date == null ? null : date.toString();
    } else if (key == 'detail') {
      return detail;
    } else if (key == 'isClaimed') {
      return isClaimed;
    } else if (key == 'itemActions') {
      return itemActions;
    } else {
      return null;
    }
  }

  @override
  void forEach(Function(K key, V value) func) {
    for (var k in keys) {
      func(k, this[k]);
    }
  }

  @override
  bool get isEmpty {
    throw UnimplementedError();
  }

  @override
  bool containsValue(value) {
    throw UnimplementedError();
  }

  @override
  bool containsKey(value) {
    throw UnimplementedError();
  }

  @override
  List get values {
    throw UnimplementedError();
  }

  @override
  int get length {
    throw UnimplementedError();
  }

  @override
  void clear() {
    throw UnimplementedError();
  }

  @override
  void remove(key) {
    throw UnimplementedError();
  }

  @override
  void putIfAbsent(key, ifAbsent) {
    throw UnimplementedError();
  }

  @override
  void operator []=(key, value) {
    throw UnimplementedError();
  }

  @override
  void addAll(Map other) {}

  @override
  Map<RK, RV> cast<RK, RV>() {
    throw UnimplementedError();
  }

  @override
  Iterable<MapEntry> get entries => throw UnimplementedError();

  @override
  bool get isNotEmpty => throw UnimplementedError();

  @override
  void addEntries(Iterable<MapEntry> newEntries) {}

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) f) {
    throw UnimplementedError();
  }

  @override
  void updateAll(dynamic Function(dynamic key, dynamic value) update) {}

  @override
  dynamic update(dynamic key, dynamic Function(dynamic value) update,
      {dynamic Function() ifAbsent}) {
    throw UnimplementedError();
  }

  @override
  void removeWhere(bool Function(K key, V value) predicate) {}
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

   Map<String, String> toMap() {
    final map = <String, String>{};
    map['name'] = name;
    map['code'] = code;
    return map;
  }
}

/// Used to list the types of actions
abstract class Action implements JsonSerializable {
  static const edit_name = 'edit';
  static const delete_name = 'delete';
  static const edit = _ActionImp(edit_name);

  static const delete = _ActionImp(delete_name);

  final String _name;

  const Action(String name) : _name = name;
  String get name => _name;
  @override
  String toString() {
    return '$name';
  }

  @override
  bool operator ==(other) {
    if (other is Action) {
      return name == other.name;
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toJson() {
    final values = <String, String>{};
    values['name'] = name;
    return jsonEncode(values);
  }

  factory Action.getAction(String value) {
    if (value == Action.edit_name) {
      return Action.edit;
    } else if (value == Action.delete_name) {
      return Action.delete;
    }
    throw Exception('$value - unsupported input value');
  }
}

class _ActionImp extends Action {
  const _ActionImp(String name) : super(name);
}
