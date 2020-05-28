class User {
  String forename;
  String surname;

  String getFullName() {
    return '$forename $surname';
  }
}

abstract class AuthService {
  User auth(String username, String password);
}

User doLogon(AuthService authSvc, String username, String password) {
  final user = authSvc.auth(username, password);
  print('User is authenticated:${user==null}');
  return user;
}
