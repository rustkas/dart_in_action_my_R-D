import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'app.dart';
import 'models.dart';
import 'navigate.dart';

class EditView implements View {
  @override
  DivElement rootElement;
  @override
  DivElement actions;

  // int _id;
  Expense _expense;

  EditView(Expense expense) {
    updateViewWithId(expense);
  }

  void updateViewWithId(Expense expense) {
    _expense = expense;
    _buildView();
    _buildActions();
  }

  void _buildView() {
    rootElement = Element.html('''
      <div class='expense' id='editexpense'>
        <label for='expenseTypes'>Type</label><select id='expenseTypes'>
          ${_getOptions(_expense.type)}
        </select><br/>
        <label for='expenseDate'>Date</label>${_getDate(_expense.date)}<br/>
        <label for='expenseAmount'>Amount</label>${_getAmount(_expense.amount)}</br>
        <label for='expenseDetail'>Detail</label>${_getDetail(_expense.detail)}  
        <fieldset><legend>Row actions</legend>${_getActions(_expense.itemActions)}</fieldset>
      </div>
      ''');
  }

  void _buildActions() {
    actions = DivElement();
    actions.children
      ..add(_getSaveButton())
      ..add(_getCancelButton())
      ..add(_getConvertToGBPButton());
  }

  Element _getSaveButton() {
    final saveButton = ButtonElement();
    saveButton
      ..text = 'Save'
      ..onClick.listen((e) {
        // read the values from the form back to the object
        // uses expense object in the function local scope
        _saveDetails(_expense);
        navigate(ViewType.list, null);
      });
    return saveButton;
  }

  Element _getCancelButton() {
    final cancelButton = ButtonElement();
    cancelButton
      ..text = 'Cancel'
      ..onClick.listen((e) => navigate(ViewType.list, null));
    return cancelButton;
  }

  void _saveDetails(Expense expense) {
    InputElement dateEl = document.getElementById('expenseDate');
    InputElement amountEl = document.getElementById('expenseAmount');
    TextAreaElement detailEl = document.getElementById('expenseDetail');
    SelectElement typeEl = document.getElementById('expenseTypes');
    final actionNode = document.getElementsByName('action');

    if (dateEl.value != '') {
      expense.date = DateTime.parse(dateEl.value);
    }

    if (amountEl.value != '') {
      expense.amount = double.parse(amountEl.value);
    }

    expense.detail = detailEl.value;

    if (typeEl.selectedIndex > 0) {
      final option = typeEl.options[typeEl.selectedIndex];
      final typeCode = option.value;
      expense.type = app.expenseTypes[typeCode];
    }

    if (actionNode != null && actionNode.isNotEmpty) {
      for (var item in actionNode) {
        final CheckboxInputElement checkBox = item;
        Action action;
        for (var actionItem in expense.itemActions) {
          if (actionItem.name == checkBox.value) {
            action = actionItem;
            break;
          }
        }
        final itemActions = expense.itemActions;
        if (!checkBox.checked) {
          itemActions.remove(action);
        } else {
          itemActions.add(Action.getAction(checkBox.value));
        }
      } //for
    }

    app.addOrUpdate(expense);
  }

  ButtonElement _getConvertToGBPButton() {
    final convertButton = ButtonElement();
    convertButton.text = 'Convert to RUB';
    convertButton.onClick.listen((e) {
      final scriptElement = ScriptElement();
      scriptElement.src =
          'http://openexchangerates.org/api/latest.json?app_id=60da2bd9b3064714b2c5f2e8b00fbd40%22&&callback=onExchangeRateData';

      scriptElement.type = 'text/javascript';
      document.head.children.add(scriptElement);
      scriptElement.remove();
      StreamSubscription onMessage;
      void onRateListener(event) {
        final data = jsonDecode(event.data);
        if (data['type'] == 'js2dart' && data['action'] == 'exchangeRates') {
          // this method do not remove
          // window.removeEventListener('message', onRateListener);
          onMessage.cancel();
          InputElement amountEl = document.getElementById('expenseAmount');
          final dollarValue = double.parse(amountEl.value);
          // print(data);
          final payload = data['payload'];
          final rubRate = payload['rates']['RUB'] as double;
          final rubValue = dollarValue * rubRate;
          // print(
          //     'dollarValue = $dollarValue, rubRate = $rubRate, rubValue = $rubValue');
          amountEl.value = rubValue.toStringAsFixed(2);
        }
      }

      onMessage = window.onMessage.listen(onRateListener);
    });
    return convertButton;
  }
}

// UTILITY FUNCTIONS
String _getActions(Set<Action> actionList) {
  final result = StringBuffer();
  // edit

  _addActionEditCheckBox(result);

  // delete
  _addCheckBox(result, actionList, Action.delete);

  return result.toString();
}

void _addActionEditCheckBox(StringBuffer result) {
  var item = Action.edit;
  result.write(
      '<label><input type="checkbox" name="action" disabled checked value="${item.name}">${item.name.substring(0, 1).toUpperCase()}${item.name.substring(1, item.name.length)}</label><br>');
}

void _addCheckBox(StringBuffer result, Set<Action> actionList, Action item) {
  var checked = '';
  if (actionList.contains(item)) {
    checked = 'checked';
  }
  _buildCheckBoxContent(result, checked, item);
}

void _buildCheckBoxContent(StringBuffer result, String checked, Action item) {
  result.write(
      '<label><input type="checkbox" name="action" $checked value="${item.name}">${item.name.substring(0, 1).toUpperCase()}${item.name.substring(1, item.name.length)}</label><br>');
}

String _getOptions(ExpenseType selectedExpenseType) {
  final result = StringBuffer();
  result.write('<option value=' '>&nbsp</option>');
  for (var et in app.expenseTypes.values) {
    if (et == selectedExpenseType) {
      result.write(
          '<option value="${et.code}" selected="selected">${et.name}</option>');
    } else {
      result.write('<option value="${et.code}">${et.name}</option>');
    }
  }

  return result.toString();
}

String _getDate(DateTime expenseDate) {
  // date needs to be in a very specific format of yyyy-mm-dd for the
  // html5 date picker to work.
  var dateElementString = '';

  if (expenseDate != null) {
    final year = _blankIfNull(expenseDate.year);
    final month = _getMonth(_blankIfNull(expenseDate.month));
    final day = _getDay(_blankIfNull(expenseDate.day));
    dateElementString =
        '<input type="date" id="expenseDate" value="$year-$month-$day">';
  } else {
    dateElementString = '<input type="date" id="expenseDate">';
  }

  return dateElementString;
}

String _getAmount(num amount) {
  return '<input type="number" id="expenseAmount" step="0.01" min="0" value="${_blankIfNull(amount)}">';
}

String _getDetail(String detail) {
  return '<textarea id="expenseDetail">${_blankIfNull(detail)}</textarea>';
}

Object _blankIfNull(Object o) {
  if (o == null) {
    return '';
  } else {
    return o;
  }
}

/// prefixes with a leading zero if the length is only a single char
String _getDay(int day) {
  if (day.toString().length == 1) {
    return '0$day';
  } else {
    return day.toString();
  }
}

/// prefixes with a leading zero if the length is only a single char
String _getMonth(int month) {
  if (month.toString().length == 1) {
    return '0$month';
  } else {
    return month.toString();
  }
}
