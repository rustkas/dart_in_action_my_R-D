import 'dart:convert';
import 'dart:html';

void navigate(String folderName) {
  print('Loading Folder: $folderName');

  loadFolderList(folderName);
  window.history.pushState(folderName, folderName, '#$folderName');
}

void loadFolderList(String folderName) {
  if (folderName != null) {
    folderName = folderName.replaceAll('\\', r'\');

    document.getElementById('currentFolder').innerHtml =
        'Current Folder: $folderName';
    var url = 'http://127.0.0.1:4040/folder$folderName';

    HttpRequest.getString(url).then((responce) {
      final jsonData = responce;

      final result = jsonDecode(jsonData) as Map;
      _updateFolderList(result['dirs']);
      _updateFileList(result['files']);
    }).catchError((e) {
      print('Got error: ${e}');

      return Future.value(null);
    });

    // clean file content
    TextAreaElement fileContent = document.getElementById('fileContent');
    fileContent.value = '';

    ButtonElement saveButton = document.getElementById('saveButton');
    saveButton.disabled = true;
  }
}

void _updateFolderList(List folders) {
  if (folders.isEmpty) {
    return;
  }
  final content = document.getElementById('folderList');
  content.text = '';
  for (var dirName in folders) {
    final link = Element.html('<div><a href="#">$dirName</a></div>');

    link.onClick.listen((_) => navigate(dirName));
    content.nodes.add(link);
  }
}

void _updateFileList(List files) {
  final content = document.getElementById('fileList');
  content.text = '';
  for (var filePath in files) {
    final fileName = filePath.substring(filePath.lastIndexOf('\\') + 1);
    final link = Element.html('<div><a href="#">$fileName</a></div>');
    link.onClick.listen((_) {
      for (var item in content.children) {
        item.classes.forEach((element) {
          if (element == 'selected') {
            item.classes.remove(element);
          }
        });
        link.classes.add('selected');
      }
      document.getElementById('filename').text = '$fileName';

      final url = 'http://127.0.0.1:4040/file$filePath';
      HttpRequest.getString(url).then((responce) {
        final jsonData = responce;
        contentText = jsonDecode(jsonData)['content'];
        TextAreaElement fileContent = document.getElementById('fileContent');
        fileContent.value = contentText;
      }).catchError((e) {
        print('Got error: ${e.error}');
        return -1;
      });
    });
    content.nodes.add(link);
  }
}

var contentText;
void addSaveOnClickListener() {
  final saveButton = document.getElementById('saveButton');
  saveButton.onClick.listen((event) {
    final filePath = document.getElementById('filename').text;
    if (filePath.isEmpty) {
      return;
    }
    final fileContent =
        (document.getElementById('fileContent') as TextAreaElement).value;
    final url = 'http://127.0.0.1:4040/file$filePath';

    // Data content map
    final data = <String, String>{'fileContent': fileContent};

    //Header settings
    final requestHeaders = <String, String>{
      'Content-Type': 'text/plain; charset=UTF-8'
    };

    // Send POST request
    HttpRequest.request(url,
            method: 'POST',
            withCredentials: false,
            responseType: 'text',
            requestHeaders: requestHeaders,
            sendData: data,
            onProgress: null)
        .then((request) {
      // set default GUI settings
      // to privent file content editiing
      try {
        if ((request.response as String).toLowerCase() == 'ok') {
          ButtonElement saveButton = document.getElementById('saveButton');
          saveButton.disabled = true;
        }
      } catch (e) {
        print(e);
      }
    });
  });
}

void addFileContentMakeChangesListener() {
  TextAreaElement fileContent = document.getElementById('fileContent');
  fileContent.onInput.listen((Event event) {
    if (contentText != fileContent.text) {
      ButtonElement saveButton = document.getElementById('saveButton');
      saveButton.disabled = false;
    }
  });
}
