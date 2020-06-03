import 'package:ex_oop_2/using_static.dart';
import 'package:ex_oop_2/using_fields.dart';
void main() {
  UsingStatic.meth(123);

  var item1 = MyClass();
  item1.a = 2;
  item1.b = 3;

  print('$item1');
}
