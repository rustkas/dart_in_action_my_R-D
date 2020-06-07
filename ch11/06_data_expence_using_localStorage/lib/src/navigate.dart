import 'dart:html';

import 'app.dart';
import 'models.dart';
import 'ui_edit.dart';
import 'ui_list.dart';

void navigate(ViewType viewType, int id, [bool fromPopState = false]) {
  // store a string representation of the viewType and value
  var state =
      id == null ? '${viewType.name}' : '${viewType.name}/${id.toString()}';

  _pushState(fromPopState, state);

  //saving cooking informaton 1 month {seconds*minutes*hours*days*weeks}
  document.cookie = 'stateData=$state;max-age=${60 * 60 * 24 * 7 * 4}';
  //print(document.cookie);
  if (viewType == ViewType.list) {
    print('Navigate: List');
    app.updateView(ListView(app.expenses));
  } else if (viewType == ViewType.edit) {
    print('Navigate: Edit');
    if (null == id) {
      app.updateView(EditView(Expense()));
    } else {
      app.updateView(EditView(app.getExpenseById(id))); 
    }
  }
}

/// Store location in browser history
void _pushState(bool fromPopState, String state) {
  // store location in browser history
  if (fromPopState == false) {
    // the navigate request did not come from the browser history,
    // so store new location in browser history
    window.history.pushState(state, null, '#$state');
    // print('STATE = $state');
  }
}
