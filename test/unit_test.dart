import 'package:diabetic_diary/entities/ingredient.dart';
import 'package:diabetic_diary/measurement_type.dart';
import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';

const Distance = Dimensions(id: #Distance, units: {#m: 1, #km: 1000}, components: {#Distance:1});
final meters = Distance.units(#m);
final  kilometers = Distance.units(#km);

void main() {
  group('Quantity operations', () {
    test('Equating meters', () {
      expect(meters.times(1), meters.times(1));
    });
/*    test('Adding meters and kilometers', () {
      expect((meters.of(1) + kilometers.of(1)).amount, meters.of(1001).amount);
    });*/
    test('Aggregating ingredients', () {
      final mass = Dimensions(
        id: #Mass,
        units: {
          #grams: 1/100,
          #micrograms: 1,
        },
        components: {#Mass:1},
      );
      final massFraction = Dimensions(
        id: #FractionByMass,
        units: {
          #gramsPerHectagram: 1/100,
          #gramsPerGram: 1,
          #microgramsPerHectagram: 0.001/100,
        },
        components: {},
      );
      final energyFraction = Dimensions(
        id: #EnergyByMass,
        units: {
          #joulesPerGram: 1,
          #joulesPerHectagram: 1/100,
          #kcalPerGram: 4184,
          #kcalPerHectagram: 4184/100,
        },
        components: {},
      );
      final carbs = MeasurementType(id: #Carbs, units: massFraction.units(#gramsPerHectagram));
      final fat = MeasurementType(id: #Fat, units: massFraction.units(#gramsPerHectagram));
      final energy = MeasurementType(id: #Energy, units: energyFraction.units(#kcalPerHectagram));
      final cabbage = Ingredient(
          id: #Cabbage,
          compositionStats: {
            carbs: massFraction.of(10, #gramsPerHectagram),
            fat: massFraction.of(0, #gramsPerHectagram),
            energy: energyFraction.of(30, #kcalPerHectagram),
          }
      );
      final tahini = Ingredient(
          id: #Tahini,
          compositionStats: {
            carbs: massFraction.of(10, #gramsPerHectagram),
            fat: massFraction.of(0.8, #gramsPerGram),
            energy: energyFraction.of(100, #kcalPerHectagram),
          }
      );
      final ingredients = {
        cabbage: mass.of(100, #grams),
        tahini: mass.of(100, #grams),
      };
      final aggregateStats = Ingredient.aggregate(ingredients);

      print("cabbage: "+MeasurementType.format(cabbage.compositionStats));
      print("tahini: "+MeasurementType.format(tahini.compositionStats));
      print(Ingredient.format(ingredients));
      print(MeasurementType.format(aggregateStats));
      expect(aggregateStats, {
        carbs: massFraction.of(20, #gramsPerHectagram),
        fat: massFraction.of(.8, #gramsPerGram),
        energy: energyFraction.of(130, #kcalPerHectagram),
      });
    });
  });
}
