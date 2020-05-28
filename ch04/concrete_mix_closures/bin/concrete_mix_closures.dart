import 'package:concrete_mix_closures/cake_baking.dart';

void main() {
  var sugar = Sugar();

  Ingredient mix(item2) {
    return sugar + item2;
  }

  var marge = Margarine();
  // var buttercream = mix(marge);
  var buttercream = combineIngredients(mix, marge);
  print(buttercream);

  List unmix() {
    return [sugar, marge];
  }

  separateIngredients(unmix);
}
