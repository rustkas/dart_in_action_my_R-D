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
    // refreshUi_usingDynamicTable(expenses);
    _buildActions();
  }

  void refreshUi(List<Expense> expenses) {
    _updateRootElement();

    var tableElement = Element.tag('table');
    var head = tableElement.createFragment('''
          <thead>
            <td class="type">Type</td>
            <td class="date">Date</td>
            <td class="detail">Item</td>
            <td class="amount">Amount</td>
            <td class="claimed">Claimed?</td>
            <td class="edit">&nbsp;</td>
          </thead>''');

    // tableElement.children.add(head);
    tableElement.nodes.addAll(head.nodes);
    for (var ex in expenses) {
      tableElement.children.add(_getRowElement(ex));
    }

    rootElement.children.add(tableElement);
  }

  void refreshUi_usingDynamicTable(List<Expense> expenses) {
    _updateRootElement();

    var columnConfig = <String, GetValueFunc>{};
    columnConfig['type'] = (expense) => expense.type.name;
    columnConfig['date'] = (expense) => expense.date.toString();
    columnConfig['detail'] = (expense) => expense.detail;
    columnConfig['amount'] = (expense) => expense.amount.toString();

    var tableElement = getDynamicTable(expenses, columnConfig);

    rootElement.children.add(tableElement);
  }

  void _updateRootElement() {
    if (rootElement == null) {
      rootElement = Element.tag('div');
      rootElement.id = 'list';
    } else {
      rootElement.children.clear();
    }
  }

  void _buildActions() {
    actions = Element.tag('div');
    actions.onClick.listen((MouseEvent event) {
      print('actions click');
      // event.stopPropagation();
    }, cancelOnError: false);

    actions.children.add(_getAddButton());
    actions.children.add(_getClaimButton());
    actions.children.add(_getSyncButton());
  }

  ButtonElement _getAddButton() {
    var addButton = ButtonElement();
    addButton.text = 'Add...';
    addButton.onClick.listen((e) {
      print('add clicked');
      navigate(ViewType.EDIT, null);
      e.stopImmediatePropagation();
    }); // null value passed in means add

    addButton.onClick.listen((e) => print('second event handler'));

    return addButton;
  }

  ButtonElement _getClaimButton() {
    ButtonElement claimButton = Element.tag('button');
    claimButton.text = 'Claim All';
    claimButton.disabled = true;
    return claimButton;
  }

  ButtonElement _getSyncButton() {
    ButtonElement syncButton = Element.tag('button');
    syncButton.text = 'Sync';
    syncButton.disabled = true;
    return syncButton;
  }
}

// UTILITY FUNCTIONS

TableRowElement _getRowElement(Expense ex) {
  TableRowElement row = Element.tag('tr');
  
  row.nodes.add(row.createFragment('<td>${ex.type.name}</td>'));
  row.nodes.add(
      row.createFragment('<td>${ex.date.day}-${ex.date.month}-${ex.date.year}</td>'));
  row.nodes.add(row.createFragment('<td>${ex.detail}</td>'));
  row.nodes.add(row.createFragment('<td>${ex.amount}</td>'));
  row.nodes.add(row.createFragment('<td>${_getIsClaimed(ex.isClaimed)}</td>'));

  var editCol =
      row.createFragment("<td class='edit'></td>");
  final button = ButtonElement();
  button.text = 'Edit...';
  editCol.children.add(button);
  row.nodes.add(editCol);

  button.onClick.listen((e) {
    navigate(ViewType.EDIT, ex.id);
  });

  return row;
}

String _getIsClaimed(bool isClaimed) {
  if (isClaimed) {
    return 'Claimed';
  }

  return '';
}
