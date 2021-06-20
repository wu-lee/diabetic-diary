import 'package:flutter/material.dart';

import '../database.dart';
import '../home_page.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../translation.dart';
import '../unit.dart';
import 'ingredient.dart';
import 'ingredient.dart';

/// The screen for inspecting a Ingredient
class IngredientCreateScreen extends StatefulWidget {
  final Database db;

  const IngredientCreateScreen({Key key, this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientCreateState(db: db);
  }
}

class _IngredientCreateState extends State<IngredientCreateScreen> {
  final Map<MeasurementType, Quantity> compositionStats = {};
  final titleController = new TextEditingController();
  final Database db;


  _IngredientCreateState({this.db});

  Future<bool> addIngredient() async {
    final ingredient = Ingredient(
      compositionStats: compositionStats,
      id: Symbol(titleController.text),
    );
    db.ingredients.add(ingredient);
    return true;
  }

  Widget buildEntityList({String title, Iterable<MapEntry<Indexable, Quantity>> entities, BuildContext context}) =>
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
                padding:
                EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Text(TL8(e.key.id))),
                    Text('${e.value.format(#g_per_hg)}'),
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
    print(MeasurementType.format(compositionStats));
    return WillPopScope(
      onWillPop: addIngredient,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text('New ingredient:'),
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
            print("add XXX"); FIXME this is not used any more
            setState(() {
              final mass = db.dimensions.get(#Mass);
              var grams = mass.units(#g);
              db.ingredients
                  .add(MapEntry(db.ingredients.get(#Cabbage), grams.times(10)));
              compositionStats.addAll(Ingredient.aggregate(ingredients));
            });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => null,
            ),
          );
          },
          tooltip: 'Add Ingredient',
        ),*/
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: buildEntityList(
                  title: 'Composition Stats',
                  entities: compositionStats.entries,
                  context: context
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Text(
                        'Available Measurements',
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: db.compositionStatistics.getAll().values.map(
                          (e) => Container(
                            child: Row(
                              children: [
                                Expanded(child: Text(TL8(e.id))),
                                MaterialButton(
                                  shape: CircleBorder(),
                                  textColor: Colors.white,
                                  child: Icon(Icons.add),
                                  color: Colors.blue,
                                  onPressed: () {
                                    final fbmass = db.dimensions.get(#FractionByMass);
                                    final stat = compositionStats[e] ?? Quantity(0, fbmass.units(#g_per_hg));
                                    setState(() {
                                      compositionStats[e] = stat.add(10);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
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
