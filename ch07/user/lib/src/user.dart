abstract class User {
  String _username;
  
  User(this._username);
  User.byEmail(this._username);

  String get username => _username;
  set username(String value) => _username = value;

  String emailAddress;

  void checkPasswordHistory(String newPassword);

  bool isPasswordValid(String newPassword) {
    //… some validation code …
    checkPasswordHistory(newPassword);
    return true;
  }

  @override
  String toString() {
    var myType = super.toString();
    return '$myType: $username';
  }

}
