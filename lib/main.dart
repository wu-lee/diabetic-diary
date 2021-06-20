
import 'package:diabetic_diary/database/mock_database.dart';
import 'package:flutter/widgets.dart';
import 'app.dart';
import 'database.dart';

void main() async {
  Database db = MockDatabase();
  Database.initialiseData(db);
  runApp(App(title: 'Diabetic Diary', db: db));
}