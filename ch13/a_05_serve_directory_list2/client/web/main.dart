import 'dart:html';

import 'package:client/client.dart';

void main() {
  window.onPopState.listen((data) {
    loadFolderList(data.state);
  });

  navigate('/');
  addSaveOnClickListener();
  addFileContentMakeChangesListener();
}

// webdev serve
