import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../database.dart';
import '../dish.dart';
import '../entity_topic.dart';
import '../translation.dart';
import 'dish_edit_screen.dart';
import 'dish_screen.dart';

class DishTopic implements EntityTopic<Dish> {
  final Database db;

  @override
  final Symbol id = #Dishes;

  @override
  final IconData icon = Icons.shopping_cart;

  DishTopic({required this.entities, required this.db});

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DishEditScreen(
              db: db,
            ),
          ),
        );
      },
      tooltip: 'Add Ingredient',
    );
  }

  Widget buildRow(Dish entity, BuildContext context, int ix) {
    return  GestureDetector(
      child: Container(
        color: (ix % 2 == 0) ? Colors.lightBlueAccent : Colors.lightBlue,
//        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Text(TL8(entity.id)),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DishScreen(dish: entity, db: db),
          ),
        );
      },
    );
  }

  @override
  Widget buildTabContent(BuildContext context) {
    return FutureBuilder<Map<Symbol, Dish>>(
      future: entities.getAll(),
      builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Dish>> snapshot) {
        final ingredients = snapshot.data?.values.toList() ?? [];
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: ingredients.length,
          itemBuilder: (context, ix) {
            return buildRow(ingredients[ix], context, ix);
          },
        );
      },
    );
  }

  @override
  final AsyncDataCollection<Dish> entities;
}