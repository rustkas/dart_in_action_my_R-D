import 'dart:html';

import 'app.dart';
import 'models.dart';
import 'navigate.dart';
import 'ui_list.dart';

typedef GetValueFunc = String Function(Expense item);

TableElement getDynamicTable(
    List<Expense> items, Map<String, GetValueFunc> columnConfig) {
  final table = TableElement();
  _addHeader(table);
  _addContent(items, table, columnConfig);

  return table;
}

void _addHeader(TableElement table) {
  final header = Element.tag('thead');
  final headerRow = TableRowElement();

  for (var colName in ListView.titleInfo.keys) {
    final className = ListView.titleInfo[colName][ListView.css_class];
    final columnName = ListView.titleInfo[colName][ListView.title];

    headerRow.nodes.add(
        headerRow.createFragment('<td class=\'$className\'>$columnName</td>'));
  }
  header.nodes.add(headerRow);
  table.nodes.add(header);
}

void _addContent(List<Expense> items, TableElement table,
    Map<String, GetValueFunc> columnConfig) {
  for (var item in items) {
    final row = TableRowElement();
    table.nodes.add(row);

    for (var colName in columnConfig.keys) {
      final getValueFunc = columnConfig[colName];
      final textValue = getValueFunc(item);
      if (colName == 'itemAction') {
        var button = ButtonElement();
        button.text = 'Edit...';
        button.onClick.listen((event) {
          navigate(ViewType.edit, item.id);
        });
        if (!textValue.contains('edit')) {
          button.disabled = true;
        }
        var docFragment = row.createFragment('<td class="edit"></td>');
        docFragment.nodes.add(button);
        row.nodes.add(docFragment);

        // Delete button
        button = ButtonElement();
        button.text = 'Delete...';
        if (!textValue.contains('delete')) {
          button.disabled = true;
        }
        button.onClick.listen((event) {
          row.remove();
          items.remove(item);
        });
        
        docFragment = row.createFragment('<td class="delete"></td>');
        docFragment.nodes.add(button);
        row.nodes.add(docFragment);

        continue;
      }
      row.nodes.add(row.createFragment('<td>$textValue</td>'));
    }
  }
}
