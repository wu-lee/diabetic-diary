import 'package:flutter/material.dart';

import '../database.dart';
import '../edible.dart';
import '../quantity.dart';
import '../translation.dart';

/// The screen for inspecting a Dish
class EdibleCreateScreen extends StatefulWidget {
  final Database db;

  const EdibleCreateScreen({Key? key, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EdibleCreateState(db: db);
  }
}

class _EdibleCreateState extends State<EdibleCreateScreen> {
  final Map<Symbol, Quantity> contentAmounts = {};
  Map<Symbol, Quantity> compositionStats = {};
  bool isDish = false;
  final titleController = new TextEditingController();
  final Database db;

  _EdibleCreateState({required this.db});

  Future<bool> addDish() async {
    final edible = Edible(
      contents: contentAmounts,
      id: Symbol(titleController.text),
      isDish: isDish,
    );
    db.edibles.add(edible);
    return true;
  }

  Widget buildEntityList({required String title, required Iterable<MapEntry<Symbol, Quantity>> entities,
    required Symbol unitId, required BuildContext context}) =>
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
          child: ListView(
            children: entities.map(
              (e) => Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(TL8(e.key))
                    ),
                    FutureBuilder(
                      future: db.formatQuantity(e.value),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                        Text('${snapshot.data}'),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
        ),
      ],
    );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: addDish,
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
              Flexible(
              flex: 6,
                fit: FlexFit.tight,
                child: buildEntityList(
                  title: TL8(#CompositionStats),
                  entities: compositionStats.entries,
                  context: context,
                  unitId: #g_per_hg,
                ),
              ),
              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: buildEntityList(
                  title: TL8(#Contents),
                  entities: contentAmounts.entries,
                  context: context,
                  unitId: #g_per_hg,
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
                                      final q2 = contentAmounts[e.id] = quantity.add(1);

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
}
