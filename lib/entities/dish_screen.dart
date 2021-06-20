import 'package:flutter/material.dart';

import '../translation.dart';
import 'dish.dart';

/// The screen for inspecting a Dish
class DishScreen extends StatefulWidget {
  final Dish dish;

  const DishScreen({Key key, this.dish}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DishState(dish);
  }
}

class _DishState extends State<DishScreen> {
  final Dish dish;

  _DishState(this.dish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TL8(dish.id)), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'FIXME settings?',
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
                  'Composition Stats',
                  textScaleFactor: 2,
                ),
                height: 50,
              ),
              Column(
                // Ingredients
                children: dish.compositionStats.entries
                  .map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key.id))),
                          Text('${e.value.format(#g_per_hg)}'),
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
                children: dish.ingredients.entries
                  .map((e) =>
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text(TL8(e.key.id))),
                          Text('${e.value.format(#g)}'),
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
