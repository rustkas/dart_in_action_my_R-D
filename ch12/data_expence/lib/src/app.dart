import 'dart:convert';
import 'dart:html';

import 'models.dart';
import 'navigate.dart';

class AppController {
  final DataAccess _appData;
  DataAccess get appData => _appData;

  final DivElement _uiRoot;
  // final Map<ViewType, View> _viewCache;
  DivElement _content;
  DivElement _actions;

  AppController(this._uiRoot, this._appData);
  //  : _viewCache = <ViewType, View>{};

  List<Expense> get expenses => _appData.expenses;
  Map<String, ExpenseType> get expenseTypes => _appData.expenseTypes;

  void buildUI() {
    var header = Element.html('<header class=\'section\'>DartExpense</header>');
    _uiRoot.children.add(header);

    _content = DivElement();
    _content.id = 'content';
    _content.classes.add('section');
    _uiRoot.children.add(_content);

    _actions = DivElement();
    _actions.id = 'actions';
    _actions.classes.add('section');
    _uiRoot.children.add(_actions);

    var footer = Element.html('<footer class=\'section\'>Offline</footer>');
    _uiRoot.children.add(footer);
  }

  void loadFirstView() {
    // try and load a value from the location cookie
    var stateCookieValue = getValueFromCookie('stateData');

    if (stateCookieValue != null && stateCookieValue.isNotEmpty) {
      print('stateCookie=$stateCookieValue');
      var stateData = stateCookieValue.split('/');
      var viewName = stateData[0];
      var id = stateData.length == 2 ? int.parse(stateData[1]) : null;
      var viewType = ViewType(viewName);

      navigate(viewType, id);
    } else {
      navigate(ViewType.LIST, null);
    }
  }

  void updateView(View view) {
    _content.children.clear();
    _content.children.add(view.rootElement);
    _actions.children.clear();
    _actions.children.add(view.actions);
  }

  void addOrUpdate(Expense expense) {
    //add it to the list if it's not already there.
    _appData.addOrUpdate(expense);
  }

  void showMessage(String message) {
    // TODO: Implement this - such as 'Your expense has been saved'
  }

  void hideMessage() {
    // TODO: Implement this
  }

  Expense getExpenseById(int id) {
    var result;
    if (id == null || id.toString().isEmpty) {
      result = Expense(); // create a new expense
    } else {
      final List matchingList =
          expenses.where((expense) => expense.id == id).toList();
      result = matchingList[0]; // return an existing expense
    }

    return result;
  }
}

abstract class View {
  DivElement rootElement;
  DivElement actions;
}

class ViewType {
  final String name;

  const ViewType(this.name);

  static ViewType LIST = const ViewType('list');
  static ViewType EDIT = const ViewType('edit');
  static ViewType CHART = const ViewType('chart');

  @override
  String toString() => name;
  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(other) => other.name == name;
}

abstract class DataAccess {
  Map<String, ExpenseType> get expenseTypes;
  List<Expense> get expenses;
  bool addOrUpdate(Expense expense);
  List<Expense> getExpensesByType(ExpenseType expenseType);
  Map<ExpenseType, double> getAggregatedData();
}

AppController _app;
AppController get app => _app;
set app(AppController app) {
  _app = app;
  _app.buildUI();
  _app.loadFirstView();
  window.onPopState.listen(onPopState);
}

void sendToJavaScript(String action, var payload) {
  final data = <String, Object>{};
  data['type'] = 'dart2js';
  data['action'] = action;
  data['payload'] = payload;
  window.postMessage(jsonEncode(data), window.location.href);
}
