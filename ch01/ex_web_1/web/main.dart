import 'dart:html';

void main() {
  //querySelector('#output').text = 'Your Dart app is running.';
  var button = ButtonElement();
  button.text = 'Нажми';
  button.onClick.listen((event) {
    List buttonList = querySelectorAll('button');
    window.alert('Количество кнопок на странице = ${buttonList.length}');
  });
  document.body.children.add(button);
}
