import 'dart:html';

void main() {
  final button = ButtonElement();
  button.text = 'Нажми';
  button.onClick.listen((event) {
    List buttonList = querySelectorAll('button');
    window.alert('Количество кнопок на странице = ${buttonList.length}');
  });
  document.body.children.add(button);
}
