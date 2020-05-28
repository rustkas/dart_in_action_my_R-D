import 'package:permissions/permisions.dart';

void main() {
  usingGeneric();
}

void usingGeneric() {
  var permissionUser = User<Permission>();
  print('$permissionUser. ${permissionUser.getCredentialsList()}');

  var roleUser = User<Role>();
  roleUser + Role.timesheet_admin;
  //roleUser.addCredential(Role.timesheet_admin);
  print('$roleUser. ${roleUser.getCredentialsList()}');

  var stringUser = User<String>();
  // stringUser.addCredential('ACCESS_ALL_AREAS');
  stringUser + 'ACCESS_ALL_AREAS';
  print('$stringUser. ${stringUser.getCredentialsList()}');
  var intUser = User<int>();
  // intUser.addCredential(999);
  intUser + 999;
  print('$intUser. ${intUser.getCredentialsList()}');
}
