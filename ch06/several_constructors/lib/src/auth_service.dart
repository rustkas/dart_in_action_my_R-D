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

class EnterpriseAuthService implements AuthService {
  String connection;
  static Map _cache;
  static Map get cache {
    _cache ??= {};

    return _cache;
  }

  EnterpriseAuthService() {
    print('in the constructor');
  }
  EnterpriseAuthService.withConn(String connectionString) {
    print(connectionString);
  }
  factory EnterpriseAuthService.usingServer(String server, int port) {
    var authService = getFromCache(server, port);
    if (authService == null) {
      authService = EnterpriseAuthService();
// опущено: настроить authService и подключиться
      addToCache(authService, server, port);
    }
    return authService;
  }

  static EnterpriseAuthService getFromCache(String server, int port) {
    var key = '$server:$port';
    return cache[key];
  }

  static void addToCache(
      EnterpriseAuthService authService, String server, int port) {
    var key = '$server:$port';
    cache[key] = authService;
  }

  @override
  User auth(String username, String password) {
    throw UnimplementedError();
  }
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
