
import 'package:diabetic_diary/database/mock_database.dart';
import 'package:flutter/widgets.dart';
import 'app.dart';
import 'database.dart';
import 'database/hive_database.dart';

void main() async {
  //Database db = MockDatabase();
  Database db = await HiveDatabase.create();
  Database.initialiseData(db);
  runApp(App(title: 'Diabetic Diary', db: db));
}