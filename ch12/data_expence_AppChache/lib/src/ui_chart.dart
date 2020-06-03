import 'dart:convert';
import 'dart:html';

import '../dartexpense.dart';
import 'models.dart';
import 'navigate.dart';

class ChartView implements View {
  @override
  DivElement rootElement;
  @override
  DivElement actions;
  Map<ExpenseType, double> expenseSummary;
  ButtonElement returnToListButton;

  ChartView(this.expenseSummary) {
    _buildViewWithInjection();
    _buildActions();
  }

  void _buildViewWithInjection() {
    rootElement = Element.html(
        '<div id=\'chartView\' style=\'width:500px; height:150px\'></div>');

    final payload = [];
    payload.add(['Type', 'Amount']);

    for (var expenseType in expenseSummary.keys) {
      var totalAmount = expenseSummary[expenseType];
      payload.add([expenseType.name, totalAmount]);
    }

    sendToJavaScript('chart', payload);

    void onFinishedListener(event) {
      var data = jsonDecode(event.data);
      if (data['type'] == 'js2dart') {
        if (data['action'] == 'chartComplete') {
          window.removeEventListener('onMessage', onFinishedListener);
          returnToListButton.disabled = false;
        }
      }
    }

    window.onMessage.listen(onFinishedListener);
  }

  void _buildActions() {
    actions = DivElement();
    returnToListButton = ButtonElement();
    returnToListButton.text = 'View List';
    returnToListButton.disabled = true;
    returnToListButton.onClick.listen((event)  => navigate(ViewType.LIST, null));
    actions.nodes.add(returnToListButton);
  }
}
