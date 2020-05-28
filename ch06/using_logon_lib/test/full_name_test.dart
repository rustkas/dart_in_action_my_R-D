import 'package:test/test.dart';
import 'package:using_logon_lib/logon.dart';

void main() {
  test('getFullName', () {
    final user = User();
    user.forename = 'Alice';
    user.surname = 'Smith';
    var fullName = user.getFullName();
    expect(fullName, equals('Alice Smith'));
  });
}
