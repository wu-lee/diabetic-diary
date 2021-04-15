import 'measurement_type.dart';
import 'unit.dart';

import 'indexable.dart';

/** Cheddar:
 * 60g fat
 * 0g carbohydrate
 * 10g protein
 * 1g salt
 *
 */
class Ingredient implements Indexable {
  final Symbol name;

  // Nutritional info per 100g
  final Map<MeasurementType, Quantity> compositionStats;

  const Ingredient({this.name, this.compositionStats});

  Ingredient.compose({this.name, Map<Ingredient, Quantity> ingredients}) :
    compositionStats = _aggregate(ingredients);

  static Map<MeasurementType, Quantity> _aggregate(Map<Ingredient, Quantity> ingredients) {
    final result = ingredients.entries.fold({},
            (map, entry) {
              entry.key.compositionStats.entries.forEach((entry2) {
                map[entry2.key] += entry2.value;
              });
              return map;
            }
    );
    return Map.unmodifiable(result);
  }
}


/**
 * Nick salad:
 * 30g tahini
 * 120g cabbage
 *
 */
class Dish implements Ingredient {
  final Symbol name;
  final Map<Ingredient, Quantity> ingredients;

  Dish({this.ingredients, this.name}) ;

  @override
  Map<MeasurementType, Quantity> get compositionStats =>
    Ingredient._aggregate(ingredients);
}
