import 'dart:html';


import 'data_access.dart';
import 'models.dart';
import 'navigate.dart';
import 'ui_edit.dart';
import 'ui_list.dart';

class AppController {
  final DataAccess _appData;
  final DivElement _uiRoot;
  final Map<ViewType, View> _viewCache;
  DivElement _content;
  DivElement _actions;

  AppController(this._uiRoot, this._appData) : _viewCache = <ViewType, View>{};

  List<Expense> get expenses => _appData.expenses;
  Map<String, ExpenseType> get expenseTypes => _appData.expenseTypes;

  void buildUI() {
    final header = Element.html("<header class='section'>DartExpense</header>");
    _uiRoot.children.add(header);

    _content = DivElement();
    _content
      ..id = 'content'
      ..classes.add('section');
    _uiRoot.children.add(_content);

    _actions = DivElement();
    _actions
      ..id = 'actions'
      ..classes.add('section');
    _uiRoot.children.add(_actions);

    final footer = Element.html("<footer class='section'>Offline</footer>");
    _uiRoot.children.add(footer);
  }

  void loadFirstView() {
    final View view = ListView(expenses);
    
    var id;
    var viewType = ViewType.list;
    // try and load a value from the location cookie
    final stateCookieValue = getValueFromCookie('stateData');

    if (null != stateCookieValue && stateCookieValue.isNotEmpty) {
      final stateData = stateCookieValue.split('/');
      if (stateData.isNotEmpty && stateData.length == 2) {
        final viewName = stateData[0];
        try {
          viewType = ViewType.withName(viewName);
        } on Exception catch (_) {
          print('Can not get view name');
        }
        try {
          id = int.parse(stateData[1]);
        } on FormatException catch (_) {
          print('Can not get item id while parse cookie data');
          viewType = ViewType.list;
        }
      }
    }

    updateView(view);
    navigate(viewType, id);
  }

  void updateView(View view) {
    _content.children
      ..clear()
      ..add(view.rootElement);
    _actions.children
      ..clear()
      ..add(view.actions);
  }

  void addOrUpdate(Expense expense) {
    //add it to the list if it's not already there.
    _appData.addOrUpdate(expense);
  }

  Expense getExpenseById(int id) {
    if (expenses.isEmpty) {
      return null;
    }
    List matchingList = expenses.where((expense) => expense.id == id).toList();
    return matchingList[0]; //return the first item. Should check for not null
  }

  EditView getEditView(int id) {
    // if id is null, then create a expense, otherwise get the existing expense
    Expense expenseToEdit;
    if (id != null) {
      expenseToEdit = getExpenseById(id);
    } else {
      expenseToEdit = Expense();
    }

    return EditView(expenseToEdit); // create a view
  }

  ListView getListView() {
    ListView view;

    if (_viewCache.containsKey(ViewType.list)) {
      view = _viewCache[ViewType.list]; // read from the cache
      view.refreshUi(expenses);
    } else {
      view = ListView(expenses); // create a view
      _viewCache[ViewType.list] = view; // and add to the cache
    }

    return view;
  }
}

abstract class View {
  DivElement rootElement;
  DivElement actions;
}

class ViewType {
  final String name;
  static const list_name = 'list';
  static const edit_name = 'edit';
  const ViewType(this.name);

  factory ViewType.withName(String name) {
    if (name == list_name) {
      return list;
    } else if (name == edit_name) {
      return edit;
    }
    throw Exception('$name - unknown view type');
  }
  static ViewType list = const ViewType(list_name);
  static ViewType edit = const ViewType(edit_name);

  @override
  String toString() => name;
  @override
  int get hashCode => name.hashCode;
}



AppController _app;
AppController get app => _app;
set app(AppController app) {
  if (_app == null) {
    _app = app;
    _app.buildUI();
    app.loadFirstView();
    window.onPopState.listen(onPopState);
  }
}

void onPopState(PopStateEvent event) {
  if (event.state != null) {
    final stateData = (event.state as String).split('/');
    var viewName = stateData[0];
    var id = stateData.length == 2 ? int.parse(stateData[1]) : null;
    var viewType = ViewType.withName(viewName);
    navigate(viewType, id, true);
  }
}

/// Find cookie item value.
/// `key` is cookie item key.
String getValueFromCookie(String key) {
  var itemValue = '';
  try {
    final string = document.cookie;
    for (var cookieItem in string.split(';')) {
      final key_value = cookieItem.split('=');
      if (key_value.length > 1) {
        final itemKey = key_value[0].trim();
        if (itemKey == key && key_value.length > 1) {
          itemValue = key_value[1];
          break;
        } //if
      } //if
    } //for
  } catch (e) {
    print('Can not read the cookie');
  }

  return itemValue;
}
