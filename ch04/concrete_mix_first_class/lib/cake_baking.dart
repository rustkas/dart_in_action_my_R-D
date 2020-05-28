library cake_baking;

import 'src/ingredients.dart';

export 'src/ingredients.dart';
export 'src/tools.dart';

int getTheWeight(List<Ingredient> items, [int bowlWeight = 0, int spoonWeight=0]) {
  var totalWeight = 0;
  items.forEach((item) => totalWeight += item.weight);
  print(bowlWeight);
  print(spoonWeight);
  return totalWeight - bowlWeight - spoonWeight;
}

Ingredient mix(Ingredient item1, Ingredient item2) {
  return item1 + item2;
}

Ingredient weighQty(Ingredient ingredient, int weight) {
  return ingredient * weight;
}

Cake bake(Ingredient ingredientMix) {
  return Cake(ingredientMix);
}

typedef MixFunction = Ingredient Function(Ingredient item1, Ingredient item2);

Ingredient combineIngredients(MixFunction mixFunc, Ingredient item1, Ingredient item2) {
    print('combining $item1 with $item2 using $mixFunc');
    return mixFunc(item1, item2);
}

Ingredient otherCombineIngredients(MixFunction mixFunction, item1, item2) {
  return mixFunction(item1, item2);
}
