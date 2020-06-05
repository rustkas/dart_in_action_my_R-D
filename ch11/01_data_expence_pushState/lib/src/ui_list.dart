import 'dart:html';

import 'app.dart';
import 'genericListView.dart';
import 'models.dart';
import 'navigate.dart';

class ListView implements View {
  @override
  DivElement rootElement;
  @override
  DivElement actions;

  ListView(List<Expense> expenses) {
    refreshUi(expenses);
    _buildActions();
  }
  static const title = 'title';
  static const css_class = 'class';
  static const map_key = 'key';
  static const map_value = 'value';

  static const titleInfo = <String, Map<String, String>>{
    'type': <String, String>{title: 'Type', css_class: 'type'},
    'date': <String, String>{title: 'Date', css_class: 'date'},
    'detail': <String, String>{title: 'Detail', css_class: 'detail'},
    'amount': <String, String>{title: 'Amount', css_class: 'amount'},
    'claimed': <String, String>{title: 'Claimed?', css_class: 'claimed'},
    'edit': <String, String>{title: '&nbsp;', css_class: 'edit'},
    'delete': <String, String>{title: '&nbsp;', css_class: 'delete'},
  };

  void refreshUi(List<Expense> expenses) {
    _updateRootElement();

    var columnConfig = <String, GetValueFunc>{};
    columnConfig['type'] = (Expense expense) => expense.type.name;
    columnConfig['date'] = (Expense expense) => expense.date.toString();
    columnConfig['detail'] = (Expense expense) => expense.detail;
    columnConfig['amount'] = (Expense expense) => expense.amount.toString();
    columnConfig['isClaimed'] =
        (Expense expense) => expense.isClaimed.toString();
    columnConfig['itemAction'] =
        (Expense expense) => expense.itemActions.toString();
    final tableElement = getDynamicTable(expenses, columnConfig);

    rootElement.children.add(tableElement);
  }

  void _updateRootElement() {
    if (rootElement == null) {
      rootElement = DivElement();
      rootElement.id = 'list';
    } else {
      rootElement.children.clear();
    }
  }

  void _buildActions() {
    actions = DivElement();
    actions.onClick.listen((MouseEvent event) {
      print('actions click');
      event.stopPropagation();
    }, cancelOnError: false);

    actions.children.add(_getAddButton());
    actions.children.add(_getClaimButton());
    actions.children.add(_getSyncButton());
  }

  ButtonElement _getAddButton() {
    final addButton = ButtonElement();
    addButton
      ..text = 'Add...'
      ..onClick.listen((MouseEvent event) {
        print('add clicked');
        navigate(ViewType.edit, null);
        event.stopImmediatePropagation();
      }); // null value passed in means add

    addButton.onClick.listen((e) => print('second event handler'));

    return addButton;
  }

  ButtonElement _getClaimButton() {
    final claimButton = ButtonElement();
    claimButton
      ..text = 'Claim All'
      ..disabled = true;
    return claimButton;
  }

  ButtonElement _getSyncButton() {
    final syncButton = ButtonElement();
    syncButton
      ..text = 'Sync'
      ..disabled = true;
    return syncButton;
  }
}
