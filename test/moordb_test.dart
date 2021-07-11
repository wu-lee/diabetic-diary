import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/moor_database.dart';
import 'package:diabetic_diary/entities/ingredient.dart';
import 'package:diabetic_diary/measurement_type.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

void main() async {
  Database mdb = MoorDatabase.create();

  group('Quantity operations', () {
    test('Just Dimension Units', () async {
      final inThing = Units(#testUnit, #TestDimension, 1);
      final removed = await mdb.units.removeAll();
      print("removed "+removed.toString());
      await mdb.units.add(inThing);
      final outThing = await mdb.units.maybeGet(#testUnit);

      expect(outThing, inThing);
    });

    test('Just Dimension Components', () async {
      final inThing = Dimensions(id: #testDim, components: {#TestComp1: 1});
      final removed = await mdb.dimensions.removeAll();
      print("removed "+removed.toString());
      await mdb.dimensions.add(inThing);
      final outThing = await mdb.dimensions.maybeGet(#testDim);

      print(mdb.formatDimensions(inThing));
      if (outThing!=null) print(mdb.formatDimensions(outThing));
      expect(outThing, inThing);
    });

    test('Just MeasurementType', () async {
      final inUnits = Units(#testUnit, #TestDimension, 1);
      final inThing = MeasurementType(id: #testMType, units: inUnits);
      final removed = await mdb.measurementTypes.removeAll();
      print("removed "+removed.toString());
      await mdb.measurementTypes.add(inThing);
      final outThing = await mdb.measurementTypes.maybeGet(#testUnit);

      print(mdb.formatMeasurementType(inThing));
      if (outThing!=null) print(mdb.formatMeasurementType(outThing));
      expect(outThing, inThing);
    });

    test('Initialise data', () async {
      Database.initialiseData(mdb);

      //final cabbage = await db.dimensions.fetch(#Mass);
      final dims = await mdb.dimensions.fetch(#Mass);
      print("c "+mdb.formatDimensions(dims));

      final units = await mdb.units.fetch(#g);
      final quantity = await mdb.quantity(5, #kg);
      print("c "+await mdb.formatQuantity(quantity));
      //      print("cabbage: "+MeasurementType.format(cabbage.compositionStats));
      //expect(cabbage.id, #Cabbage);
    });
  });

  group('Utils' , () {
    test('Find database', () async {
      final dbFolder = await getDatabasesPath();
      final dbLocation = p.join(dbFolder, 'dbnew.sqlite');
      print(dbLocation);
    });
  });
}
