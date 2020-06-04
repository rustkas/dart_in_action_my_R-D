import 'dart:html';

import 'app.dart';

void navigate(ViewType view,
    [Object value, String flashMessage, bool fromBrowserHistory = false]) {
  final valueAsString =
      value == null ? '${view.name}' : '${view.name}/${value.toString()}';

  if (fromBrowserHistory == false) {
    // store location in browser history
    window.history.pushState(valueAsString, valueAsString, '#${valueAsString}');
  }

  // store current location in cookie
  document.cookie = 'locationCookie=$valueAsString';

  document.title = 'DartExpense: $valueAsString';

  if (view == ViewType.list) {
    print('Navigate: List');
    app.updateView(app.getListView());
  } else if (view == ViewType.edit) {
    print('Navigate: Edit');
    app.updateView(app.getEditView(value)); // null passed in becomes an ADD
  }
}

/// extracts the view by name
void navigateFromPopstate(String state) {
  print('State=$state');
  if (state != null) {
    final values = state.split('/');
    print(values.length);
    final viewName = values[0];
    final data = values.length == 2 ? values[1] : null;

    if (viewName == ViewType.list.name) {
      navigate(ViewType.list, null, null, true);
    } else if (viewName == ViewType.edit.name) {
      navigate(ViewType.edit, data, null, true);
    }
  } else {
    // default
    navigate(ViewType.list);
  }
}
