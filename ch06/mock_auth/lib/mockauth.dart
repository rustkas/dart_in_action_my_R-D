library mockauth;

import 'package:mock_auth/src/role_service.dart';

import 'logon.dart';

class MockAuthService implements AuthService {
  @override
  User auth(String username, String password) {
    final user = User();
    user.forename = 'testForename';
    user.surname = 'testSurname';
    return user;
  }
}



class EnterpriseAuthService implements AuthService, RolesService {
  bool _isConnected;
  bool get isConnected => _isConnected;
  set isConnected(bool value) => _isConnected = value;

  @override
  User auth(String username, String password) {
    final user = User();
    user.forename = 'EnterpriseForename';
    user.surname = 'EnterpriseSurname';
    return user;
  }

  @override
  List getRoles(User user) {
    
    throw UnimplementedError();
  }
}
