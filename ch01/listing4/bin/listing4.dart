abstract class IGreetable {
  String sayHello(String name);

  factory IGreetable() {
    return Greeter();
  }
}

class Greeter implements IGreetable {
  @override
  String sayHello(String name) {
    return 'Hello $name';
  }
}

void main() {
  var myGreetable = IGreetable();
  var message = myGreetable.sayHello('Dart');
  print(message);
}
