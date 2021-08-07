
import 'package:flutter/widgets.dart';
import 'app.dart';
import 'database.dart';
import 'database/moor_database.dart';

void main() async {
  Database db = MoorDatabase.create();
  Database.initialiseData(db);
  runApp(App(title: 'Diabetic Diary', db: db));
}