import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../basic_ingredient.dart';
import '../quantity.dart';
import '../translation.dart';
import 'ingredient_edit_screen.dart';

/// The screen for inspecting an Ingredient
class IngredientScreen extends StatefulWidget {
  final BasicIngredient ingredient;
  final Database db;

  const IngredientScreen({Key? key, required this.ingredient, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientState(ingredient, db);
  }
}

class _IngredientState extends State<IngredientScreen> {
  BasicIngredient _ingredient;
  final Database db;

  Future<Map<Symbol, String>> _compositionStats = Future.value({});
  Future<Map<Symbol, String>> _contentAmounts = Future.value({});

  BasicIngredient get ingredient => _ingredient;
  set ingredient(BasicIngredient e) {
    _ingredient = e;
    _contentAmounts = _format(ingredient.contents);
    _compositionStats = db.aggregate(ingredient.contents, 1).then(_format);
  }

  _IngredientState(BasicIngredient ingredient, this.db) :
        this._ingredient = ingredient
  {
    _contentAmounts = _format(ingredient.contents);
    _compositionStats = db.aggregate(ingredient.contents, 1).then(_format);
  }

  Future<Map<Symbol, String>> _format(Map<Symbol, Quantity> entities) async {
    // Format the quantities into strings
    final Map<Symbol, String> result = {};
    for(final entry in entities.entries) {
      result[entry.key] = entry.value.format();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ingredient.label), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: TL8(#Edit),
          onPressed: () async {
            final BasicIngredient? newIngredient = await Navigator.push<BasicIngredient>(
              context,
              MaterialPageRoute(
                builder: (context) => IngredientEditScreen(ingredient: ingredient, db: db),
              ),
            );
            if (newIngredient != null) {
              setState(() { ingredient = newIngredient; });
            }
          },
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: Text(
              symbolToString(ingredient.id),
            ),
            height: 20,
          ),
          _buildEntityList(
            title: TL8(#CompositionStats),
            futureEntities: _compositionStats,
          ),
        ],
      ),
    );
  }

  Widget _buildEntityList({
    required String title,
    required futureEntities,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            textScaleFactor: 2,
          ),
          height: 50,
        ),
        FutureBuilder<Map<Symbol, String>>(
          future: futureEntities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map<Symbol, String> entities = snapshot.data ?? {};
              return Column(
                // Ingredients
                children: entities.entries.map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key))),
                          Text(e.value),
                        ],
                      ),
                    ),
                ).toList(),
              );
            }
            if (snapshot.hasError) {
              debugPrint("Error calculating stats: ${snapshot.error}\n${snapshot.stackTrace}");
              return Text(TL8(#ErrorCalculatingStats, {#error: snapshot.error.toString()}));
            }
            return Text('...');
          },
        ),
      ],
    );
  }
}
