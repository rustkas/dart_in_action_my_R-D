import 'package:several_constructors/logon.dart';

void main() {
  final authSvc1 = EnterpriseAuthService();
  final authSvc2 = EnterpriseAuthService.withConn('connection string');
  final finalauthSvc2 = EnterpriseAuthService.usingServer('localhost', 8080);

  print(authSvc1);
  print(authSvc2);
  print(finalauthSvc2);
}
