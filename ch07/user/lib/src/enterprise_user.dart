import 'user.dart';

class EnterpriseUser extends User {
  @override
  set username(String value) {
    if (value.length < 4) {
      throw ArgumentError('Ошибка: имя пользователя короче 4 знаков');
    }
    super.username = value;
  }

  /// the defalt constructor is only one(!)
  // EnterpriseUser(username) : super(username);
  void markExpired() {
    // some new implementation
  }

  EnterpriseUser(String uname, String email) : super.byEmail(email);
  EnterpriseUser.byUsername(String username) : super(username);

  @override
  bool isPasswordValid(String newPassword) {
  // опущено... сравнение с последними 5 паролями
    return super.isPasswordValid(newPassword);
  }

  @override
  void checkPasswordHistory(String newPassword) {}
}
