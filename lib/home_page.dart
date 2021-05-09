import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database.dart';
import 'database/mock_database.dart';
import 'entities/dish.dart';
import 'entities/ingredient.dart';
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

 ingredients have names, and a list of composition statistics

 dishes are kinds of ingredient
 dishes have names, a list of ingredients, and an aggregate list of measurement types

 a composition statistic has a name, a measurement type, and a quantity

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

final db = MockDatabase();


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
  static const int _initialTopic = 0;
  Topic _currentTopic = topics[_initialTopic];

  static final topics = [
    Topic(name: #Overview, icon: Icons.follow_the_signs),
    DishTopic(
      entities: db.dishes
          .getAll()
          .values
          .toList(),
    ),
    IngredientTopic(
      entities: db.ingredients
          .getAll()
          .values
          .toList(),
    ),
  ];

  void _setTopic(Topic topic) {
    setState(() {
      _currentTopic = topic;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _initialTopic,
      length: topics.length,
      child: StatefulBuilder(
        builder: (context, setBuilderState) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (tabController.indexIsChanging) {
              setBuilderState(() { _currentTopic = topics[tabController.index]; });
            }
          });
          return Scaffold(
            appBar: AppBar(
              title: Text(TL8(widget.title)),
              bottom: TabBar(
                tabs: topics.map((topic) =>
                  Tab(
                    icon: Icon(topic.icon),
                    text: TL8(topic.name),
                  )
                ).toList(),
              ),
            ),
            body: TabBarView(
              children: topics.map((topic) => topic.buildTabContent(context))
                  .toList(),
            ),
            floatingActionButton: _currentTopic.buildFloatingActionButton(context),
          );
        },
      )
    );
  }
}

