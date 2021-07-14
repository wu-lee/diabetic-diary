import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/moor_database.dart';
import 'package:diabetic_diary/dimensions.dart';
import 'package:diabetic_diary/edible.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/quantity.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/units.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

void main() async {
  Database mdb = MoorDatabase.create();
  Database.initialiseData(mdb);

  group('Quantity operations', () {
    test('Just Dimensions', () async {
      final inThing1 = Dimensions(id: #testDim1, components: {#TestComp1: 1, #TestComp2: 2});
      final inThing2 = Dimensions(id: #testDim2, components: {#TestComp1: 2, #TestComp3: 1});
      final removed = await mdb.dimensions.removeAll();
      print("removed "+removed.toString());
      await mdb.dimensions.add(inThing1);
      await mdb.dimensions.add(inThing2);
      final outThing1 = await mdb.dimensions.maybeGet(#testDim1);

      print(mdb.formatDimensions(inThing1));
      if (outThing1!=null) print(mdb.formatDimensions(outThing1));
      expect(outThing1, inThing1);

      final count = await mdb.dimensions.count();
      expect(count, 2);

      final allThings = await mdb.dimensions.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testDim1], inThing1);
      expect(allThings[#testDim2], inThing2);

      expect(await mdb.dimensions.remove(#testDim1), 2);
      expect(await mdb.dimensions.remove(#testDim1), 0);

      expect(await mdb.dimensions.get(#testDim1, inThing2), inThing2);
      expect(await mdb.dimensions.get(#testDim2, inThing1), inThing2);

      expect(await mdb.dimensions.fetch(#testDim2), inThing2);
      expect(() async => await mdb.dimensions.fetch(#testDim1), throwsA(TypeMatcher<ArgumentError>()));

    });

    test('Just Units', () async {
      final inThing1 = Units(#testUnit1, #TestDimension1, 1);
      final inThing2 = Units(#testUnit2, #TestDimension2, 2);
      final removed = await mdb.units.removeAll();
      print("removed "+removed.toString());
      await mdb.units.add(inThing1);
      await mdb.units.add(inThing2);
      final outThing1 = await mdb.units.maybeGet(#testUnit1);

      expect(outThing1, inThing1);

      final count = await mdb.units.count();
      expect(count, 2);

      final allThings = await mdb.units.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testUnit1], inThing1);
      expect(allThings[#testUnit2], inThing2);

      expect(await mdb.units.remove(#testUnit1), 1);
      expect(await mdb.units.remove(#testUnit1), 0);

      expect(await mdb.units.get(#testUnit1, inThing2), inThing2);
      expect(await mdb.units.get(#testUnit2, inThing1), inThing2);

      expect(await mdb.units.fetch(#testUnit2), inThing2);
      expect(() async => await mdb.units.fetch(#testUnit1), throwsA(TypeMatcher<ArgumentError>()));

    });


    test('Just Measurables', () async {
      final inThing1 = Measurable(id: #testMeasurable1, dimensionsId: #TestDimension1);
      final inThing2 = Measurable(id: #testMeasurable2, dimensionsId: #TestDimension2);
      final removed = await mdb.measurables.removeAll();
      print("removed "+removed.toString());
      await mdb.measurables.add(inThing1);
      await mdb.measurables.add(inThing2);
      final outThing1 = await mdb.measurables.maybeGet(#testMeasurable1);

      expect(outThing1, inThing1);

      final count = await mdb.measurables.count();
      expect(count, 2);

      final allThings = await mdb.measurables.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testMeasurable1], inThing1);
      expect(allThings[#testMeasurable2], inThing2);

      expect(await mdb.measurables.remove(#testMeasurable1), 1);
      expect(await mdb.measurables.remove(#testMeasurable1), 0);

      expect(await mdb.measurables.get(#testMeasurable1, inThing2), inThing2);
      expect(await mdb.measurables.get(#testMeasurable2, inThing1), inThing2);

      expect(await mdb.measurables.fetch(#testMeasurable2), inThing2);
      expect(() async => await mdb.measurables.fetch(#testMeasurable1), throwsA(TypeMatcher<ArgumentError>()));
    });

    test('Just Edibles', () async {
      final inThing1 = Edible(
          id: #testEdible1,
          contents: {
            #testContent1: Quantity(1, Units(#g, #Mass, 1)),
            #testContent2: Quantity(2, Units(#Pa, #Pressure, 1)),
            #testContent3: Quantity(3, Units(#gg, #MassByFraction, 1)),
          }
        );
      final inThing2 = Edible(
          id: #testEdible2,
          contents: {
            #testContent1: Quantity(1, Units(#kg, #Mass, 1000)),
            #testContent3: Quantity(3, Units(#ghg, #MassByFraction, .01)),
            #testContent4: Quantity(4, Units(#kj, #Energy, 1)),
          }
      );
      final removed = await mdb.edibles.removeAll();
      print("removed "+removed.toString());
      await mdb.edibles.add(inThing1);
      await mdb.edibles.add(inThing2);
      final outThing = await mdb.edibles.maybeGet(#testEdible1);

      print(await mdb.formatEdible(inThing1));
      if (outThing!=null) print(await mdb.formatEdible(outThing));
      expect(outThing, inThing1);

      final count = await mdb.edibles.count();
      expect(count, 2);

      final allThings = await mdb.edibles.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testEdible1], inThing1);
      expect(allThings[#testEdible2], inThing2);

      expect(await mdb.edibles.remove(#testEdible1), 3);
      expect(await mdb.edibles.remove(#testEdible1), 0);

      expect(await mdb.edibles.get(#testEdible1, inThing2), inThing2);
      expect(await mdb.edibles.get(#testEdible2, inThing1), inThing2);

      expect(await mdb.edibles.fetch(#testEdible2), inThing2);
      expect(() async => await mdb.edibles.fetch(#testEdible1), throwsA(TypeMatcher<ArgumentError>()));

    });
/*
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
    });*/
  });
}
