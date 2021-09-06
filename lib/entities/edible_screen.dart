import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../edible.dart';
import '../quantity.dart';
import '../translation.dart';
import 'edible_edit_screen.dart';

/// The screen for inspecting an Edible
class EdibleScreen extends StatefulWidget {
  final Edible edible;
  final Database db;

  const EdibleScreen({Key? key, required this.edible, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EdibleState(edible, db);
  }
}

class _EdibleState extends State<EdibleScreen> {
  Edible _edible;
  final Database db;

  Future<Map<Symbol, String>> _compositionStats = Future.value({});
  Future<Map<Symbol, String>> _contentAmounts = Future.value({});

  Edible get edible => _edible;
  set edible(Edible e) {
    _edible = e;
    _contentAmounts = _format(edible.contents);
    _compositionStats = db.aggregate(edible.contents).then(_format);
  }

  _EdibleState(Edible edible, this.db) :
        this._edible = edible
  {
    _contentAmounts = _format(edible.contents);
    _compositionStats = db.aggregate(edible.contents).then(_format);
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
      appBar: AppBar(title: Text(TL8(edible.id)), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: TL8(#Edit),
          onPressed: () async {
            final Edible? newEdible = await Navigator.push<Edible>(
              context,
              MaterialPageRoute(
                builder: (context) => EdibleEditScreen(edible: edible, db: db),
              ),
            );
            if (newEdible != null) {
              setState(() { edible = newEdible; });
            }
          },
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: Text(
              TL8(edible is BasicIngredient? #Ingredient : #Dish),
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
