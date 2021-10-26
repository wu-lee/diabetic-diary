import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/moor_database.dart';
import 'package:diabetic_diary/dimensions.dart';
import 'package:diabetic_diary/dish.dart';
import 'package:diabetic_diary/meal.dart';
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

      print(inThing1.format());
      if (outThing1!=null) print(outThing1.format());
      expect(outThing1, inThing1);

      final count = await mdb.dimensions.count();
      expect(count, 2);
      expect(await mdb.dimensions.containsId(#testDim1), true);
      expect(await mdb.dimensions.containsId(#testDim2), true);

      final allThings = await mdb.dimensions.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testDim1], inThing1);
      expect(allThings[#testDim2], inThing2);

      expect(await mdb.dimensions.remove(#testDim1), 2);
      expect(await mdb.dimensions.remove(#testDim1), 0);

      expect(await mdb.dimensions.get(#testDim1, inThing2), inThing2);
      expect(await mdb.dimensions.get(#testDim2, inThing1), inThing2);

      expect(await mdb.dimensions.containsId(#testDim1), false);
      expect(await mdb.dimensions.containsId(#testDim2), true);

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

      expect(await mdb.units.containsId(#testUnit1), true);
      expect(await mdb.units.containsId(#testUnit2), true);

      final allThings = await mdb.units.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testUnit1], inThing1);
      expect(allThings[#testUnit2], inThing2);

      expect(await mdb.units.remove(#testUnit1), 1);
      expect(await mdb.units.remove(#testUnit1), 0);

      expect(await mdb.units.containsId(#testUnit1), false);
      expect(await mdb.units.containsId(#testUnit2), true);

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

      expect(await mdb.measurables.containsId(#testMeasurable1), true);
      expect(await mdb.measurables.containsId(#testMeasurable2), true);

      final allThings = await mdb.measurables.getAll();

      expect(allThings.length, 2);
      expect(allThings[#testMeasurable1], inThing1);
      expect(allThings[#testMeasurable2], inThing2);

      expect(await mdb.measurables.remove(#testMeasurable1), 1);
      expect(await mdb.measurables.remove(#testMeasurable1), 0);

      expect(await mdb.measurables.containsId(#testMeasurable1), false);
      expect(await mdb.measurables.containsId(#testMeasurable2), true);

      expect(await mdb.measurables.get(#testMeasurable1, inThing2), inThing2);
      expect(await mdb.measurables.get(#testMeasurable2, inThing1), inThing2);

      expect(await mdb.measurables.fetch(#testMeasurable2), inThing2);
      expect(() async => await mdb.measurables.fetch(#testMeasurable1), throwsA(TypeMatcher<ArgumentError>()));
    });

    test('Just BasicIngredients', () async {
      final inThing1 = BasicIngredient(
          id: #testBasicIngredient1,
          contents: {
            #testContent1: Quantity(1, Units(#g, #Mass, 1)),
            #testContent2: Quantity(2, Units(#Pa, #Pressure, 1)),
            #testContent3: Quantity(3, Units(#gg, #MassByFraction, 1)),
          }
      );
      final inThing2 = BasicIngredient(
          id: #testBasicIngredient2,
          contents: {
            #testContent1: Quantity(1, Units(#kg, #Mass, 1000)),
            #testContent3: Quantity(3, Units(#ghg, #MassByFraction, .01)),
            #testContent4: Quantity(4, Units(#kj, #Energy, 1)),
          }
      );
      final removed = await mdb.ingredients.removeAll();
      print("removed basic ingredients "+removed.toString());
      await mdb.ingredients.add(inThing1);
      await mdb.ingredients.add(inThing2);
      final outThing = await mdb.ingredients.maybeGet(#testBasicIngredient1);

      print(inThing1.format());
      if (outThing!=null) print(outThing.format());
      expect(outThing, inThing1, reason: 'outThing mismatches inThing1');

      expect(await mdb.ingredients.containsId(#testBasicIngredient1), true);
      expect(await mdb.ingredients.containsId(#testBasicIngredient2), true);

      final count = await mdb.ingredients.count();
      expect(count, 2, reason: 'counting ingredients');

      final allThings = await mdb.ingredients.getAll();

      expect(allThings.length, 2, reason: 'checking number of allThings');
      expect(allThings[#testBasicIngredient1], inThing1, reason: 'checking allThings includes inThing1');
      expect(allThings[#testBasicIngredient2], inThing2, reason: 'checking allThings includes inThing2');

      expect(await mdb.ingredients.remove(#testBasicIngredient1), 4, reason: 'removing #testBasicIngredient1');
      expect(await mdb.ingredients.remove(#testBasicIngredient1), 0, reason: 'removing #testBasicIngredient1 again');

      expect(await mdb.ingredients.containsId(#testBasicIngredient1), false);
      expect(await mdb.ingredients.containsId(#testBasicIngredient2), true);

      expect(await mdb.ingredients.get(#testBasicIngredient1, inThing2), inThing2, reason: 'getting #testBasicIngredient1 defaults');
      expect(await mdb.ingredients.get(#testBasicIngredient2, inThing1), inThing2, reason: 'getting #testBasicIngredient2 succeeds');

      expect(await mdb.ingredients.fetch(#testBasicIngredient2), inThing2, reason: 'fetching #testBasicIngredient2 succeeds');
      expect(() async => await mdb.ingredients.fetch(#testBasicIngredient1), throwsA(TypeMatcher<ArgumentError>()), reason: 'fetching #testBasicIngredient1 throws');

    });

    test('Just Dishes', () async {
      final inThing1 = Dish(
          id: #testDish1,
          contents: {
            #testContent1: Quantity(1, Units(#g, #Mass, 1)),
            #testContent2: Quantity(2, Units(#Pa, #Pressure, 1)),
            #testContent3: Quantity(3, Units(#gg, #MassByFraction, 1)),
          }
        );
      final inThing2 = Dish(
          id: #testDish2,
          contents: {
            #testContent1: Quantity(1, Units(#kg, #Mass, 1000)),
            #testContent3: Quantity(3, Units(#ghg, #MassByFraction, .01)),
            #testContent4: Quantity(4, Units(#kj, #Energy, 1)),
          }
      );
      final removed = await mdb.dishes.removeAll();
      print("removed dishes "+removed.toString());
      await mdb.dishes.add(inThing1);
      await mdb.dishes.add(inThing2);
      final outThing = await mdb.dishes.maybeGet(#testDish1);

      print(inThing1.format());
      if (outThing!=null) print(outThing.format());
      expect(outThing, inThing1, reason: 'outThing mismatches inThing1');

      expect(await mdb.dishes.containsId(#testDish1), true);
      expect(await mdb.dishes.containsId(#testDish2), true);

      final count = await mdb.dishes.count();
      expect(count, 2, reason: 'counting dishes');

      final allThings = await mdb.dishes.getAll();

      expect(allThings.length, 2, reason: 'checking number of allThings');
      expect(allThings[#testDish1], inThing1, reason: 'checking allThings includes inThing1');
      expect(allThings[#testDish2], inThing2, reason: 'checking allThings includes inThing2');

      expect(await mdb.dishes.remove(#testDish1), 4, reason: 'removing #testDish1');
      expect(await mdb.dishes.remove(#testDish1), 0, reason: 'removing #testDish1 again');

      expect(await mdb.dishes.containsId(#testDish1), false);
      expect(await mdb.dishes.containsId(#testDish2), true);

      expect(await mdb.dishes.get(#testDish1, inThing2), inThing2, reason: 'getting #testDish1 defaults');
      expect(await mdb.dishes.get(#testDish2, inThing1), inThing2, reason: 'getting #testDish2 succeeds');

      expect(await mdb.dishes.fetch(#testDish2), inThing2, reason: 'fetching #testDish2 succeeds');
      expect(() async => await mdb.dishes.fetch(#testDish1), throwsA(TypeMatcher<ArgumentError>()), reason: 'fetching #testDish1 throws');

    });

    test('Just Meals', () async {
      final inThing1 = Meal(
          id: #testMeal1,
          title: 'Test Meal 1',
          timestamp: DateTime(2021, 8, 1, 15, 45),
          notes: 'Test notes 1',
          contents: {
            #testContent1: Quantity(1, Units(#g, #Mass, 1)),
            #testContent2: Quantity(2, Units(#Pa, #Pressure, 1)),
            #testContent3: Quantity(3, Units(#gg, #MassByFraction, 1)),
          }
      );
      final inThing2 = Meal(
          id: #testMeal2,
          title: 'Test Meal 2',
          timestamp: DateTime(2021, 8, 1, 18, 30),
          notes: 'Test notes 2',
          contents: {
            #testContent1: Quantity(1, Units(#kg, #Mass, 1000)),
            #testContent3: Quantity(3, Units(#ghg, #MassByFraction, .01)),
            #testContent4: Quantity(4, Units(#kj, #Energy, 1)),
          }
      );
      final removed = await mdb.meals.removeAll();
      print("removed meals "+removed.toString());
      await mdb.meals.add(inThing1);
      await mdb.meals.add(inThing2);
      final outThing = await mdb.meals.maybeGet(#testMeal1);

      print(inThing1.format());
      if (outThing!=null) print(outThing.format());
      expect(outThing, inThing1, reason: 'outThing mismatches inThing1');

      expect(await mdb.meals.containsId(#testMeal1), true);
      expect(await mdb.meals.containsId(#testMeal2), true);

      final count = await mdb.meals.count();
      expect(count, 2, reason: 'counting meals');

      final allThings = await mdb.meals.getAll();

      expect(allThings.length, 2, reason: 'checking number of allThings');
      expect(allThings[#testMeal1], inThing1, reason: 'checking allThings includes inThing1');
      expect(allThings[#testMeal2], inThing2, reason: 'checking allThings includes inThing2');

      expect(await mdb.meals.remove(#testMeal1), 4, reason: 'removing #testMeal1');
      expect(await mdb.meals.remove(#testMeal1), 0, reason: 'removing #testMeal1 again');

      expect(await mdb.meals.containsId(#testMeal1), false);
      expect(await mdb.meals.containsId(#testMeal2), true);

      expect(await mdb.meals.get(#testMeal1, inThing2), inThing2, reason: 'getting #testMeal1 defaults');
      expect(await mdb.meals.get(#testMeal2, inThing1), inThing2, reason: 'getting #testMeal2 succeeds');

      expect(await mdb.meals.fetch(#testMeal2), inThing2, reason: 'fetching #testMeal2 succeeds');
      expect(() async => await mdb.meals.fetch(#testMeal1), throwsA(TypeMatcher<ArgumentError>()), reason: 'fetching #testMeal1 throws');

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
