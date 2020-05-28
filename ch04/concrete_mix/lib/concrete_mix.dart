library concrete_mix;

import 'src/ingredients.dart';

export 'src/ingredients.dart';

dynamic mix(Ingredient item1, Ingredient item2) {
  return item1 + item2;
}

Ingredient measureQty(
    Ingredient ingredient, int numberOfCementBags, int proportion) {
  return ingredient * (numberOfCementBags * proportion);
}

Ingredient calculateQty(Ingredient ingredient, int bags, int quantity) {
  return ingredient * (bags * quantity);
}

void lay(ConcreteMix concreteMix) {}
