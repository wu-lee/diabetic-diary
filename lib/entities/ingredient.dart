import 'package:flutter/material.dart';

import '../entity_topic.dart';
import '../home_page.dart';
import '../measurement_type.dart';
import '../translation.dart';
import '../unit.dart';

import '../indexable.dart';
import 'ingredient_create_screen.dart';
import 'ingredient_screen.dart';

class Ingredient implements Indexable {
  final Symbol name;

  // Nutritional info per 100g
  final Map<MeasurementType, Quantity> compositionStats;

  const Ingredient({this.name, this.compositionStats});

  Ingredient.compose({this.name, Map<Ingredient, Quantity> ingredients}) :
    compositionStats = aggregate(ingredients.entries);

  static Map<MeasurementType, Quantity> aggregate(Iterable<MapEntry<Ingredient, Quantity>> ingredients) {
    final result = ingredients.fold({},
            (map, entry) {
              entry.key.compositionStats.entries.forEach((entry2) {
                map[entry2.key] = map.containsKey(entry2.key)? map[entry2.key] + entry2.value : entry2.value;
              });
              return map;
            }
    );
    return Map.unmodifiable(result);
  }
}

/// The "Ingredient" topic on the home page
class IngredientTopic implements EntityTopic<Ingredient> {
  @override
  final Symbol name = #Ingredient;

  @override
  final IconData icon = Icons.shopping_cart;

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngredientCreateScreen(),
          ),
        ).then((_) { updateEntities(db.ingredients.getAll().values); });
      },
      tooltip: 'Add Ingredient',
    );
  }

  @override
  final List<Ingredient> entities;

  IngredientTopic({this.entities});

  void updateEntities(Iterable<Ingredient> newEntities) {
    entities..clear()..addAll(newEntities);
  }

  Widget buildRow(Ingredient entity, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child:
          GestureDetector(
            child: Text(TL8(entity.name)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IngredientScreen(ingredient: entity),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTabContent(BuildContext context) => ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: entities.length,
      itemBuilder: (context, ix) {
        return buildRow(entities[ix], context);
      }
  );
}