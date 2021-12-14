import 'package:flutter/material.dart';

import '../database.dart';
import '../dish.dart';
import '../quantity.dart';
import '../translation.dart';
import '../utils.dart';
import 'dish_edit_screen.dart';

/// The screen for inspecting an Dish
class DishScreen extends StatefulWidget {
  final Dish dish;
  final Database db;

  const DishScreen({Key? key, required this.dish, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DishState(dish, db);
  }
}

class _DishState extends State<DishScreen> {
  Dish _dish;
  final Database db;

  Future<Map<Symbol, MapEntry<String, String>>> _compositionStats = Future.value({});
  Future<Map<Symbol, MapEntry<String, String>>> _contentAmounts = Future.value({});

  Dish get dish => _dish;
  set dish(Dish e) {
    _dish = e;
    _contentAmounts = db.retrieveEdibles(dish.contents.keys)
        .then((e) => formatLabelledQuantities(dish.contents, e));
    _compositionStats = db.aggregate(dish.contents, dish.totalMass)
        .then(formatLocalisedQuantities);
  }

  _DishState(Dish dish, this.db) :
        this._dish = dish
  {
    _contentAmounts = db.retrieveEdibles(dish.contents.keys)
        .then((e) => formatLabelledQuantities(dish.contents, e));
    _compositionStats = db.aggregate(dish.contents, dish.totalMass)
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
      appBar: AppBar(title: Text(dish.label), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: TL8(#Edit),
          onPressed: () async {
            final Dish? newDish = await Navigator.push<Dish>(
              context,
              MaterialPageRoute(
                builder: (context) => DishEditScreen(dish: dish, db: db),
              ),
            );
            if (newDish != null) {
              setState(() { dish = newDish; });
            }
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            db.ingredients.remove(dish.id);
          });
          Navigator.pop(context);
        },
        tooltip: TL8(#DeleteFromIndex),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: Text(
              symbolToString(dish.id),
            ),
            height: 20,
          ),
          _buildEntityList(
            title: TL8(#CompositionStats),
            futureEntities: _compositionStats,
          ),
          _buildEntityList(
            title: TL8(#Ingredients),
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
