import 'dart:math';

import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/composite_edible.dart';
import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/mock_database.dart';
import 'package:diabetic_diary/dish.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/quantified.dart';
import 'package:diabetic_diary/quantity.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/units.dart';

Map<Symbol, Quantity> trunc(Map<Symbol, Quantity> contents, [int zeros = 3]) {
  final mult = pow(10, zeros);
  return contents.map((id, q) => MapEntry(id, Quantity((q.amount * mult).floor()/mult, q.units)));
}

void main() async {
  Database mdb = MockDatabase(version: 1, deployedVersion: 1);
  await mdb.clear();
  await Database.initialiseData(mdb);

  // Define common database
  await mdb.clear();
  final ingredient1 = BasicIngredient(
      id: #Ingredient1, label: "Ingredient1",
      portionSize: 50,
      contents: {
        Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
        Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
      }
  );
  final ingredient2 = BasicIngredient(
      id: #Ingredient2, label: "Ingredient2",
      portionSize: 70,
      contents: {
        Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
        Measurable.Protein.id: Quantity(3, Units.GramsPerHectogram),
        Measurable.Fibre.id: Quantity(4, Units.GramsPerHectogram),
        Measurable.Energy.id: Quantity(100, Units.KilocaloriesPerHectogram),
      }
  );
  final ingredient3 = BasicIngredient(
      id: #Ingredient3, label: "Ingredient3",
      portionSize: 190,
      contents: {
        Measurable.Carbs.id: Quantity(500, Units.GramsPerKilogram),
        Measurable.Protein.id: Quantity(2, Units.GramsPerKilogram),
        Measurable.Energy.id: Quantity(500, Units.CaloriesPerGram),
      }
  );
  final dish1 = Dish(
    id: #Dish1, label: "Dish1",
    portions: 4,
    contents: {
      ingredient1.id: Quantity(2, Units.NumPortions),
      ingredient3.id: Quantity(5, Units.Grams),
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
  await mdb.dishes.add(dish1);
  await mdb.validateEdibles([ingredient1, ingredient2, ingredient3, dish1]);

  final totalMassDish1 = await mdb.getTotalMass(dish1.contents); // In grams
  final totalMassIngredient3 = await mdb.getTotalMass(ingredient3.contents); // In grams
  final expectedDish1Stats = () {
    final amountIng1 = 50 * 2; // grams
    final amountIng2 = 5; // grams

    return {
      // Aggregated amounts - see comment above. Although
      // here we have to be more careful to multiply out the amounts
      // when in different units, and also factor in the portionSize where applicable
      Measurable.Carbs.id: Quantity(
          (amountIng1 * 1 * Units.GramsPerHectogram.multiplier +
              amountIng2 * 500 * Units.GramsPerKilogram.multiplier)
              / (totalMassDish1 * Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(
          (amountIng1 * 3 * Units.GramsPerHectogram.multiplier +
              0)
              / (totalMassDish1 * Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(
          (amountIng1 * 1 * Units.GramsPerHectogram.multiplier +
              amountIng2 * 2 * Units.GramsPerKilogram.multiplier)
              / (totalMassDish1 * Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(
          (amountIng1 * 300 * Units.KilocaloriesPerHectogram.multiplier +
              amountIng2 * 500 * Units.CaloriesPerGram.multiplier)
              / (totalMassDish1 * Units.KilocaloriesPerHectogram.multiplier),
          Units.KilocaloriesPerHectogram),
    };
  }();


  test('Aggregate #Ingredients1 * 1g', () async {
    final contents = {
      #Ingredient1: Quantity(1, Units.Grams),
    };
    final expectedStats = {
      Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
    };
    final aggregateStats = await mdb.aggregate(contents);
    print("expected "+Quantified.formatContents(expectedStats));
    print("actual "+Quantified.formatContents(aggregateStats));
    expect(aggregateStats, expectedStats);
  });

  test('Aggregate #Ingredients1 * 2g', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
    };
    final expectedStats = {
      Measurable.Carbs.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Fat.id: Quantity(3, Units.GramsPerHectogram),
      Measurable.Protein.id: Quantity(1, Units.GramsPerHectogram),
      Measurable.Energy.id: Quantity(300, Units.KilocaloriesPerHectogram),
    };
    final aggregateStats = await mdb.aggregate(contents);
    print("expected "+Quantified.formatContents(expectedStats));
    print("actual "+Quantified.formatContents(aggregateStats));
    expect(aggregateStats, expectedStats);
  });

  test('Aggregate #Ingredients1 * 2g + #Ingredients2 * .003kg', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
      #Ingredient2: Quantity(0.003, Units.Kilograms),
    };
    final totalMass = await mdb.getTotalMass(contents);
    print("total mass $totalMass g");
    final aggregateStats = await mdb.aggregate(contents);
    final expectedStats = {
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
    };
    print("expected "+Quantified.formatContents(expectedStats));
    print("actual "+Quantified.formatContents(aggregateStats));
    expect(aggregateStats, expectedStats);
  });

  test('Aggregate #Ingredients1 * 2g + #Ingredients3 * 5g', () async {
    final contents = {
      #Ingredient1: Quantity(2, Units.Grams),
      #Ingredient3: Quantity(5, Units.Grams),
    };
    final totalMass = await mdb.getTotalMass(contents); // In grams
    print("total mass $totalMass g");
    expect(totalMass, 2+5);

    final aggregateStats = await mdb.aggregate(contents);
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


  test('Aggregate #Ingredients1 * 2portions + #Ingredients3 * 5g', () async {
    final contents = dish1.contents;
    final totalMass = await mdb.getTotalMass(contents); // In grams
    print("total mass $totalMass g");
    expect(totalMass, 2*50 + 5);

    final aggregateStats = await mdb.aggregate(contents);
    final expectedStats = expectedDish1Stats;
    print("expected ${Quantified.formatContents(expectedStats)}");
    print("actual ${Quantified.formatContents(aggregateStats)}");

    expect(trunc(aggregateStats), trunc(expectedStats));
  });

  test('Aggregate #Dish1 * 2portions + #Ingredients3 * 2portions', () async {
    final contents = {
      #Dish1: Quantity(2, Units.NumPortions),
      #Ingredient3: Quantity(2, Units.NumPortions),
    };
    final totalMass = await mdb.getTotalMass(contents); // In grams
    final dish1PortionSize = totalMassDish1 / dish1.portions;
    print("total mass $totalMass g");
    expect(totalMass, 2*dish1PortionSize + 2*ingredient3.portionSize);

    final aggregateStats = await mdb.aggregate(contents);
    final expectedStats = {
      Measurable.Carbs.id: Quantity(
          (2 * expectedDish1Stats[Measurable.Carbs.id]!.toUnits(Units.GramsPerGram).amount * dish1PortionSize +
           2 * 500 * Units.GramsPerKilogram.multiplier * ingredient3.portionSize) /
              (totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram
      ),
      Measurable.Fat.id: Quantity(
          (2 * expectedDish1Stats[Measurable.Fat.id]!.toUnits(Units.GramsPerGram).amount
              * dish1PortionSize) /
              (totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram
      ),
      Measurable.Protein.id: Quantity(
          (2 * expectedDish1Stats[Measurable.Protein.id]!.toUnits(Units.GramsPerGram).amount * dish1PortionSize +
              2 * 2 * Units.GramsPerKilogram.multiplier * ingredient3.portionSize) /
              (totalMass*Units.GramsPerHectogram.multiplier),
          Units.GramsPerHectogram
      ),
      Measurable.Energy.id: Quantity(
          (2 * expectedDish1Stats[Measurable.Energy.id]!.toUnits(Units.JoulesPerGram).amount * dish1PortionSize +
              2 * 500 * Units.CaloriesPerGram.multiplier * ingredient3.portionSize) /
              (totalMass*Units.KilocaloriesPerHectogram.multiplier),
          Units.KilocaloriesPerHectogram
      ),
    };
    print("expected ${Quantified.formatContents(expectedStats)}");
    print("actual ${Quantified.formatContents(aggregateStats)}");

    expect(trunc(aggregateStats), trunc(expectedStats));
  });
}
