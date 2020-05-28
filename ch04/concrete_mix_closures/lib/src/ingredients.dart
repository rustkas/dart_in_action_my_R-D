class Ingredient {
  num weight;

  String get name => super.toString().substring(12);

  Ingredient operator +(Ingredient other) {
    return MixedIngredient(name, other.name);
  }

  Ingredient operator *(num multiplier) {
    weight = weight * multiplier;
    return this;
  }

  @override
  String toString() => '${super.toString().substring(12)}';
}

class MixedIngredient extends Ingredient {
  String mixtureOf;

  MixedIngredient(item1, item2) {
    mixtureOf = '$item1 and $item2';
  }
  @override
  String toString() => '${super.toString()} containing: $mixtureOf';
}

class Sugar extends Ingredient {
  Sugar() {
    weight = 1;
  }
}

class Margarine extends Ingredient {
  Margarine() {
    weight = 1;
  }
}

class Flour extends Ingredient {
  Flour() {
    weight = 1;
  }
}

class Egg extends Ingredient {
  Egg() {
    weight = 60; // 60g
  }
}

class Cake extends Ingredient {
  Cake(mixture);
}
