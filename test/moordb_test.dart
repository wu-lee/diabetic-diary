import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/moor_database.dart';
import 'package:diabetic_diary/entities/ingredient.dart';
import 'package:diabetic_diary/measurement_type.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';


void main() async {
  Database db = MoorDatabase.create();

  group('Quantity operations', () {
    test('Initialise data', () async {
      Database.initialiseData(db);

      final cabbage = await db.ingredients.fetch(#Cabbage);

      print("cabbage: "+MeasurementType.format(cabbage.compositionStats));
      expect(cabbage.id, #Cabbage);
    });
  });
}
