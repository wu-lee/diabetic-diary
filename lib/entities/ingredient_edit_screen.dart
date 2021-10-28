import 'package:diabetic_diary/measureable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../database.dart';
import '../basic_ingredient.dart';
import '../quantity.dart';
import '../translation.dart';

/// The screen for editing an Ingredient
class IngredientEditScreen extends StatefulWidget {
  final Database db;
  final BasicIngredient? ingredient;

  const IngredientEditScreen({Key? key, required this.db, this.ingredient}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    BasicIngredient? ingredient = this.ingredient;
    if (ingredient != null)
      return _IngredientEditState(db: db, ingredient: ingredient);
    return _IngredientEditState(db: db);
  }
}

/// Manages state for ingredient creation / amendment
class _IngredientEditState extends State<IngredientEditScreen> {
  final titleController = new TextEditingController();
  final Database db;
  Map<Symbol, Quantity> _contents = {};
  Future<Map<Symbol, Quantity>> _pendingContentAmounts = Future.value({});

  _IngredientEditState({required this.db, BasicIngredient? ingredient}) {
    if (ingredient != null) {
      this.ingredient = ingredient;
    }
  }

  Symbol get id => Symbol(titleController.text);
  set id(Symbol newId) {
    titleController.text = symbolToString(newId);
  }

  Map<Symbol, Quantity> get contents => _contents;
  set contents(Map<Symbol, Quantity> newContents) {
    _contents = newContents;

    // This case doesn't really need to be a future, only to allow code reuse
    // in _buildEntityList
    _pendingContentAmounts = Future.value(newContents);
  }

  BasicIngredient get ingredient => BasicIngredient(
    contents: Map.from(_contents), // Make a copy, since we're returning it
    id: id,
  );

  set ingredient(BasicIngredient e) {
    id = e.id;
    contents = e.contents;
  }

  Widget _buildContentAmount(BuildContext context, Symbol id, Quantity quantity) {
    return SpinBox(
      min: 0,
      max: 100,
      decimals: 1,
      value: quantity.amount.toDouble(),
      onChanged: (value) {
        setState(() {
          if (value <= 0) {
            _contents.remove(id);
          }
          else {
            _contents[id] = Quantity(value, quantity.units);
          }

          this.contents = _contents; // updates the stats too
        });
      },

    );
  }

  Widget _buildEntityList<T>({
    required String title,
    required Future<Map<Symbol, T>> futureEntities,
    required Widget Function(BuildContext, Symbol, T) builder,
    required BuildContext context}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              title,
              textScaleFactor: 2,
            ),
            height: 50,
          ),
          Flexible(
            child: FutureBuilder<Map<Symbol, T>>( // Entities
              future: futureEntities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final entities = snapshot.data ?? {};
                  return ListView(
                    children: entities.entries.map((e) =>
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(TL8(e.key)),
                              ),
                              Expanded(
                                child: builder(context, e.key, e.value),
                              ),
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
            )
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(TL8(#NewIngredient)+':'),
              ),
              Expanded(
                child: TextField(
                  controller: titleController,
                  showCursor: true,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // FIXME get from media query
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[]
        ),
/*        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("add ingredient");
            setState(() {
              ingredients
                  .add(MapEntry(ingredients.get(#Cabbage), Mass.grams(10)));
              compositionStats = Ingredient.aggregate(ingredients);
            });
          / *Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );* /
          },
          tooltip: 'Add Ingredient',
        ),*/
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible( // Contents
                flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<Quantity>(
                  title: TL8(#CompositionStats),
                  futureEntities: _pendingContentAmounts,
                  builder: _buildContentAmount,
                  context: context,
                ),
              ),
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Text(
                        TL8(#AvailableStats),
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<Map<Symbol, Measurable>>( // Ingredients
                        future: db.measurables.getAll().then((list) => list..removeWhere((k, v) => k == id)),
                        builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Measurable>> snapshot) => ListView(
                          children: (snapshot.data?.values ?? []).map(
                            (e) => Container(
                              child: Row(
                                children: [
                                  Expanded(child: Text(TL8(e.id))),
                                  MaterialButton(
                                    shape: CircleBorder(),
                                    textColor: Colors.white,
                                    child: Icon(Icons.add),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      final gramsPerHectagram = await db.units.fetch(#g_per_hg);
                                      final newContents = await _pendingContentAmounts;
                                      final quantity = newContents[e.id] ?? Quantity(0, gramsPerHectagram);
                                      final aggregated = await db.aggregate(newContents, 1);
                                      newContents[e.id] = quantity.add(1);

                                      setState(() {
                                        contents = newContents;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onPop() async {
    final e = ingredient;
    await db.ingredients.add(e);
    Navigator.pop(context, e);
    return true;
  }
}
