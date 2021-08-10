

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database.dart';
import 'topic.dart';
import 'translation.dart';

class OverviewTopic extends Topic {
  final Database db;

  OverviewTopic({required this.db, required Symbol id, required IconData icon}) : super(id: id, icon: icon);

  @override
  Widget buildTabContent(BuildContext context) {
    return FutureBuilder(
      future:  Future(() async {
        final edibles = await db.edibles.getAll();
        edibles.forEach((key, value) async {print("${await db.formatEdible(value)}"); });
        final numDishes = edibles.values.where((e) => e.contents.isNotEmpty).length;
        final numIngredients = edibles.length - numDishes;
        final measurables = await db.measurables.getAll();
        final numMeasurables = measurables.length;
        print("Edibles ${edibles.length} Dishes $numDishes Ingredients $numIngredients");
        return  [numDishes, numIngredients, numMeasurables];
      }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        final numEdibles = snapshot.data?[0] ?? {};
        final numIngredients = snapshot.data?[1] ?? {};
        final numMeasurables = snapshot.data?[2] ?? {};
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
                          child: Text(TL8(#YouHaveNDishes, {#n: numEdibles})),
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

                      ],
                    ),
                  ),
                )
        );
      },
    );
  }
}