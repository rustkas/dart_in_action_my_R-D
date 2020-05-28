library greeting1;

class Welcomer  {
  String name;

  void printGreeting() => print('Hello $name');
    
  Welcomer(String name) {
    this.name = name;
  }
  
}

class Greeter implements Welcomer {
  String name;

  Greeter(String name) {
    this.name = name;
  }
  
  @override
  void printGreeting () => print('Greetings $name');
  
}

void sayHello(Welcomer welcomer) {
  welcomer.printGreeting();
}