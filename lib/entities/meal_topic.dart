import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../calendar_strip.dart';
import '../database.dart';
import '../meal.dart';
import '../entity_topic.dart';
import '../translation.dart';
import '../utils.dart';
import 'meal_edit_screen.dart';
import 'meal_screen.dart';

class MealTopic implements EntityTopic<Meal> {
  static final _dateFormat = DateFormat('yyyy-MM-dd hh:mm');

  final Database db;
  DateTime selectedDate = DateTime.now();

  @override
  final Symbol id = #Meals;

  @override
  final IconData icon = Icons.shopping_cart;

  MealTopic({required this.entities, required this.db});

  @override
  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealEditScreen(
              db: db,
            ),
          ),
        );
      },
      tooltip: 'Add Meal',
    );
  }

  Widget buildRow(Meal entity, BuildContext context, int ix) {
    return  GestureDetector(
      child: Container(
        color: (ix % 2 == 0) ? Colors.lightBlueAccent : Colors.lightBlue,
//        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Row(
          children: [
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Text(_dateFormat.format(entity.timestamp.toLocal())),
            ),
            Expanded(
              child: Text(entity.label, textAlign: TextAlign.right),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealScreen(meal: entity, db: db),
          ),
        );
      },
    );
  }

  bool _isSelectedDate(Meal m) {
    return
        m.timestamp.year == selectedDate.year &&
        m.timestamp.month == selectedDate.month &&
        m.timestamp.day == selectedDate.day;
  }

  @override
  Widget buildTabContent(BuildContext context, StateSetter setBuilderState) {
    return FutureBuilder<Map<Symbol, Meal>>(
      future: entities.getAll(),
      builder: (BuildContext context, AsyncSnapshot<Map<Symbol, Meal>> snapshot) {
        final meals = snapshot.data?.values ?? [];
        final selectedDateMeals = meals.where(_isSelectedDate).toList();
        const duration = const Duration(days:1);
        return Column(
          children: [
            Container(
              child: CalendarStrip(
                selectedDate: selectedDate,
 //               startDate: today.subtract(duration),
//                endDate: selectedDate.add(duration),
                onDateSelected: (DateTime date) {
                  setBuilderState(() {
                    selectedDate = date;
                  });
                },
  //              onWeekSelected: onWeekSelect,
  //              dateTileBuilder: dateTileBuilder,
                iconColor: Colors.black87,
  //              monthNameWidget: _monthNameWidget,
                isDateMarked: (date) => meals.any((meal) =>
                  meal.timestamp.year == date.year &&
                  meal.timestamp.month == date.month &&
                  meal.timestamp.day == date.day
                ),
                containerDecoration: BoxDecoration(color: Colors.black12),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: selectedDateMeals.length,
                itemBuilder: (context, ix) {
                  return buildRow(selectedDateMeals[ix], context, ix);
                },
              ),
            ),
          ]
        );
      },
    );
  }

  @override
  final AsyncDataCollection<Meal> entities;
}