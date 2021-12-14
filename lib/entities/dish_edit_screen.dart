import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../composite_edible.dart';
import '../database.dart';
import '../dish.dart';
import '../edible.dart';
import '../quantity.dart';
import '../translation.dart';
import '../units.dart';
import '../utils.dart';

/// The screen for editing an Dish
class DishEditScreen extends StatefulWidget {
  final Database db;
  final Dish? dish;

  const DishEditScreen({Key? key, required this.db, this.dish}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    Dish? dish = this.dish;
    if (dish != null)
      return _DishEditState(db: db, dish: dish);
    return _DishEditState(db: db);
  }
}

/// Manages state for dish creation / amendment
class _DishEditState extends State<DishEditScreen> {
  // FIXME temp datetime generated identifier
  static Symbol newId() => Symbol(ID('dish:').toString());

  bool isDish = false;
  final labelController = new TextEditingController();
  final Database db;
  Map<Symbol, Quantity> _contents = {};
  Future<Map<Symbol, MapEntry<String, Quantity>>> _pendingContentAmounts = Future.value({});
  Future<Map<Symbol, MapEntry<String, String>>> _pendingCompositionStats = Future.value({});

  _DishEditState({required this.db, Dish? dish}) {
    if (dish != null) {
      this.dish = dish;
    }
  }

  Symbol id = newId();

  String get label => labelController.text;
  set label(String newLabel) {
    labelController.text = newLabel;
  }

  Map<Symbol, Quantity> get contents => _contents;
  set contents(Map<Symbol, Quantity> newContents) {
    _contents = newContents;

    // This case doesn't really need to be a future, only to allow code reuse
    // in _buildEntityList
    _pendingContentAmounts = db.retrieveEdibles(newContents.keys)
        .then((e) => labelledQuantities(newContents, e));

    // This does, because the calculation is asynchronous. Add a handler to
    // update our state when it's done.
    final totalMass = CompositeEdible.getTotalMass(contents);
    _pendingCompositionStats = db.aggregate(newContents, totalMass, id).then(
      // Format the quantities into strings
        (stats) async {
          final Map<Symbol, MapEntry<String, String>> result = {};
          for(final entry in stats.entries) {
            result[entry.key] = MapEntry(TL8(entry.key), entry.value.format());
          }

          return result;
        }
    );
  }

  Dish get dish => Dish(
    contents: Map.from(_contents) // Make a copy before modifying and returning
      ..removeWhere((id, quantity) => quantity.amount == 0),
    id: id,
    label: label,
  );

  set dish(Dish e) {
    id = e.id;
    label = e.label;
    contents = e.contents;
  }

  Widget _buildCompositionStat(BuildContext context, Symbol id, String quantity) {
    return Text(quantity);
  }

  Widget _buildContentAmount(BuildContext context, Symbol id, Quantity quantity) {
    return SpinBox(
      min: 0,
      max: double.maxFinite,
      decimals: 1,
      value: quantity.amount.toDouble(),
      onChanged: (value) {
        setState(() {
          _contents[id] = Quantity(value, quantity.units);
          this.contents = _contents; // updates the stats too
        });
      },

    );
  }

  Widget _buildEntityList<T>({
    required String title,
    required Future<Map<Symbol, MapEntry<String, T>>> futureEntities,
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
            child: FutureBuilder<Map<Symbol, MapEntry<String, T>>>( // Entities
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
                                child: Text(e.value.key),
                              ),
                              Expanded(
                                child: builder(context, e.key, e.value.value),
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
                child: Text(TL8(#NewDish)+':'),
              ),
              Expanded(
                child: TextField(
                  controller: labelController,
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
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible( // Composition Stats
              flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<String>(
                  title: TL8(#CompositionStats),
                  futureEntities: _pendingCompositionStats,
                  builder: _buildCompositionStat,
                  context: context,
                ),
              ),
              Flexible( // Contents
                flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<Quantity>(
                  title: TL8(#Contents),
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
                        TL8(#AvailableIngredients),
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                        child: FutureBuilder<Map<Symbol, Edible>>(
                        future: db.edibles.getAll().then((list) => list..removeWhere((k, v) => k == id)),
                        builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Edible>> snapshot) => ListView(
                          children: (snapshot.data?.values ?? []).map(
                            (e) => Container(
                              child: Row(
                                children: [
                                  Expanded(child: Text(e.label)),
                                  MaterialButton(
                                    shape: CircleBorder(),
                                    textColor: Colors.white,
                                    child: Icon(Icons.add),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      final newAmounts = await _pendingContentAmounts;
                                      final entry = newAmounts[e.id];

                                      if (entry != null)
                                        return; // Nothing to do, it's there already

                                      // Update the quantity, which we know always has units of g/100g
                                      // because they're ingredients
                                      final newContents = contents;
                                      newContents[e.id] = Quantity(1, Units.GramsPerHectogram);

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
    final e = dish;
    await db.dishes.add(e);
    Navigator.pop(context, e);
    return true;
  }
}
