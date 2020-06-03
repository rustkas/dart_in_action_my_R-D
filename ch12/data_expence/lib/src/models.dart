import 'dart:convert';

abstract class JsonSerializable {
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
  bool isClaimed = false;

  /// ctor
  /// set the next id value
  Expense() {
    _id = _getNextId();
  }

  Map toMap() {
    final map = <String, Object>{};
    map['id'] = _id;
    if (date != null) {
      map['date'] = date.toString();
    }
    map['amount'] = amount;
    map['detail'] = detail;
    map['isClaimed'] = isClaimed;
    if (type != null) {
      map['expenseType'] = type.toMap();
    }
    return map;
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
    isClaimed = values['isClaimed'] ?? false;
    if (values.containsKey('expenseType')) {
      final expenseTypeMap = values['expenseType'];
      type = ExpenseType(expenseTypeMap['name'], expenseTypeMap['code']);
    }
  }

  Expense.fromMap(Map map) {
    _id = map['id'];
    if (map.containsKey('date') && map['date'] != null) {
      date = DateTime.parse(map['date']);
    }
    amount = map['amount'];
    detail = map['detail'];
    isClaimed = map['isClaimed'] ?? false;
    if (map.containsKey('expenseType')) {
      var expenseTypeMap = map['expenseType'];

      type = ExpenseType(expenseTypeMap['name'], expenseTypeMap['code']);
    }
  }

  /// convert the object into a json string
  @override
  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  int get hashCode => _id;

  /// shared across all instances
  static int _nextIdValue = 1;

  /// return the next Id value
  static int _getNextId() => _nextIdValue++;
  static set currentHighestId(int value) => _nextIdValue = value + 1;

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
