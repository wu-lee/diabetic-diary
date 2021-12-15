import 'package:diabetic_diary/measureable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../database.dart';
import '../basic_ingredient.dart';
import '../open_food_facts_search_dialog.dart';
import '../quantity.dart';
import '../translation.dart';
import '../units.dart';
import '../utils.dart';

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
  // FIXME temp datetime generated identifier
  static Symbol newId() => Symbol(ID('ingr:').toString());

  final labelController = new TextEditingController();
  final portionSizeController = new TextEditingController();

  final Database db;
  // This flag indicates whether the search button should be disabled
  bool isSearchDisabled = true;

  Map<Symbol, Quantity> _contents = {};
  Future<Map<Symbol, Quantity>> _pendingContentAmounts = Future.value({});

  _IngredientEditState({required this.db, BasicIngredient? ingredient}) {
    if (ingredient != null) {
      this.ingredient = ingredient;
    }
    // Check for changes which mean we enable/disable the search button
    labelController.addListener(() {
      final isEmpty = labelController.text.length == 0;
      if (isEmpty != isSearchDisabled) {
        // Trigger a state change when updating this flag
        // which will redraw the search button in the intended state
        setState(() {
          isSearchDisabled = isEmpty;
        });
      }
    });
  }

  Symbol id = newId();

  num get portionSize => num.tryParse(portionSizeController.text) ?? 0;
  set portionSize(num value) {
    portionSizeController.text = value.toString();
  }

  String get label => labelController.text;
  set label(String newLabel) {
    labelController.text = newLabel;
  }

  Map<Symbol, Quantity> get contents => _contents;
  set contents(Map<Symbol, Quantity> newContents) {
    _contents = newContents;

    // This case doesn't really need to be a future, only to allow code reuse
    // in _buildEntityList
    _pendingContentAmounts = Future.value(newContents);
  }

  BasicIngredient get ingredient => BasicIngredient(
    contents: Map.from(_contents) // Make a copy before modifying and returning
      ..removeWhere((id, quantity) => quantity.amount == 0),
    id: id,
    label: label,
    portionSize: portionSize,
  );

  set ingredient(BasicIngredient e) {
    id = e.id;
    contents = e.contents;
    label = e.label;
    portionSize = e.portionSize;
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

  void doOffSearch(BuildContext context) async {
    final ingredient = await OpenFoodFactsSearchDialog.show(
        context: context,
        searchTerms: labelController.text
    );
    if (ingredient == null)
      return; // Nothing to do

    setState(() {
      id = ingredient.id;
      contents = ingredient.contents;
      label = ingredient.label;
      portionSize = ingredient.portionSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Text(TL8(#NewIngredient)+':'),
          ),
          actions: <Widget>[]
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: labelController,
                      showCursor: true,
                      textAlignVertical: TextAlignVertical.bottom,
                      onSubmitted: (txt) => doOffSearch(context),
                      decoration: InputDecoration(
                        hintText: 'Name or search terms...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
/*                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20, // FIXME get from media query
                      ),*/
                    ),
                  ),
                  IconButton(
                    onPressed: isSearchDisabled? null : () => doOffSearch(context),
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              Row(
                children: [
                  Text(TL8(#PortionsSize)),
                  Expanded(
                    child: SpinBox(
                      min: 0,
                      max: double.maxFinite,
                      decimals: 1,
                      value: portionSize.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          portionSize = value;
                        });
                      },
                    )
                  )
                ]
              ),
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
                        builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Measurable>> snapshot) {
                          final measurables = snapshot.data?.values ?? [];
                          return ListView(
                            children: measurables.map(
                                  (e) =>
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(TL8(e.id))),
                                        MaterialButton(
                                          shape: CircleBorder(),
                                          textColor: Colors.white,
                                          child: Icon(Icons.add),
                                          color: Colors.blue,
                                          onPressed: () async {
                                            final newContents = await _pendingContentAmounts;
                                            if (newContents.containsKey(e.id))
                                              return; // nothing to do, exists already

                                            newContents[e.id] = Quantity(1, e.defaultUnits);

                                            setState(() {
                                              contents = newContents;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            ).toList(),
                          );
                        }
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
