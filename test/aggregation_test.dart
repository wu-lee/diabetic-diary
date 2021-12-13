import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/composite_edible.dart';
import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/mock_database.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/quantified.dart';
import 'package:diabetic_diary/quantity.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/units.dart';

void main() async {
  Database mdb = MockDatabase(version: 1, deployedVersion: 1);
  Database.initialiseData(mdb);

  // Define common database
  await mdb.clear();
  final ingredient1 = BasicIngredient(
      id: #Ingredient1, label: "Ingredient1",
      contents: {
        Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
        Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
      }
  );
  final ingredient2 = BasicIngredient(
      id: #Ingredient2, label: "Ingredient2",
      contents: {
        Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Protein.id: Quantity(3, Units.GramsPerHectogram),
        Measurable.Fibre.id: Quantity(4, Units.GramsPerHectogram),
        Measurable.Energy.id: Quantity(100, Units.KilocaloriesPerHectogram),
      }
  );
  final ingredient3 = BasicIngredient(
      id: #Ingredient3, label: "Ingredient3",
      contents: {
        Measurable.Carbs.id: Quantity(500, Units.GramsPerKilogram),
        Measurable.Protein.id: Quantity(2, Units.GramsPerKilogram),
        Measurable.Energy.id: Quantity(500, Units.CaloriesPerGram),
      }
  );
  final removed = await mdb.ingredients.removeAll();
  print("removed basic ingredients " + removed.toString());
  await mdb.measurables.add(Measurable.Carbs);
  await mdb.measurables.add(Measurable.Fat);
  await mdb.measurables.add(Measurable.Protein);
  await mdb.measurables.add(Measurable.Fibre);
  await mdb.measurables.add(Measurable.Energy);
  await mdb.ingredients.add(ingredient1);
  await mdb.ingredients.add(ingredient2);
  await mdb.ingredients.add(ingredient3);
  await mdb.validateEdibles([ingredient1, ingredient2, ingredient3]);

  test('Aggregate #Ingredients1 * 1g', () async {
    final contents = {
      #Ingredient1: Quantity(1, Units.Grams),
    };
    final aggregateStats = await mdb.aggregate(contents, CompositeEdible.getTotalMass(contents));
    print(Quantified.formatContents(aggregateStats));
    expect(aggregateStats, {
      Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
    });
  });

  test('Aggregate #Ingredients1 * 2g', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
    };
    final aggregateStats = await mdb.aggregate(contents, CompositeEdible.getTotalMass(contents));
    print(Quantified.formatContents(aggregateStats));
    expect(aggregateStats, {
      Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
    });
  });

  test('Aggregate #Ingredients1 * 2g + #Ingredients2 * .003kg', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
      #Ingredient2: Quantity(0.003, Units.Kilograms),
    };
    final totalMass = CompositeEdible.getTotalMass(contents); // In grams
    print("total mass $totalMass g");
    final aggregateStats = await mdb.aggregate(contents, totalMass);
    print(Quantified.formatContents(aggregateStats));
    expect(aggregateStats, {
      // Aggregated amounts are essentially averaged values
      // - so f.e. if they are the same in both ingredients, it stays put.
      // In other cases, for measurable A in ingredient X and Y,
      //    (X.totalMass * X[A].amount * X[A].units.multiplier +
      //     Y.totalMass * Y[A].amount * Y[A].units.multiplier) / (X.totalMass + Y.totalMass)
      Measurable.Carbs.id: Quantity((2*1 + 3*1)/totalMass, Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity((2*3 + 0)/totalMass, Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity((2*1 + 3*3)/totalMass, Units.GramsPerHectogram),
      Measurable.Fibre.id: Quantity((0 + 3*4)/totalMass, Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity((2*300 + 3*100)/totalMass, Units.KilocaloriesPerHectogram),
    });
  });

  test('Aggregate #Ingredients1 * 2g + #Ingredients3 * 5g', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
      #Ingredient3: Quantity(5, Units.Grams),
    };
    final totalMass = CompositeEdible.getTotalMass(contents); // In grams
    print("total mass $totalMass g");
    final aggregateStats = await mdb.aggregate(contents, totalMass);
    final expectedStats = {
      // Aggregated amounts - see comment above. Although
      // here we have to be more careful to multiply out the amounts
      // when in different units.
      Measurable.Carbs.id: Quantity(
          (2*1*Units.GramsPerHectogram.multiplier +
           5*500*Units.GramsPerKilogram.multiplier)
              /(totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(
          (2*3*Units.GramsPerHectogram.multiplier +
           0)
              /(totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(
          (2*1*Units.GramsPerHectogram.multiplier +
              5*2*Units.GramsPerKilogram.multiplier)
              /(totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(
          (2*300*Units.KilocaloriesPerHectogram.multiplier +
              5*500*Units.CaloriesPerGram.multiplier)
              /(totalMass*Units.KilocaloriesPerHectogram.multiplier),
          Units.KilocaloriesPerHectogram),
    };
    print("expected ${Quantified.formatContents(expectedStats)}");
    print("actual ${Quantified.formatContents(aggregateStats)}");
    expect(aggregateStats, expectedStats);
  });
}
