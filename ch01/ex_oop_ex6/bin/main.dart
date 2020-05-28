import 'package:ex_oop_ex6/my_library.dart' as my;
import 'package:ex_oop_ex6/my_other_library.dart' as my_other;

void main(List<String> arguments) {
  var greeting1 = () {
    var g = my.Greeter();
    var string = g.toString();
    var result = my.sayHello(string);
    return result;
  }();
  
  print(greeting1);
  

var g2 = my_other.Greeter();
  //print(g);
  print(my_other.sayHello(g2.toString()));

}
