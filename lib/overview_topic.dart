

import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database.dart';
import 'dish.dart';
import 'topic.dart';
import 'translation.dart';

class OverviewTopic extends Topic {
  final Database db;

  OverviewTopic({required this.db, required Symbol id, required IconData icon}) : super(id: id, icon: icon);

  @override
  Widget buildTabContent(BuildContext context, StateSetter setBuilderState) {
    return FutureBuilder(
      future:  Future(() async {
        final edibles = await db.edibles.getAll();
        final numDishes = edibles.values.whereType<Dish>().length;
        final numIngredients = edibles.values.whereType<BasicIngredient>().length;
        final measurables = await db.measurables.getAll();
        final numMeasurables = measurables.length;
        return  [numDishes, numIngredients, numMeasurables];
      }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        final numDishes = snapshot.data?[0] ?? 0;
        final numIngredients = snapshot.data?[1] ?? 0;
        final numMeasurables = snapshot.data?[2] ?? 0;
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) =>
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // A fixed-height child.
                          color: const Color(0xffeeee00),
                          height: 30.0,
                          alignment: Alignment.center,
                          child: Text(TL8(#YouHaveNDishes, {#n: numDishes})),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000),
                          height: 30.0,
                          alignment: Alignment.center,
                          child: Text(TL8(#YouHaveNIngredients, {#n: numIngredients})),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff197bbd),
                          height: 30.0,
                          alignment: Alignment.center,
                          child: Text(TL8(#YouHaveNMacroNutrients, {#n: numMeasurables})),
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              setBuilderState(() async {
                                await db.clear();
                                await Database.initialiseData(db);
                              });
                            },
                            child: Text(TL8(#ResetDatabase)),
                          )
                        )

                      ],
                    ),
                  ),
                )
        );
      },
    );
  }
}