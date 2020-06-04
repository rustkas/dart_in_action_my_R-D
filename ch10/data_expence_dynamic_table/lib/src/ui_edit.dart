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
      </div>
          ''');
  }

  void _buildActions() {
    actions = DivElement();
    actions.children.add(_getSaveButton());
    actions.children.add(_getCancelButton());
  }

  Element _getSaveButton() {
    final saveButton = ButtonElement();
    saveButton
      ..text = 'Save'
      ..onClick.listen((e) {
        // read the values from the form back to the object
        // uses expense object in the function local scope
        _saveDetails(_expense);
        navigate(ViewType.list, null, 'Expense was saved');
      });

    return saveButton;
  }

  Element _getCancelButton() {
    final cancelButton = ButtonElement();
    cancelButton
      ..text = 'Cancel'
      ..onClick.listen((e) => navigate(ViewType.list));
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
  final result = StringBuffer();
  result.write('<option value=' '>&nbsp</option>');
  for (var et in app.expenseTypes.values) {
    if (et == selectedExpenseType) {
      result.write(
          "<option value='${et.code}' selected='selected'>${et.name}</option>");
    } else {
      result.write("<option value='${et.code}'>${et.name}</option>");
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
        "<input type='date' id='expenseDate' value='$year-$month-$day'>";
  } else {
    dateElementString = "<input type='date' id='expenseDate'>";
  }

  return dateElementString;
}

String _getAmount(num amount) {
  return "<input type='number' id='expenseAmount' value='${_blankIfNull(amount)}'>";
}

String _getDetail(String detail) {
  return "<textarea id='expenseDetail'>${_blankIfNull(detail)}</textarea>";
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
