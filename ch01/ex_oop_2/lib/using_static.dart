library using_static;

class UsingStatic {
  static int a= 3;
  static int b;

  static void meth(int x){
    print('x = $x');
    print('a = $a');
    print('b = $b');
  }
}