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
  final DataCollection<Symbol, MeasurementType> measurementTypes;
  final DataCollection<Symbol, Ingredient> ingredients;

  const IngredientCreateScreen({Key key, this.measurementTypes, this.ingredients}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IngredientCreateState(measurementTypes: measurementTypes, ingredients: ingredients);
  }
}

class _IngredientCreateState extends State<IngredientCreateScreen> {
  final Map<MeasurementType<Dimensions>, Quantity<Dimensions>> compositionStats = {};
  final titleController = new TextEditingController();
  final DataCollection<Symbol, MeasurementType> measurementTypes;
  final DataCollection<Symbol, Ingredient> ingredients;


  _IngredientCreateState({this.ingredients, this.measurementTypes});

  Future<bool> addIngredient() async {
    final ingredient = Ingredient(
      compositionStats: compositionStats,
      name: Symbol(titleController.text),
    );
    ingredients.put(ingredient.name, ingredient);
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
                    Expanded(child: Text(TL8(e.key.name))),
                    Text('${e.value.format()}'),
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
            print("add ingredient");
            setState(() {
              ingredients
                  .add(MapEntry(db.ingredients.get(#Cabbage), Mass.grams(10)));
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
                        children: measurementTypes.getAll().values.map(
                          (e) => Container(
                            child: Row(
                              children: [
                                Expanded(child: Text(TL8(e.name))),
                                MaterialButton(
                                  shape: CircleBorder(),
                                  textColor: Colors.white,
                                  child: Icon(Icons.add),
                                  color: Colors.blue,
                                  onPressed: () {
                                    final amount = Mass.grams(10) + (compositionStats[e] ?? Mass.grams(0));
                                    setState(() {
                                      compositionStats[e] = amount;
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
