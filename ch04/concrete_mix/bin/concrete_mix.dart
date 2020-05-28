import 'package:concrete_mix/concrete_mix.dart';
void main() {
  Ingredient cement = Cement();
  print(cement.bags);

  final sand = calculateQty(Sand(), cement.bags, 2);
  print(sand);
  final gravel = calculateQty(Gravel(), cement.bags, 3);
  print(gravel);

  final mortar = mix(cement, sand);
  print(mortar);
  final dryConcrete = mix(mortar, gravel);

  final wetConcrete = ConcreteMix(dryConcrete, Water());

  lay(wetConcrete);
}
