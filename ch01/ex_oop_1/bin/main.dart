import 'package:ex_oop_1/coords.dart';

void main() {
  var coords1 = Coords.xyz();
  print('$coords1. Расстояние: ${coords1.getDistance()}');

  var coords2 = Coords.xyz(1,1,1);
  print('$coords2. Расстояние: ${coords2.getDistance()}');

  coords1.x=5;
  coords1.y=0;
  coords1.z=2.5;

  print('$coords1. Расстояние: ${coords1.getDistance()}');

  coords2.y = -4.3;
  print('$coords2. Расстояние: ${coords2.getDistance()}');
}
