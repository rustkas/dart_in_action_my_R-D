import 'dart:html';

import 'app.dart';
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

  void refreshUi(List<Expense> expenses) {
    _updateRootElement();

    final tableElement = TableElement();
    final head = tableElement.createFragment('''
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
    actions.children..add(_getAddButton());
  }

  ButtonElement _getAddButton() {
    final addButton = ButtonElement();
    addButton
      ..text = 'Add...'
      ..onClick.listen((MouseEvent event) {
        navigate(ViewType.edit, null);
        event.stopImmediatePropagation();
      }); // null value passed in means add

    return addButton;
  }
}

// UTILITY FUNCTIONS

TableRowElement _getRowElement(Expense ex) {
  final row = TableRowElement();
  row.nodes
    ..add(row.createFragment('<td>${ex.type.name}</td>'))
    ..add(row.createFragment(
        '<td>${ex.date.day}-${ex.date.month}-${ex.date.year}</td>'))
    ..add(row.createFragment('<td>${ex.detail}</td>'))
    ..add(row.createFragment('<td>${ex.amount}</td>'))
    ..add(row.createFragment('<td>${_getIsClaimed(ex.isClaimed)}</td>'));

  final editCol =
      row.createFragment("<td class='edit'><button>Edit...</button></td>");

  final button = editCol.children.elementAt(0);
  row.nodes.add(editCol);

  button.onClick.listen((e) {
    navigate(ViewType.edit, ex.id);
  });

  return row;
}

String _getIsClaimed(bool isClaimed) {
  if (isClaimed) {
    return 'Claimed';
  }

  return '';
}
