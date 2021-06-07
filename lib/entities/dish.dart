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
  final Symbol id;
  final Map<Ingredient, Quantity> ingredients;

  Dish({this.ingredients, this.id});

  @override
  Map<MeasurementType, Quantity> get compositionStats =>
      Ingredient.aggregate(ingredients);

}

/// The "Dish" topic on the home page
class DishTopic implements EntityTopic<Dish> {
  final Database db;

  @override
  final Symbol id = #Dish;

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
            builder: (context) => DishCreateScreen(db: db),
          ),
        );
      },
      tooltip: 'Add Dish',
    );
  }

  DishTopic({@required this.entities, @required this.db});

  Widget buildRow(Dish entity, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          child: GestureDetector(
            child: Text(TL8(entity.id)),
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
  final DataCollection<Dish> entities;
}
