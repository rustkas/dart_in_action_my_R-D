import 'package:ex_oop_ex3/greeting1.dart' as greeting1;

void main() {
  final welcomer = greeting1.Welcomer('Tom');
  welcomer.name = 'John';
  greeting1.sayHello(welcomer);

  final greeter = greeting1.Greeter('Tom');
  greeting1.sayHello(greeter);
}
