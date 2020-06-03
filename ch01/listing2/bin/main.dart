class Greeter {
  String greeting;
  String _name;

  String sayHello() {
    return '$greeting ${_name}';
  }

  String get name => _name;
  set name(value) => _name = value;
}

void main() {
  final greeter = Greeter();
  greeter.greeting = 'Hello ';
  greeter.name = 'World';
  print(greeter.sayHello());
}
