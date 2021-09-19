import 'package:flutter/material.dart';

import '../database.dart';
import '../meal.dart';
import '../quantity.dart';
import '../translation.dart';
import 'meal_edit_screen.dart';

/// The screen for inspecting an Meal
class MealScreen extends StatefulWidget {
  final Meal meal;
  final Database db;

  const MealScreen({Key? key, required this.meal, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MealState(meal, db);
  }
}

class _MealState extends State<MealScreen> {
  Meal _meal;
  final Database db;

  Future<Map<Symbol, String>> _compositionStats = Future.value({});
  Future<Map<Symbol, String>> _contentAmounts = Future.value({});

  Meal get meal => _meal;
  set meal(Meal e) {
    _meal = e;
    _contentAmounts = _format(meal.contents);
    _compositionStats = db.aggregate(meal.contents).then(_format);
  }

  _MealState(Meal meal, this.db) :
        this._meal = meal
  {
    _contentAmounts = _format(meal.contents);
    _compositionStats = db.aggregate(meal.contents).then(_format);
  }

  Future<Map<Symbol, String>> _format(Map<Symbol, Quantity> entities) async {
    // Format the quantities into strings
    final Map<Symbol, String> result = {};
    for(final entry in entities.entries) {
      result[entry.key] = await db.formatQuantity(entry.value);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: TL8(#Edit),
          onPressed: () async {
            final Meal? newMeal = await Navigator.push<Meal>(
              context,
              MaterialPageRoute(
                builder: (context) => MealEditScreen(meal: meal, db: db),
              ),
            );
            if (newMeal != null) {
              setState(() { meal = newMeal; });
            }
          },
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: Text(
              TL8(#Meals),
            ),
            height: 20,
          ),
          _buildEntityList(
            title: TL8(#CompositionStats),
            futureEntities: _compositionStats,
          ),
          _buildEntityList(
            title: TL8(#Items),
            futureEntities: _contentAmounts,
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
