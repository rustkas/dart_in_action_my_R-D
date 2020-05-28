library cake_baking;
import 'src/ingredients.dart';

export 'src/ingredients.dart';

int getTheWeight(List<Ingredient> items, [int bowlWeight = 0, int spoonWeight=0]) {
  var totalWeight = 0;
  items.forEach((item) => totalWeight += item.weight);
  print(bowlWeight);
  print(spoonWeight);
  return totalWeight - bowlWeight - spoonWeight;
}

Ingredient weighQty(Ingredient ingredient, int weight) {
  return ingredient * weight;
}

Cake bake(Ingredient ingredientMix) {
  return Cake(ingredientMix);
}

Ingredient combineIngredients(mix, item2) {
  return mix(item2);
}

void separateIngredients(unmix) {
  var items = unmix();
  var sugar = items[0];
  var marge = items[1];
  print(sugar);
  print(marge);
}
