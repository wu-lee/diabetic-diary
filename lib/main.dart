
import 'package:flutter/widgets.dart';
import 'app.dart';
import 'database.dart';
import 'database/hive_database.dart';

void main() async {
  Database db = await HiveDatabase.create();
  runApp(App(title: 'Diabetic Diary', db: db));
}