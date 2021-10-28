import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/database/mock_database.dart';
import 'package:diabetic_diary/dimensions.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/quantity.dart';
import 'package:diabetic_diary/units.dart';

import 'package:test/test.dart';

const Distance = Dimensions(id: #Distance, components: {#Distance:1});
final meters = Units(#m, Distance.id, 1);
final  kilometers = Units(#km, Distance.id, 1000);
final db = MockDatabase(version: 1, deployedVersion: 1);


void main() async {
  await Database.initialiseData(db);

  group('Quantity operations', () {
    test('Equating meters', () {
      expect(meters.times(1), meters.times(1));
    });
    test('Adding meters and kilometers', () {
      final q1 = meters.times(1).addQuantity(kilometers.times(1));
      final q2 = meters.times(1001);
      expect(q1, q2);
      expect(q1.amount, 1001);
      expect(q1.units, meters);
    });
    test('Adding kilometers and meters', () {
      final q1 = kilometers.times(1).addQuantity(meters.times(1));
      final q2 = kilometers.times(1.001);
      expect(q1, q2);
      expect(q1.amount, 1.001);
      expect(q1.units, kilometers);
    });
    test('Aggregating ingredients', () async {
      Database db = MockDatabase(version: 1, deployedVersion: 1);
      final mass = Dimensions(
        id: #Mass,
        components: {#Mass:1},
      );
      final grams = mass.units(#grams, 1/100);
      final micrograms = mass.units(#micrograms, 1);
      final massFraction = Dimensions(
        id: #FractionByMass,
        components: {},
      );
      final gramsPerHectagram = massFraction.units(#gramsPerHectagram, 1/100);
      final gramsPerGram = massFraction.units(#gramsPerGram, 1);
      final microgramsPerHectagram = massFraction.units(#microgramsPerHectagram, 0.001/100);
      final energyFraction = Dimensions(
        id: #EnergyByMass,
        components: {},
      );
      final joulesPerGram = energyFraction.units(#joulesPerGram, 1);
      final joulesPerHectagram = energyFraction.units(#joulesPerHectagram, 1/100);
      final kcalPerGram = energyFraction.units(#kcalPerGram, 4184);
      final kcalPerHectagram = energyFraction.units(#kcalPerHectagram, 4184/100);
      final carbs = Measurable(id: #Carbs, dimensionsId: massFraction.id);
      final fat = Measurable(id: #Fat, dimensionsId: massFraction.id);
      final energy = Measurable(id: #Energy, dimensionsId: energyFraction.id);
      final cabbage = BasicIngredient(
          id: #Cabbage,
          aggregateContents: {
            carbs.id: Quantity(10, gramsPerHectagram),
            fat.id: Quantity(0, gramsPerHectagram),
            energy.id: Quantity(30, kcalPerHectagram),
          }
      );
      final tahini = BasicIngredient(
          id: #Tahini,
          aggregateContents: {
            carbs.id: Quantity(10, gramsPerHectagram),
            fat.id: Quantity(0.8, gramsPerGram),
            energy.id: Quantity(100, kcalPerHectagram),
          }
      );
      db.dimensions..add(mass)..add(massFraction)..add(energyFraction);
      db.units..add(grams)..add(micrograms)..add(gramsPerGram)..add(gramsPerGram)..add(gramsPerHectagram);
      db.units..add(joulesPerGram)..add(joulesPerHectagram)..add(kcalPerGram)..add(kcalPerHectagram);
      db.measurables..add(carbs)..add(fat)..add(energy);
      db.ingredients..add(cabbage)..add(tahini);

      final ingredients = {
        cabbage.id: Quantity(50, gramsPerHectagram),
        tahini.id: Quantity(50, gramsPerHectagram),
      };
      final aggregateStats = await db.aggregate(ingredients);

      print("cabbage: "+cabbage.format());
      print("tahini: "+tahini.format());
      expect(aggregateStats, {
        carbs.id: Quantity(10, gramsPerHectagram),
        fat.id: Quantity(40, gramsPerHectagram),
        energy.id: Quantity(65, kcalPerHectagram),
      });
    });
  });
}
