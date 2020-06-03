class Welcomer {
  void printGreeting() => print('Hello $name');
  var name;
}

class Greeter implements Welcomer {
  @override
  void printGreeting() => print('Greeting $name');

  @override
  var name;
}

void sayHello(Welcomer welcomer) => welcomer.printGreeting();

void main() {
  final welcomer = Welcomer();
  welcomer.name = 'Tom';
  sayHello(welcomer);

  final greeter = Greeter();
  greeter.name = 'Tom';
  sayHello(greeter);
}
