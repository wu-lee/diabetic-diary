import 'package:flutter/material.dart';

import '../database.dart';
import '../edible.dart';
import '../quantity.dart';
import '../translation.dart';

/// The screen for editing an Edible
class EdibleEditScreen extends StatefulWidget {
  final Database db;
  final Edible? edible;

  const EdibleEditScreen({Key? key, required this.db, this.edible}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    Edible? edible = this.edible;
    if (edible != null)
      return _EdibleCreateState.create(db: db, edible: edible);
    return _EdibleCreateState(db: db);
  }
}

/// Manages state for edible creation / amendment
class _EdibleCreateState extends State<EdibleEditScreen> {
  final Map<Symbol, Quantity> contentAmounts = {};
  Map<Symbol, Quantity> compositionStats = {};
  bool isDish = false;
  final titleController = new TextEditingController();
  final Database db;
  Future<Map<Symbol, Quantity>> _contentAmounts = Future.value({});
  Future<Map<Symbol, String>> _compositionStats = Future.value({});

  _EdibleCreateState({required this.db});

  factory _EdibleCreateState.create({required Database db, Edible? edible}) {
    final instance = _EdibleCreateState(db: db);
    if (edible == null)
      return instance;

    instance.titleController.text = symbolToString(edible.id);
    instance.contentAmounts.addAll(edible.contents);
    instance.isDish = edible.isDish;

    // This case doesn't really need to be a future, only to allow code reuse
    instance._contentAmounts = Future.value(edible.contents);

    instance._compositionStats = db.aggregate(edible.contents, edible.id).then(
        // Format the quantities into strings
        (stats) async {
          final Map<Symbol, String> result = {};
          for(final entry in stats.entries) {
            result[entry.key] = await db.formatQuantity(entry.value);
          }
          return result;
        }
    );

    return instance;
  }

   Future<Edible> addDish() async {
    final edible = Edible(
      contents: Map.from(contentAmounts), // Make a copy, since we're returning it
      id: Symbol(titleController.text),
      isDish: isDish,
    );
    await db.edibles.add(edible);
    return edible;
  }

  Widget _buildCompositionStat(BuildContext context, Symbol id, String quantity) {
    return Text(quantity);
  }

  Widget _buildContentAmount(BuildContext context, Symbol id, Quantity quantity) {
    return Text("${quantity.amount} x");
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
                              builder(context, e.key, e.value),
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
                child: Text(TL8(#NewEdible)+':'),
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
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child:RadioListTile(
                            title: Text(TL8(#Dish)),
                            value: true,
                            groupValue: isDish,
                            onChanged: (bool? value) {
                              setState(() { isDish = true; });
                            },
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child:
                        RadioListTile(
                          title: Text(TL8(#Ingredient)),
                          value: false,
                          groupValue: isDish,
                          onChanged: (bool? value) {
                            setState(() { isDish = false; });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Flexible( // Composition Stats
              flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<String>(
                  title: TL8(#CompositionStats),
                  futureEntities: _compositionStats,
                  builder: _buildCompositionStat,
                  context: context,
                ),
              ),
              Flexible( // Contents
                flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<Quantity>(
                  title: TL8(#Contents),
                  futureEntities: _contentAmounts,
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
                      child: FutureBuilder<Map<Symbol, Edible>>( // Ingredients
                        future: db.edibles.getAll(),
                        builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Edible>> snapshot) => ListView(
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
                                      final quantity = contentAmounts[e.id] ?? Quantity(0, gramsPerHectagram);
                                      final aggregated = await db.aggregate(contentAmounts);
                                      contentAmounts[e.id] = quantity.add(1);

                                      setState(()  {
                                        compositionStats = aggregated;
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
    Edible edible = await addDish();
    Navigator.pop(context, edible);
    return true;
  }
}
