import 'package:flutter/material.dart';

import '../database.dart';
import '../home_page.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../translation.dart';
import '../unit.dart';
import 'dish.dart';
import 'ingredient.dart';

/// The screen for inspecting a Dish
class DishCreateScreen extends StatefulWidget {
  final Database db;

  const DishCreateScreen({Key? key, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DishCreateState(db: db);
  }
}

class _DishCreateState extends State<DishCreateScreen> {
  final Map<Ingredient, Quantity> ingredientAmounts = {};
  Map<MeasurementType, Quantity> compositionStats = {};
  final titleController = new TextEditingController();
  final Database db;

  _DishCreateState({required this.db});

  Future<bool> addDish() async {
    final dish = Dish(
      ingredients: ingredientAmounts,
      id: Symbol(titleController.text),
    );
    db.dishes.put(dish.id, dish);
    return true;
  }

  Widget buildEntityList({required String title, required Iterable<MapEntry<Indexable, Quantity>> entities,
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
                padding:
                EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: Text(TL8(e.key.id))),
                    Text('${e.value.format(unitId)}'),
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
                child: Text('New dish:'),
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
                child: buildEntityList(
                  title: 'Composition Stats',
                  entities: compositionStats.entries,
                  context: context,
                  unitId: #g_per_hg,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: buildEntityList(
                  title: 'Ingredients',
                  entities: ingredientAmounts.entries,
                  context: context,
                  unitId: #g_per_hg,
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
                        'Available Ingredients',
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: db.ingredients.getAll().values.map(
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
                                    final mass = db.dimensions.fetch(#Mass);
                                    setState(() {
                                      final quantity = ingredientAmounts[e] ?? mass.of(0, #g);
                                      ingredientAmounts[e] = quantity.add(1);
                                      print(Ingredient.format(ingredientAmounts));
                                      print(MeasurementType.format(compositionStats));
                                      compositionStats = Ingredient.aggregate(ingredientAmounts);
                                      print(MeasurementType.format(compositionStats));
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
