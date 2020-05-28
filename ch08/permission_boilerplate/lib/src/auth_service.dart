import 'permission.dart';

import 'user.dart';

class AuthService {
  //snip… other methods

  User login(username, password) {
    final user = User();
    //snip … logon code

    user.permissions.add(ReaderPermission.allow_read);
    user.permissions.add(AdminPermission.allow_edit);
    return user;
  }
}
