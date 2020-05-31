import 'dart:convert';
import 'dart:html';

void main() {
  window.onPopState.listen((data) {
    loadFolderList(data.state);
  });

  navigate('/');
}

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

      final result = jsonDecode(jsonData)  as Map;
      print(result);
      updateFolderList(result['dirs']);
      updateFileList(result['files']);
    });
  }
}

void updateFolderList(List<dynamic> folders) {
  final content = document.getElementById('folderList');
  content.text = '';
  for (var dirName in folders) {
    final link = Element.html('<div><a href="#">$dirName</a></div>');
    link.onClick.listen((_) => navigate(dirName));
    content.nodes.add(link);
  }
}

void updateFileList(List<dynamic> files) {
  final content = document.getElementById('fileList');
  content.text = '';
  for (var filePath in files) {
    final fileName = filePath.substring(filePath.lastIndexOf('\\') + 1);
    final link = Element.html('<div><a href="#">$fileName</a></div>');
    link.onClick.listen((_) {
      document.getElementById('filename').text = 'Current file: $fileName';

      final url = 'http://127.0.0.1:4040/file$filePath';
      HttpRequest.getString(url).then((responce) {
        final jsonData = responce;
        final contentText = jsonDecode(jsonData)['content'];
        document.getElementById('fileContent').text = contentText;
      });
    });
    content.nodes.add(link);
  }
}

// webdev serve
