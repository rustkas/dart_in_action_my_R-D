import 'package:concrete_mix_first_class/cake_baking.dart';

void main() {
  Function mix2() {
    return mix2;
  }

  //print(mix2 is Object);
  print(mix2 is Function);
  print(mix2() is Function);

  final eggs = [Egg(), Egg()];
  final eggWeight = getTheWeight(eggs, 30);
  print(eggWeight);
  final beatenEggs = combineIngredients(mix, eggs[0], eggs[1]);

  final weighedSugar = weighQty(Sugar(), eggWeight);
  print(weighedSugar);
  final weighedMarge = weighQty(Margarine(), eggWeight);
  print(weighedMarge);
  final weighedFlour = weighQty(Flour(), eggWeight);
  print(weighedFlour);

  final buttercream = mix(weighedSugar, weighedMarge);
  print(buttercream);
  final eggyMix = mix(buttercream, beatenEggs);
  print(eggyMix);
  final cakeMix = mix(eggyMix, weighedFlour);
  print(cakeMix);

  var cake = bake(cakeMix);
  print(cake);
}
