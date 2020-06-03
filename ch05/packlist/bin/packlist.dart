import 'package:packlist/packlist.dart' as packlist;
import 'package:loglib/loglib.dart' as loglib;

void main() {
  print('Hello world: ${packlist.calculate()}!');
  loglib.info('hello');
  EnterpriseAuthService.withConn('test');
  var errorA = const AuthError('Сервер не отвечает', 1);
  var errorB = const AuthError('Сервер не отвечает', 1);
  print(errorA == errorB);
}

class AuthError {
  final prefix = 'Error: ';
  final String _message;
  final int _code;
  const AuthError(String message, int code)
      : _message = message,
        _code = code;

  String get errorMessage => '$prefix [$_code] $_message';
}

class User {
  String username;
  String password;
  User(this.username, this.password);
}

abstract class AuthService {
  User auth(String username, String password);
  factory AuthService() {
    return EnterpriseAuthService();
  }
}

class EnterpriseAuthService implements AuthService {
  static Map _cashe;
  static Map get cashe {
    _cashe ??= {};
    return _cashe;
  }

  String connection;
  EnterpriseAuthService() {
    print('in constructor');
  }

  EnterpriseAuthService.withConn(String connection) {
    // use supplies a connection string
  }
  factory EnterpriseAuthService.usingServer(String server, int port) {
    var authService = getFromCashe(server, port);
    if (null == authService) {
      authService = EnterpriseAuthService();
      // set up authService
      addToCashe(authService, server, port);
    }
    return EnterpriseAuthService();
  }
  @override
  User auth(String username, String password) {
    return User(username, password);
  }

  static EnterpriseAuthService getFromCashe(String server, int port) {
    var key = '$server:$port';
    return cashe[key];
  }

  static void addToCashe(
      EnterpriseAuthService authService, String server, int port) {
    var key = '$server:$port';
    cashe[key] = authService;
  }
}
