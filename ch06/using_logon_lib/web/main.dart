import 'dart:html';
import 'package:using_logon_lib/logon.dart';

void main() {
  build_gui();
}

void build_gui() {
  final childNodes = document.body.nodes;
  final username = InputElement();
  username.id = 'username';
  final password = InputElement();
  password.id = 'password';
  final button = ButtonElement();
  button.text = 'ok';
  final label = LabelElement();
  label.text = 'Please, log in';
  label.id = 'status';
  button.onClick.listen(buttonClickHandler);
  childNodes.addAll([
    wrapToDiv(username),
    wrapToDiv(password),
    wrapToDiv(button),
    wrapToDiv(label)
  ]);
}

//webdev serve
/// Wrap element to div tag.
/// return div tag with wrapped element.
DivElement wrapToDiv(Element element) {
  final div = DivElement();
  div.nodes.add(element);
  return div;
}

User doLogon(AuthService authSvc, String username, String password) {
  final user = authSvc.auth(username, password);
  print('User is authenticated:${user == null}');
  return user;
}

void buttonClickHandler(event) {
  final authSvc = AuthService();
  final user = doLogon(
      authSvc,
      (document.getElementById('username') as InputElement).value,
      (document.getElementById('password') as InputElement).value);
  document.getElementById('status').text = user.getFullName();
}
