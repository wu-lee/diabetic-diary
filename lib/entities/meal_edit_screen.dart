import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import '../composite_edible.dart';
import '../database.dart';
import '../meal.dart';
import '../edible.dart';
import '../quantity.dart';
import '../translation.dart';

/// The screen for editing an Meal
class MealEditScreen extends StatefulWidget {
  final Database db;
  final Meal? meal;

  const MealEditScreen({Key? key, required this.db, this.meal}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    Meal? meal = this.meal;
    if (meal != null)
      return _MealEditState(db: db, meal: meal);
    return _MealEditState(db: db);
  }
}

/// Manages state for meal creation / amendment
class _MealEditState extends State<MealEditScreen> {
  Symbol id;
  final titleController = new TextEditingController();
  final notesController = new TextEditingController();

  final Database db;
  Map<Symbol, Quantity> _contents = {};
  Future<Map<Symbol, Quantity>> _pendingContentAmounts = Future.value({});
  Future<Map<Symbol, String>> _pendingCompositionStats = Future.value({});
  final _format = DateFormat("yyyy-MM-dd HH:mm");

  _MealEditState({required this.db, Meal? meal}) :
      id = Symbol(UniqueKey().toString())
  {
    if (meal != null) {
      this.meal = meal;
    }
  }

  String get title => titleController.text;
  set title(String newTitle) {
    titleController.text = newTitle;
  }

  DateTime timestamp = new DateTime.now();

  String get notes => notesController.text;
  set notes(String newNotes) {
    notesController.text = newNotes;
  }

  Map<Symbol, Quantity> get contents => _contents;
  set contents(Map<Symbol, Quantity> newContents) {
    _contents = newContents;

    // This case doesn't really need to be a future, only to allow code reuse
    // in _buildEntityList
    _pendingContentAmounts = Future.value(newContents);

    // This does, because the calculation is asynchronous. Add a handler to
    // update our state when it's done.
    final totalMass = CompositeEdible.getTotalMass(contents);
    _pendingCompositionStats = db.aggregate(newContents, totalMass).then(
      // Format the quantities into strings
        (stats) async {
          final Map<Symbol, String> result = {};
          for(final entry in stats.entries) {
            result[entry.key] = entry.value.format();
          }

          return result;
        }
    );
  }

  Meal get meal => Meal(
    id: id,
    title: titleController.text,
    timestamp: timestamp,
    notes: notesController.text,
    contents: Map.from(_contents), // Make a copy, since we're returning it
  );

  set meal(Meal e) {
    id = e.id;
    title = e.title;
    timestamp = e.timestamp;
    notes = e.notes;
    contents = e.contents;
  }

  Widget _buildCompositionStat(BuildContext context, Symbol id, String quantity) {
    return Text(quantity);
  }

  Widget _buildContentAmount(BuildContext context, Symbol id, Quantity quantity) {
    return SpinBox(
      min: 0,
      max: 100,
      decimals: 1,
      value: quantity.amount.toDouble(),
      onChanged: (value) {
        setState(() {
          if (value <= 0) {
            _contents.remove(id);
          }
          else {
            _contents[id] = Quantity(value, quantity.units);
          }

          this.contents = _contents; // updates the stats too
        });
      },

    );
  }

  Widget _buildEntityList<T>({
    required String title,
    required Future<Map<Symbol, T>> futureEntities,
    required Widget Function(BuildContext, Symbol, T) builder,
    required BuildContext context}) =>
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
            child: FutureBuilder<Map<Symbol, T>>( // Entities
              future: futureEntities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final entities = snapshot.data ?? {};
                  return ListView(
                    children: entities.entries.map((e) =>
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(TL8(e.key)),
                              ),
                              Expanded(
                                child: builder(context, e.key, e.value),
                              ),
                            ],
                          ),
                        ),
                    ).toList(),
                  );
                }
                if (snapshot.hasError) {
                  debugPrint("Error calculating stats: ${snapshot.error}\n${snapshot.stackTrace}");
                  return Text(TL8(#ErrorCalculatingStats, {#error: snapshot.error.toString()}));
                }
                return Text('...');
              },
            )
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(TL8(#NewMeal)+':'),
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
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 3, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(TL8(#MealTitle)),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(meal.title),
                        ),
                     ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(TL8(#MealTime)),
                        ),
                        Flexible(
                          flex: 1,
                          child: DateTimeField(
                            format: _format,
                            initialValue: meal.timestamp,
                            resetIcon: null,
                            onFieldSubmitted: (datetime) { if (datetime != null) timestamp = datetime; },
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(TL8(#MealNotes)),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: notesController,
                            //showCursor: true,
                            textAlignVertical: TextAlignVertical.bottom,
                            maxLines: 5,
                            minLines: 1,
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible( // Composition Stats
                flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<String>(
                  title: TL8(#CompositionStats),
                  futureEntities: _pendingCompositionStats,
                  builder: _buildCompositionStat,
                  context: context,
                ),
              ),
              Flexible( // Contents
                flex: 6,
                fit: FlexFit.tight,
                child: _buildEntityList<Quantity>(
                  title: TL8(#Contents),
                  futureEntities: _pendingContentAmounts,
                  builder: _buildContentAmount,
                  context: context,
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
                        TL8(#AvailableItems),
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                        child: FutureBuilder<Map<Symbol, Edible>>(
                        future: db.edibles.getAll().then((list) => list..removeWhere((k, v) => k == id)),
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
                                      final newContents = await _pendingContentAmounts;
                                      final quantity = newContents[e.id] ?? Quantity(0, gramsPerHectagram);
                                      newContents[e.id] = quantity.add(1);

                                      setState(() {
                                        contents = newContents;
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

  Future<bool> _onPop() async {
    final e = meal;
    await db.meals.add(e);
    Navigator.pop(context, e);
    return true;
  }
}
