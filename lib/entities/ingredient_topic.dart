import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../database.dart';
import '../basic_ingredient.dart';
import '../entity_topic.dart';
import '../translation.dart';
import 'ingredient_edit_screen.dart';
import 'ingredient_screen.dart';

class IngredientTopic implements EntityTopic<BasicIngredient> {
  final Database db;

  @override
  final Symbol id = #Ingredients;

  @override
  final IconData icon = Icons.shopping_cart;

  IngredientTopic({required this.entities, required this.db});

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngredientEditScreen(
              db: db,
            ),
          ),
        );
      },
      tooltip: 'Add Ingredient',
    );
  }

  Widget buildRow(BasicIngredient entity, BuildContext context, int ix) {
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
            builder: (context) => IngredientScreen(ingredient: entity, db: db),
          ),
        );
      },
    );
  }

  @override
  Widget buildTabContent(BuildContext context, StateSetter setBuilderState) {
    return FutureBuilder<Map<Symbol, BasicIngredient>>(
      future: entities.getAll(),
      builder: (BuildContext context, AsyncSnapshot<Map<Symbol, BasicIngredient>> snapshot) {
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
  final AsyncDataCollection<BasicIngredient> entities;
}