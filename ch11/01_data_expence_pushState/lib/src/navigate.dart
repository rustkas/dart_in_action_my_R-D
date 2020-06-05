import 'dart:html';

import 'app.dart';

void navigate(ViewType viewType, int id) {
// store a string representation of the viewType and value
  var state =
      id == null ? '${viewType.name}' : '${viewType.name}/${id.toString()}';
  // store location in browser history
  window.history.pushState(state, '->', '#${state}');

  if (viewType == ViewType.list) {
    app.updateView(app.getListView());
  } else if (viewType == ViewType.edit) {
    app.updateView(app.getEditView(id)); // null passed in becomes an ADD
  }
}

// /// extracts the view by name
// void navigateFromPopstate(String state) {
//   print('State=$state');
//   if (state != null) {
//     final values = state.split('/');
//     print(values.length);
//     final viewName = values[0];
//     final data = (values.length == 2 ? values[1] : null) as int;

//     if (viewName == ViewType.list.name) {
//       navigate(ViewType.list, null);
//     } else if (viewName == ViewType.edit.name) {
//       navigate(ViewType.edit, data);
//     }
//   } else {
//     // default
//     navigate(ViewType.list,null);
//   }
// }
