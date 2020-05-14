library using_fields;

class MyClass {
  int _a;
  int _b;

  int get a => _a;
  set a(int value) => _a = value;
  int get b => _b;
  set b(int value) => _b = value;

@override
String toString(){
    return '{$a:$b}';
  }
}
