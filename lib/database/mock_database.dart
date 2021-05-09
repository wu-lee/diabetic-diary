
import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../measurement_type.dart';
import '../unit.dart';

class MockDatabase implements Database {

  static final _dimensions = MockDataCollection.fromIndexables({
    Time(),
    Distance(),
    Volume(),
    Mass(),
    MolesByVolume(),
    FractionByMass(),
  });

  static final _ingredients = MockDataCollection.fromIndexables({
    Ingredient(
      name: #Cabbage,
      compositionStats: {
        _measurementTypes.fetch(#Carbs): Mass.grams(6),
      },
    ),
    Ingredient(
      name: #Tahini,
      compositionStats: {
        _measurementTypes.fetch(#Carbs): Mass.grams(0),
      },
    ),
    Ingredient(
      name: #PeriPeri,
      compositionStats: {
        _measurementTypes.fetch(#Carbs): Mass.grams(12),
      },
    ),
    Ingredient(
      name: #Bread,
      compositionStats: {
        _measurementTypes.fetch(#Carbs): Mass.grams(60),
        _measurementTypes.fetch(#Fat): Mass.grams(20),
      },
    ),
    Ingredient(
      name: #Butter,
      compositionStats: {
        _measurementTypes.fetch(#Fat): Mass.grams(80),
      },
    ),
  });

  static final _dishes = MockDataCollection.fromIndexables({
    Dish(
      name: #Salad,
      ingredients: {
        _ingredients.fetch(#Cabbage): Mass.grams(200),
      },
    ),
    Dish(
      name: #Toast,
      ingredients: {
        _ingredients.fetch(#Bread): Mass.grams(200),
        _ingredients.fetch(#Butter): Mass.grams(20),
      },
    ),
  });

  static final _compositionStatistics = MockDataCollection.fromIndexables({
    MeasurementType(name: #Carbs, units: _dimensions.fetch(#FractionByMass)),
    MeasurementType(name: #Fat, units: _dimensions.fetch(#FractionByMass)),
    MeasurementType(name: #Fibre, units: _dimensions.fetch(#FractionByMass)),
    MeasurementType(name: #Protein, units: _dimensions.fetch(#FractionByMass)),
    MeasurementType(name: #Sugar, units: _dimensions.fetch(#FractionByMass)),
  });

  static final _measurementTypes = MockDataCollection.fromIndexables({
    MeasurementType(name: #BodyMass, units: _dimensions.fetch(#Mass)),
    MeasurementType(name: #BloodGlucose, units: _dimensions.fetch(#MolesByVolume)),
  }..addAll(_compositionStatistics.map.values));

  @override
  DataCollection<Symbol, Dimension> get dimensions => _dimensions;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get measurementTypes => _measurementTypes;

  @override
  DataCollection<Symbol, Ingredient> get ingredients => _ingredients;

  @override
  DataCollection<Symbol, Dish> get dishes => _dishes;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get compositionStatistics => _compositionStatistics;

}
