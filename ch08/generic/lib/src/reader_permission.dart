import 'permission.dart';

class ReaderPermission extends Permission {

  const ReaderPermission(String name) : super(name);

  static const ReaderPermission allow_read =
                        ReaderPermission('ALLOW_READ');
  static const ReaderPermission allow_comment =
                          ReaderPermission('ALLOW_COMMENT');
  static const ReaderPermission allow_share =
                          ReaderPermission('ALLOW_SHARE');
}
