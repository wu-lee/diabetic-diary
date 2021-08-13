import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../database.dart';
import '../edible.dart';
import '../entity_topic.dart';
import '../translation.dart';
import 'edible_edit_screen.dart';
import 'edible_screen.dart';

class EdibleTopic implements EntityTopic<Edible> {
  final Database db;

  @override
  final Symbol id = #Ingredient;

  @override
  final IconData icon = Icons.shopping_cart;

  EdibleTopic({required this.entities, required this.db});

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EdibleEditScreen(
              db: db,
            ),
          ),
        );
      },
      tooltip: 'Add Ingredient',
    );
  }

  Widget buildRow(Edible entity, BuildContext context) {
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
                  builder: (context) => EdibleScreen(edible: entity, db: db),
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
    return FutureBuilder<Map<Symbol, Edible>>(
      future: entities.getAll(),
      builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Edible>> snapshot) {
        final ingredients = snapshot.data?.values.toList() ?? [];
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: ingredients.length,
          itemBuilder: (context, ix) {
            return buildRow(ingredients[ix], context);
          },
        );
      },
    );
  }

  @override
  final AsyncDataCollection<Edible> entities;
}