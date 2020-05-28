import 'dart:html';

void main() {
  TableElement tableElement = Element.tag('table');

  var head = tableElement.createFragment('''
        
          <thead>
            <td class="type">Type</td>
            <td class="date">Date</td>
            <td class="detail">Item</td>
            <td class="amount">Amount</td>
            <td class="claimed">Claimed?</td>
            <td class="edit">&nbsp;</td>
          </thead>
         
          ''');
  print(head);
//  tableElement.children.add(head);
  tableElement.nodes.addAll(head.nodes);
  document.body.children.add(tableElement);
}
