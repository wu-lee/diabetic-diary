import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database.dart';
import '../edible.dart';
import '../meal.dart';
import '../quantity.dart';
import '../translation.dart';
import '../utils.dart';
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
  static final _dateFormat = DateFormat('yyyy-MM-dd hh:mm');
  Meal _meal;
  final Database db;

  Future<Map<Symbol, MapEntry<String, String>>> _compositionStats = Future.value({});
  Future<Map<Symbol, MapEntry<String, String>>> _contentAmounts = Future.value({});

  Meal get meal => _meal;
  set meal(Meal e) {
    _meal = e;
    _contentAmounts = db.retrieveEdibles(meal.contents.keys)
        .then((e) => formatLabelledQuantities(meal.contents, e));
    _compositionStats = db.aggregate(meal.contents)
      .then(formatLocalisedQuantities);
  }

  _MealState(Meal meal, this.db) :
        this._meal = meal
  {
    _contentAmounts = db.retrieveEdibles(meal.contents.keys)
        .then((e) => formatLabelledQuantities(meal.contents, e));
    _compositionStats = db.aggregate(meal.contents)
        .then(formatLocalisedQuantities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.label), actions: <Widget>[
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            db.meals.remove(_meal.id);
          });
          Navigator.pop(context);
        },
        tooltip: TL8(#DeleteFromIndex),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 3, horizontal: 10),
            child:  Row(
              children: [
                Expanded(child: Text(TL8(#MealId))),
                Text(symbolToString(_meal.id)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 3, horizontal: 10),
            child:  Row(
              children: [
                Expanded(child: Text(TL8(#MealTime))),
                Text(_dateFormat.format(_meal.timestamp.toLocal())),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 3, horizontal: 10),
            child:  Row(
              children: [
                Expanded(
                    child: Text(TL8(#MealNotes))
                ),
                Flexible(
                  child: Text(
                      _meal.notes,
                      maxLines: 50,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis
                  ),
                )
              ],
            ),
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
