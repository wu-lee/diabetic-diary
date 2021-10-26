import 'package:flutter/material.dart';

import '../database.dart';
import '../dish.dart';
import '../quantity.dart';
import '../translation.dart';
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

  Future<Map<Symbol, String>> _compositionStats = Future.value({});
  Future<Map<Symbol, String>> _contentAmounts = Future.value({});

  Dish get dish => _dish;
  set dish(Dish e) {
    _dish = e;
    _contentAmounts = _format(dish.contents);
    _compositionStats = db.aggregate(dish.contents).then(_format);
  }

  _DishState(Dish dish, this.db) :
        this._dish = dish
  {
    _contentAmounts = _format(dish.contents);
    _compositionStats = db.aggregate(dish.contents).then(_format);
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
      appBar: AppBar(title: Text(TL8(dish.id)), actions: <Widget>[
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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: Text(
              TL8(#Dishes),
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
