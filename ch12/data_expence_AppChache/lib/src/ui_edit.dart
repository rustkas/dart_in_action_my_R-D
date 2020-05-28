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

  int _id;
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
      </div>
          ''');
  }

  void _buildActions() {
    actions = DivElement();
    var children = actions.children;
    children
      ..add(_getSaveButton())
      ..add(_getCancelButton())
      ..add(_getConvertToGBPButton());
  }

  ButtonElement _getConvertToGBPButton() {
    final convertButton = ButtonElement();
    convertButton.text = 'Convert to GBP';
    convertButton.onClick.listen((e) {
      final scriptElement = ScriptElement();
      scriptElement.src =
          'http://openexchangerates.org/api/latest.json?app_id=60da2bd9b3064714b2c5f2e8b00fbd40%22&&callback=onExchangeRateData';

      scriptElement.type = 'text/javascript';
      document.head.children.add(scriptElement);
      scriptElement.remove();

      void onRateListener(event) {
        final data = jsonDecode(event.data);
        if (data['type'] == 'js2dart' && data['action'] == 'exchangeRates') {
          window.removeEventListener('onMessage', onRateListener);

          InputElement amountEl = document.getElementById('expenseAmount');
          final dollarValue = double.parse(amountEl.value);

          final payload = data['payload'];
          // final gbpRate = payload['rates']['GBP'];
          final gbpRate = payload['rates']['RUB'];
          final gbpValue = dollarValue * gbpRate;
          amountEl.value = gbpValue.toStringAsFixed(2);
          if (window.navigator.onLine == false) {
            window.alert('Для получения обменных курсов подключитесь к сети');
          }
          print(payload['rates']);
        }
      }

      window.onMessage.listen(onRateListener);
    });
    return convertButton;
  }

  Element _getSaveButton() {
    var saveButton = ButtonElement();
    saveButton.text = 'Save';
    saveButton.onClick.listen((e) {
      // read the values from the form back to the object
      // uses expense object in the function local scope
      _saveDetails(_expense);
      navigate(ViewType.LIST, null);
    });

    return saveButton;
  }

  Element _getCancelButton() {
    var cancelButton = ButtonElement();
    cancelButton.text = 'Cancel';
    cancelButton.onClick.listen((e) => navigate(ViewType.LIST, null));
    return cancelButton;
  }

  void _saveDetails(Expense expense) {
    InputElement dateEl = document.getElementById('expenseDate');
    InputElement amountEl = document.getElementById('expenseAmount');
    TextAreaElement detailEl = document.getElementById('expenseDetail');
    SelectElement typeEl = document.getElementById('expenseTypes');

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

    print(expense.toJson());
    app.addOrUpdate(expense);
  }
}

// UTILITY FUNCTIONS

String _getOptions(ExpenseType selectedExpenseType) {
  var result = StringBuffer();
  result.write('<option value=' '>&nbsp</option>');
  for (var et in app.expenseTypes.values) {
    if (et == selectedExpenseType) {
      result.write(
          '<option value=\'${et.code}\' selected=\'selected\'>${et.name}</option>');
    } else {
      result.write('<option value=\'${et.code}\'>${et.name}</option>');
    }
  }

  return result.toString();
}

String _getDate(DateTime expenseDate) {
  // date needs to be in a very specific format of yyyy-mm-dd for the
  // html5 date picker to work.
  var dateElementString = '';

  if (expenseDate != null) {
    var year = _blankIfNull(expenseDate.year);
    var month = _getMonth(_blankIfNull(expenseDate.month));
    var day = _getDay(_blankIfNull(expenseDate.day));
    dateElementString =
        '<input type=\'date\' id=\'expenseDate\' value=\'$year-$month-$day\'>';
  } else {
    dateElementString = '<input type=\'date\' id=\'expenseDate\'>';
  }

  return dateElementString;
}

String _getAmount(num amount) {
  return '<input type=\'number\' id=\'expenseAmount\' value=\'${_blankIfNull(amount)}\'>';
}

String _getDetail(String detail) {
  return '<textarea id=\'expenseDetail\'>${_blankIfNull(detail)}</textarea>';
}

Object _blankIfNull(Object o) {
  if (o == null) {
    return '';
  } else {
    return o;
  }
}

/// prefixes with a leading zero if the length is only a single char
String _getDay(day) {
  if (day.toString().length == 1) {
    return '0$day';
  } else {
    return day.toString();
  }
}

/// prefixes with a leading zero if the length is only a single char
String _getMonth(month) {
  if (month.toString().length == 1) {
    return '0$month';
  } else {
    return month.toString();
  }
}