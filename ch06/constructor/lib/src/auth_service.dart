class User {
  String forename;
  String surname;

  String getFullName() {
    return '$forename $surname';
  }
}

abstract class AuthService {
  User auth(String username, String password);

  factory AuthService() {
    return EnterpriseAuthService();
  }
}

class EnterpriseAuthService implements AuthService{
  String connection;

  EnterpriseAuthService() {
    print('in the constructor');
  }

  @override
  User auth(String username, String password) {
     throw UnimplementedError();
  }
}
