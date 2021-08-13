import 'package:flutter/material.dart';

import '../database.dart';
import '../edible.dart';
import '../translation.dart';
import 'edible_create_screen.dart';

/// The screen for inspecting an Edible
class EdibleScreen extends StatefulWidget {
  final Edible edible;
  final Database db;

  const EdibleScreen({Key? key, required this.edible, required this.db}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EdibleState(edible, db);
  }
}

class _EdibleState extends State<EdibleScreen> {
  final Edible edible;
  final Database db;

  _EdibleState(this.edible, this.db);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TL8(edible.id)), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.edit),
          tooltip: TL8(#Edit),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EdibleCreateScreen(edible: edible, db: db),
              ),
            )
          },
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  TL8(edible.isDish? #Dish : #Ingredient),
                ),
                height: 20,
              ),
              Container(
                child: Text(
                  TL8(#CompositionStats),
                  textScaleFactor: 2,
                ),
                height: 50,
              ),
              Column(
                // Ingredients
                children: edible.contents.entries
                  .map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key))),
                          FutureBuilder(
                            future: db.formatQuantity(e.value, #g_per_hg),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                                Text('${snapshot.data}'),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Ingredients',
                  textScaleFactor: 2,
                ),
                height: 50,
              ),
              Column(
                // Ingredients
                children: edible.contents.entries
                  .map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key))),
                          FutureBuilder(
                            future: db.formatQuantity(e.value, e.value.units.id),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                                Text('${snapshot.data}'),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
