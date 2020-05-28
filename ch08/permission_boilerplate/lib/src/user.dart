import 'permission.dart';

class User {
  //snip… other properties

  List<Permission> permissions;

  User() {
    permissions= <Permission>[];
  }
}
