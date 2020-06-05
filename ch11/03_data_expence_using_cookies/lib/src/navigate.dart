import 'dart:html';

import 'app.dart';
import 'ui_edit.dart';
import 'ui_list.dart';

void navigate(ViewType viewType, int id, [bool fromPopState = false]) {
  print(viewType);
  // store a string representation of the viewType and value
  var state =
      id == null ? '${viewType.name}' : '${viewType.name}/${id.toString()}';
  // store location in browser history
  if (fromPopState == false) {
    // the navigate request did not come from the browser history,
    // so store new location in browser history
    window.history.pushState(state, null, '#$state');
    print('STATE = $state');
  }
  if (viewType == ViewType.list) {
    print('Navigate: List');
    app.updateView(ListView(app.expenses));
  } else if (viewType == ViewType.edit) {
    print('Navigate: Edit');
    app.updateView(EditView(app.getExpenseById(id)));
  }
}
