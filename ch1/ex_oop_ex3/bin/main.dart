import 'package:ex_oop_ex3/greeting1.dart' as greeting1;
void main(List<String> arguments) {
 var welcomer = greeting1.Welcomer('Tom');

 greeting1.sayHello(welcomer);

 var greeter = greeting1.Greeter('Tom');
 greeting1.sayHello(greeter);
}
