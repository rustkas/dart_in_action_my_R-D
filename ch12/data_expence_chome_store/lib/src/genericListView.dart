import 'dart:html';

typedef GetValueFunc = String Function(dynamic item);


TableElement getDynamicTable(List items, Map<String, GetValueFunc> columnConfig) {
  var table = Element.tag('table');

  var header = Element.tag('thead');
  for (var colName in columnConfig.keys) {
    header.children.add(Element.html('<td>$colName</td>'));
  }
  table.children.add(header);

  for (var item in items) {
    var row = Element.tag('tr');
    table.children.add(row);

    for (var colName in columnConfig.keys) {
      var getValueFunc = columnConfig[colName];
      var textValue = getValueFunc(item);
      row.children.add(Element.html('<td>$textValue</td>'));
    }

  }

  return table;
}
