import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/utils.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../basic_ingredient.dart';
import '../quantity.dart';
import '../translation.dart';
import '../units.dart';
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

  Future<Map<Symbol, MapEntry<String, String>>> _compositionStats = Future.value({});
  Future<Map<Symbol, MapEntry<String, String>>> _contentAmounts = Future.value({});

  BasicIngredient get ingredient => _ingredient;
  set ingredient(BasicIngredient e) {
    _ingredient = e;
    _contentAmounts = db.retrieveEdibles(ingredient.contents.keys)
        .then((e) => formatLabelledQuantities(ingredient.contents, e));
    _compositionStats = db.aggregate(ingredient.contents)
        .then(formatLocalisedQuantities);
  }

  _IngredientState(BasicIngredient ingredient, this.db) :
        this._ingredient = ingredient
  {
    _contentAmounts = db.retrieveEdibles(ingredient.contents.keys)
        .then((e) => formatLabelledQuantities(ingredient.contents, e));
    _compositionStats = db.aggregate(ingredient.contents)
        .then(formatLocalisedQuantities);
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            db.ingredients.remove(ingredient.id);
          });
          Navigator.pop(context);
        },
        tooltip: TL8(#DeleteFromIndex),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Row(
            children: [
              Expanded(child: Text(TL8(#ID))),
              Text(
                symbolToString(ingredient.id),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(TL8(#PortionSize))),
              Text(Quantity(ingredient.portionSize, Units.Grams).format()),
            ],
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
    required Future<Map<Symbol, MapEntry<String, String>>> futureEntities,
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
        FutureBuilder<Map<Symbol, MapEntry<String, String>>>(
          future: futureEntities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map<Symbol, MapEntry<String, String>> entities = snapshot.data ?? {};
              return Column(
                // Ingredients
                children: entities.entries.map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(e.value.key)),
                          Text(e.value.value),
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
