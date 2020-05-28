import 'dart:core';
import 'user.dart';

class Permission {
  final String name;
  const Permission(this.name);
}

class ReaderPermission extends Permission {
  const ReaderPermission(String name) : super(name);

  static const ReaderPermission allow_read = ReaderPermission('ALLOW_READ');
  static const ReaderPermission allow_comment =
      ReaderPermission('ALLOW_COMMENT');
  static const ReaderPermission allow_share = ReaderPermission('ALLOW_SHARE');
  
  List<ReaderPermission> extract(User user) {
    return user.permissions.whereType<ReaderPermission>().toList();
  }
}

class AdminPermission extends Permission {
  const AdminPermission(String name) : super(name);

  static const AdminPermission allow_edit = AdminPermission('ALLOW_EDIT');
  static const AdminPermission allow_delete = AdminPermission('ALLOW_DELETE');
  static const AdminPermission allow_create = AdminPermission('ALLOW_CREATE');

  List<AdminPermission> extract(User user) {
    return user.permissions.whereType<AdminPermission>().toList();
  }
}
