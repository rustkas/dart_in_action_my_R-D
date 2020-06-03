import 'dart:html';

import 'models.dart';
import 'ui_edit.dart';
import 'ui_list.dart';

class AppController {
  final DataAccess _appData;
  final DivElement _uiRoot;
  final Map<ViewType, View> _viewCache;
  DivElement _content;
  DivElement _actions;

  AppController(this._uiRoot, this._appData) :
    _viewCache = <ViewType,View>{};

  List<Expense> get expenses => _appData.expenses;
  Map<String, ExpenseType> get expenseTypes => _appData.expenseTypes;

  void buildUI() {

    var header = Element.html("<header class='section'>DartExpense</header>");
    _uiRoot.children.add(header);

    _content = Element.tag('div');
    _content.id= 'content';
    _content.classes.add('section');
    _uiRoot.children.add(_content);

    _actions = Element.tag('div');
    _actions.id = 'actions';
    _actions.classes.add('section');
    _uiRoot.children.add(_actions);

    var footer = Element.html("<footer class='section'>Offline</footer>");
    _uiRoot.children.add(footer);
  }


  void loadFirstView() {
    var view = ListView(expenses);
    updateView(view);
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
    List matchingList = expenses.where((expense) => expense.id == id).toList();
    return matchingList[0]; //return the first item. Should check for not null
  }



  EditView getEditView(int id) {
    // if id is null, then create a expense, otherwise get the existing expense
    Expense expenseToEdit;
    if (id != null) {
      expenseToEdit = getExpenseById(id);
    }
    else {
      expenseToEdit = Expense();
    }

    return EditView(expenseToEdit);  // create a view
  }

  ListView getListView() {
    var view;

    if (_viewCache.containsKey(ViewType.LIST)) {
      view = _viewCache[ViewType.LIST]; // read from the cache
      view.refreshUi(expenses);
    }
    else {
      view = ListView(expenses);  // create a view
      _viewCache[ViewType.LIST] = view; // and add to the cache
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

  const ViewType._withName(this.name);

  static ViewType LIST = const ViewType._withName('list');
  static ViewType EDIT = const ViewType._withName('edit');

  @override
  String toString() => name;
 @override
  int get hashCode => name.hashCode;

}

abstract class DataAccess {
  Map<String, ExpenseType> expenseTypes;
  Map<int, Expense> expensesMap;
  List<Expense> get expenses;
  bool addOrUpdate(Expense expense);
}

AppController _app;
AppController get app => _app;
set app(AppController app) {
  _app = app;
  _app.buildUI();
  _app.loadFirstView();
}
