import 'package:flutter/material.dart';

import '../database.dart';
import '../entity_topic.dart';
import '../home_page.dart';
import '../indexable.dart';
import 'dish_create_screen.dart';
import 'ingredient.dart';
import '../measurement_type.dart';
import '../translation.dart';
import '../unit.dart';
import 'dish_screen.dart';

/// Represents the "Dish" entity
class Dish implements Ingredient {
  final Symbol name;
  final Map<Ingredient, Quantity> ingredients;

  Dish({this.ingredients, this.name});

  @override
  Map<MeasurementType, Quantity> get compositionStats =>
      Ingredient.aggregate(ingredients.entries);
}

/// The "Dish" topic on the home page
class DishTopic implements EntityTopic<Dish> {
  @override
  final Symbol name = #Dish;

  @override
  final IconData icon = Icons.restaurant;

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DishCreateScreen(dishes: entities, ingredients: ingredients),
          ),
        );
      },
      tooltip: 'Add Dish',
    );
  }

  DishTopic({@required this.entities, @required this.ingredients});

  Widget buildRow(Dish entity, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child: GestureDetector(
            child: Text(TL8(entity.name)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DishScreen(dish: entity),
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
    final dishes = entities.getAll().values.toList();
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: dishes.length,
      itemBuilder: (context, ix) {
        return buildRow(dishes[ix], context);
      }
    );
  }

  @override
  final DataCollection<Symbol, Dish> entities;

  final DataCollection<Symbol, Ingredient> ingredients;
}
