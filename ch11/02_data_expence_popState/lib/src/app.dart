import 'dart:html';

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

  // void loadFirstView() {
  //   final view = ListView(expenses);
  //   updateView(view);
  // }

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
  const ViewType._withName(this.name);

  factory ViewType.withName(String name) {
    if (name == list_name) {
      return list;
    } else if (name == edit_name) {
      return edit;
    }
    throw Exception('$name - unknown view type');
  }
  static ViewType list = const ViewType._withName(list_name);
  static ViewType edit = const ViewType._withName(edit_name);

  @override
  String toString() => name;
  @override
  int get hashCode => name.hashCode;
}

abstract class DataAccess {
  Map<String, ExpenseType> expenseTypes;
  List<Expense> get expenses;
  bool addOrUpdate(Expense expense);
}

AppController _app;
AppController get app => _app;
set app(AppController app) {
  _app = app;
  _app.buildUI();
  // _app.loadFirstView();
  navigate(ViewType.list, null);
  window.onPopState.listen(onPopState);

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
