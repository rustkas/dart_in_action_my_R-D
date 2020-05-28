import 'package:permissions/permisions.dart';

void main() {
  var adminRole = Role.timesheet_admin;
  var reporterRole = Role.timesheet_reporter;
  var userRole = Role.timesheet_user;
  if (adminRole.accessLevel > reporterRole.accessLevel) {
    print('Роль Admin больше, чем роль Reporter');
  }

  if (userRole.accessLevel < adminRole.accessLevel) {
    print('Роль User меньше, чем роль Admin');
  }
  if (adminRole > reporterRole) {
    print('Роль Admin больше, чем роль Reporter');
  }
  if (userRole < adminRole) {
    print('Роль User меньше, чем роль Admin');
  }
}
