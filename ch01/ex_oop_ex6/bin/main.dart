import 'package:ex_oop_ex6/my_library.dart' as my;
import 'package:ex_oop_ex6/my_other_library.dart' as my_other;

void main() {
  final greeting1 = () {
    final g = my.Greeter();
    final string = g.toString();
    final result = my.sayHello(string);
    return result;
  }();

  print(greeting1);

  final g2 = my_other.Greeter();
  //print(g);
  print(my_other.sayHello(g2.toString()));
}
