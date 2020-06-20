import 'dart:convert';
import 'dart:html';

import 'package:model/model.dart';

import 'app.dart';
import 'navigate.dart';

/// Chart view
/// Graphical representation of expense information.
class ChartView implements View {
  @override
  DivElement actions;

  @override
  DivElement rootElement;

  Map<ExpenseType, double> expenseSummary;
  ButtonElement returnToListButton;

  ChartView(this.expenseSummary) {
    _buildViewWithInjection();
    _buildActions();
  }

  void _buildViewWithInjection() {
    rootElement = Element.html(
        '<div id="chartView" style="width:500px; height:150px"></div>');

    final payload = <List<Object>>[];
    payload.add(['Type', 'Amount']);

    for (var expenseType in expenseSummary.keys) {
      final totalAmount = expenseSummary[expenseType];
      payload.add([expenseType.name, totalAmount]);
    }

    sendToJavaScript('chart', payload);

    void onFinishedListener(event) {
      final data = jsonDecode(event.data);
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
    returnToListButton = ButtonElement()
      ..text = 'View List'
      ..disabled = true
      ..onClick.listen((event) => navigate(ViewType.list, null));
    actions.nodes.add(returnToListButton);
  }
}
