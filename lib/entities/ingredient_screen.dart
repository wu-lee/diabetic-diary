import 'package:flutter/material.dart';

import '../database.dart';
import '../translation.dart';
import 'ingredient.dart';

/// The screen for inspecting a ingredient
class IngredientScreen extends StatefulWidget {
  final Ingredient ingredient;
  final Database db;

  const IngredientScreen({Key? key, required this.ingredient, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientState(ingredient, db);
  }
}

class _IngredientState extends State<IngredientScreen> {
  final Ingredient ingredient;
  final Database db;

  _IngredientState(this.ingredient, this.db);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TL8(ingredient.id)), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'FIXME',
          onPressed: () {},
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Composition Stats',
                  textScaleFactor: 2,
                ),
                height: 50,
              ),
              Column(
                // Ingredients
                children: ingredient.compositionStats.entries
                  .map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key.id))),
                          Text('${db.formatQuantity(e.value, #g_per_hg)}'),
                        ],
                      ),
                    ),
                ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
