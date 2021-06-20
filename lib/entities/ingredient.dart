import 'package:diabetic_diary/database.dart';
import 'package:flutter/foundation.dart';
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
  final Symbol id;

  // Nutritional info per 100g
  final Map<MeasurementType, Quantity> compositionStats;

  const Ingredient({this.id, this.compositionStats});

  static bool _validate(final Map<MeasurementType, Quantity> compositionStats) {
    return compositionStats.entries.any(
            (e) => e.key.units.dims.components.isNotEmpty ||
                e.value.units.dims.components.isNotEmpty
    );
  }

  Ingredient.compose({this.id, Map<Ingredient, Quantity> ingredients}) :
    compositionStats = aggregate(ingredients);

  static Map<MeasurementType, Quantity> aggregate(Map<Ingredient, Quantity> ingredients) {
    final Map<MeasurementType, Quantity> stats = {};
    ingredients.forEach((ingredient, quantityIngredient) {
      assert(mapEquals(quantityIngredient.units.dims.components, {#Mass:1}));
      ingredient.compositionStats.forEach((measurement, quantityMeasurement) {
        assert(measurement.units.dims == quantityMeasurement.units.dims);
        Quantity quantity = stats[measurement] ?? Quantity(0, measurement.units);
        assert(quantityMeasurement.units.dims.components.isEmpty);
        assert(mapEquals(quantityIngredient.units.dims.components, {#Mass:1}));
        stats[measurement] = quantity
            .addQuantity(quantityMeasurement.multiply(quantityIngredient.amount*quantityIngredient.units.multiplier/quantityMeasurement.units.multiplier));
      });
    });
    return Map.unmodifiable(stats);
  }

  static String format(Map<Ingredient, Quantity> ingredients) {
    return "ingredients ${ingredients.entries.map((e) => "${TL8(e.key.id)}: ${e.value.amount} ${TL8(e.value.units.id)}").join("; ")}";
  }
}

/// The "Ingredient" topic on the home page
class IngredientTopic implements EntityTopic<Ingredient> {
  final Database db;

  @override
  final Symbol id = #Ingredient;

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
            builder: (context) => IngredientCreateScreen(
              db: db,
            ),
          ),
        );
      },
      tooltip: 'Add Ingredient',
    );
  }

  IngredientTopic({@required this.entities, @required this.db});

  Widget buildRow(Ingredient entity, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child:
          GestureDetector(
            child: Text(TL8(entity.id)),
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
  Widget buildTabContent(BuildContext context) {
    final ingredients = entities.getAll().values.toList();
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: ingredients.length,
      itemBuilder: (context, ix) {
        return buildRow(ingredients[ix], context);
      }
  );
  }

  @override
  final DataCollection<Ingredient> entities;
}