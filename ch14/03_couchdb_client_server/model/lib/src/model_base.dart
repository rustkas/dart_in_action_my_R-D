import 'dart:convert';

/// Util class for reducing type mistakes while providing
/// fiied name value to the map or JSON of Expense class.
mixin ExpenceNames implements Map<String, dynamic> {
  static const id_name = 'id';
  static const date_name = 'date';
  static const amount_name = 'amount';
  static const detail_name = 'detail';
  static const isClaimed_name = 'isClaimed';
  static const expenseType_name = 'expenseType';
  static const expenseActions_name = 'expenseActions';
  static const rev_name = '_rev';

  /// Map implementation methods:
  @override
  List<String> get keys {
    return [
      id_name,
      amount_name,
      date_name,
      detail_name,
      isClaimed_name,
      expenseType_name,
      expenseActions_name
    ];
  }

  @override
  void forEach(Function(String key, dynamic value) func) {
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
  dynamic remove(key) {
    throw UnimplementedError();
  }

  @override
  dynamic putIfAbsent(String key, ifAbsent) {
    throw UnimplementedError();
  }

  @override
  void operator []=(String key, value) {
    throw UnimplementedError();
  }

  @override
  void addAll(Map<String, dynamic> other) {}

  @override
  Map<RK, RV> cast<RK, RV>() {
    throw UnimplementedError();
  }

  @override
  Iterable<MapEntry<String, dynamic>> get entries => throw UnimplementedError();

  @override
  bool get isNotEmpty => throw UnimplementedError();

  @override
  void addEntries(Iterable<MapEntry> newEntries) {}

  @override
  Map<K2, V2> map<K2, V2>(
      MapEntry<K2, V2> Function(String key, dynamic value) f) {
    throw UnimplementedError();
  }

  @override
  void updateAll(dynamic Function(String key, dynamic value) update) {}

  @override
  dynamic update(String key, Function(dynamic value) update,
      {Function() ifAbsent}) {
    throw UnimplementedError();
  }

  @override
  void removeWhere(bool Function(String key, dynamic value) predicate) {}
}

/// Model class representing an expense item
class Expense with ExpenceNames implements Map<String, dynamic> {
  int _id;
  int get id => _id;
  ExpenseType type;
  DateTime date;
  num amount = 0;
  String detail;
  var isClaimed = false;
  Set<Action> itemActions = <Action>{Action.edit};
  String _rev;

  String get rev => _rev;
  set rev(value) => _rev = value;

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write(id);
    sb.write(' ');
    if (type != null) {
      sb.write(jsonEncode(type.toMap()));
    }
    sb.write(' ');
    sb.write(date);
    sb.write(' ');
    sb.write(amount);
    sb.write(' ');
    sb.write(isClaimed);
    sb.write(' ');
    if (itemActions != null) {
      sb.write(jsonEncode(Action.createMap(itemActions)));
    }
    sb.write(' ');
    sb.write(rev);
    return sb.toString();
  }

  /// ctor
  /// set the next id value
  Expense() {
    _id = _getNextId();
  }

  /// ctor
  /// build up the object from a json string
  Expense.fromJson(String json) {
    final values = jsonDecode(json);
    Expense.fromMap(values);
  }

  /// ctor
  /// build up the object from a map
  Expense.fromMap(Map<String, dynamic> map) {
    _id = map[ExpenceNames.id_name];
    if (map[ExpenceNames.id_name] == null) {
      _id = _getNextId();
    }
 
    if (map.containsKey(ExpenceNames.date_name) &&
        map[ExpenceNames.date_name] != null) {
      date = DateTime.parse(map[ExpenceNames.date_name]);
    }
    amount = map[ExpenceNames.amount_name];
    detail = map[ExpenceNames.detail_name];
    isClaimed = map[ExpenceNames.isClaimed_name] ?? false;
    if (map.containsKey(ExpenceNames.expenseType_name)) {
      var expenseTypeMap = map[ExpenceNames.expenseType_name];

      type = ExpenseType(expenseTypeMap['name'], expenseTypeMap['code']);
    }
    if (map.containsKey(ExpenceNames.expenseActions_name)) {
      for (var item in map[ExpenceNames.expenseActions_name]) {
        itemActions.add(Action.getAction(item['name']));
      }
    }
    if (map.containsKey(ExpenceNames.rev_name)) {
      rev = map[ExpenceNames.rev_name];
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    // print('before mapping: ${toString()}');
    map[ExpenceNames.id_name] = id;
    if (date != null) {
      map[ExpenceNames.date_name] = date.toString();
    }
    map[ExpenceNames.amount_name] = amount;
    map[ExpenceNames.detail_name] = detail;
    map[ExpenceNames.isClaimed_name] = isClaimed;
    if (type != null) {
      map[ExpenceNames.expenseType_name] = type.toMap();
    }
    if (itemActions != null) {
      map[ExpenceNames.expenseActions_name] = Action.createMap(itemActions);
    }
    if (rev != null) {
      map[ExpenceNames.rev_name] = rev;
    }
    if (map[ExpenceNames.id_name] == null) {
      throw new Exception('ID is null');
    }
    // print('MAP: $map');
    return map;
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  int get hashCode => id;

  /// shared across all instances
  static int _nextIdValue = 1;

  /// return the next Id value
  static int _getNextId() => _nextIdValue++;

  static set currentHighestId(int value) => _nextIdValue = value + 1;
  static int get currentHighestId => _nextIdValue;

  @override
  Object operator [](Object key) {
    final keyItem = key as String;
    if (keyItem == ExpenceNames.id_name) {
      return id;
    } else if (key == ExpenceNames.rev_name) {
      return rev;
    } else if (keyItem == ExpenceNames.amount_name) {
      return amount;
    } else if (keyItem == ExpenceNames.expenseType_name) {
      return type.toMap();
    } else if (keyItem == ExpenceNames.date_name) {
      return date == null ? null : date.toString();
    } else if (keyItem == ExpenceNames.detail_name) {
      return detail;
    } else if (keyItem == ExpenceNames.isClaimed_name) {
      return isClaimed;
    } else if (keyItem == ExpenceNames.expenseActions_name) {
      final list = <Map<String, String>>[];
      for (var item in itemActions) {
        list.add(item.toMap());
      }
      return list;
    } else {
      return null;
    }
  }
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
  bool operator ==(Object other) =>
      other is ExpenseType && name == other.name && code == other.code;

  @override
  int get hashCode => name.hashCode + code.hashCode;

  Map<String, String> toMap() {
    final map = <String, String>{};
    map['name'] = name;
    map['code'] = code;
    return map;
  }
}

/// Used to list the types of actions
abstract class Action {
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
  bool operator ==(Object other) => other is Action && name == other.name;

  @override
  int get hashCode => name.hashCode;

  static List<Map<String, String>> createMap(Set<Action> actions) {
    final list = <Map<String, String>>[];
    for (var item in actions) {
      list.add({'name': item.name});
    }
    return list;
  }

  Map<String, String> toMap() {
    final map = <String, String>{};
    map['name'] = name;
    return map;
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
