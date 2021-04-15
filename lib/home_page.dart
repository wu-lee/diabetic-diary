import 'package:diabetic_diary/measurement_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'index_topic.dart';
import 'ingredient.dart';
import 'topic.dart';
import 'translation.dart';


/*
 records have a timestamp, possibly with a precision, possibly with a note, tags

 blood glucose measurements are kinds of record
 they have a timestamp and a concentration
 a concentration is a dimensioned quantity

 body mass measurements are kinds of record
 they have a timestamp and a mass
 mass is a dimensioned quantity

 blood pressure measurements are kinds of record
 they have a timestamp and a systolic, diastolic, and heart rate
 these are dimensioned quantities

 logged meals have a timestamp, an optional description, tags, and a list of ingredients,
 and an aggregate list of composition statistics
 logged meals are kinds of record

 ingredients have names, and a list of measurement types

 dishes are kinds of ingredient
 dishes have names, a list of ingredients, and an aggregate list of measurement types

 a composition statistic has a name, a dimension, and a quantity

 a dimension has a name and a list of allowed units with their relative sizes
 one of these units is the base unit

 a quantity has a dimension, units and an amount

 dimensions are one of
 - mass
 - fraction by mass
 - volume
 - fraction by volume
 - energy
 - energy by mass
 - mMol/dL
 - pressure
 - frequency AKA rate

 measurement types are one of
 - fat
 - saturated fat
 - energy
 - carbohydrates
 - fibre
 - protein
 - salt

 */

final DB = MockDatabase();

final topics = [
  Topic(name: #Overview),
  IndexTopic(
    name: #Dishes,
    items: DB.dishes.getAll().values.toList(),
  ),
  IndexTopic(
    name: #Ingredients,
    items: DB.ingredients.getAll().values.toList(),
  ),
  IndexTopic<MeasurementType>(
    name: #MeasurementTypes,
    items: DB.measurementTypes.getAll().values.toList(),
  ),
];


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Symbol title = #HomePage;

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: topics.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TL8(widget.title)),
          bottom: TabBar(
            tabs: topics.map((topic) => Tab(
              icon: Icon(topic.icon),
              text: TL8(topic.name),
            )
            ).toList(),
          ),
        ),
        body: TabBarView(
          children: topics.map((topic) => Center(
            child: topic.buildWidget(context),
          )
          ).toList(),
        ),
      ),
    );
  }
}
