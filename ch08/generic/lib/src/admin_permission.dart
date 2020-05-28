import 'permission.dart';

class AdminPermission extends Permission {

  const AdminPermission(String name) : super(name);

  static const AdminPermission allow_edit =
                          AdminPermission('ALLOW_EDIT');
  static const AdminPermission allow_delete =
                          AdminPermission('ALLOW_DELETE');
  static const AdminPermission allow_create =
                          AdminPermission('ALLOW_CREATE');
}
