
import 'indexable.dart';
import 'ingredient.dart';
import 'measurement_type.dart';
import 'unit.dart';

typedef DataMapper = R Function<I, T, R>(I, T);

abstract class DataCollection<I, T> {
  /// Count all items
  int count();

  /// Get a named item, or the otherwise value if absent
  T get(I index, [T otherwise = null]); // ignore: avoid_init_to_null

  /// Get all items as a map
  Map<I, T> getAll();

  /// Put a named item
  void put(I index, T value);

  /// Put an unnamed item, generating a name for it
  I add(T value);

  /// Remove a named item
  void remove(I index);

  /// Remove all items, returning the number
  int removeAll();

  /// Retrieve all items of the collection in some arbitrary order, and pass to the visitor
  forEach(void Function(I, T) visitor);

  /// Invoke a named predefined query with some parameters. May throw an exception if this
  /// name doesn't exist or the parameters are wrong.
  Map<I, T> cannedQuery(Symbol name, [List<dynamic> parameters]);
}

class Database {
  Database({this.dimensions, this.measurementTypes, this.ingredients, this.dishes, this.contentStatistics});

  final DataCollection<Symbol, Dimension> dimensions;
  final DataCollection<Symbol, MeasurementType> measurementTypes;
  final DataCollection<Symbol, MeasurementType> contentStatistics;
  final DataCollection<Symbol, Ingredient> ingredients;
  final DataCollection<Symbol, Dish> dishes;
}


class MockDataCollection<I, T> implements DataCollection<I, T> {
  final Map<I, T> map;

  MockDataCollection(this.map);

  static MockDataCollection<Symbol, T> fromIndexables<T extends Indexable>(Set<T> items) {
      return MockDataCollection(
          Map.fromEntries(
              items.map((e) => MapEntry(e.name, e))
          )
      );
  }

  I add(T value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Map<I, T> cannedQuery(Symbol name, [List parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  int count() => map.length;

  @override
  forEach(void Function(I ix, T val) visitor) {
    map.forEach(visitor);
  }

  @override
  T get(I index, [T otherwise]) {
    return map.containsKey(index)? map[index] : otherwise;
  }

  @override
  void put(I index, T value) {
    // TODO: implement put
  }

  @override
  void remove(I index) {
    // TODO: implement remove
  }

  @override
  int removeAll() {
    // TODO: implement removeAll
    throw UnimplementedError();
  }

  @override
  Map<I, T> getAll() {
    return Map.of(map);
  }

}

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
        _measurementTypes.get(#carbs): Mass.grams(6),
      },
    ),
    Ingredient(
      name: #Tahini,
      compositionStats: {
        _measurementTypes.get(#Carbs): Mass.grams(0),
      },
    ),
  });

  static final _dishes = MockDataCollection.fromIndexables({
    Dish(
      name: #Salad,
      ingredients: {
        _ingredients.get(#cabbage): Mass.grams(200),
      },
    ),
  });

  static final _contentStatistics = MockDataCollection.fromIndexables({
    MeasurementType(name: #Carbs, units: _dimensions.get(#FractionByMass)),
    MeasurementType(name: #Fat, units: _dimensions.get(#FractionByMass)),
    MeasurementType(name: #Fibre, units: _dimensions.get(#FractionByMass)),
    MeasurementType(name: #Protein, units: _dimensions.get(#FractionByMass)),
    MeasurementType(name: #Sugar, units: _dimensions.get(#FractionByMass)),
  });

  static final _measurementTypes = MockDataCollection.fromIndexables({
    MeasurementType(name: #BodyMass, units: _dimensions.get(#Mass)),
    MeasurementType(name: #BloodGlucose, units: _dimensions.get(#MolesByVolume)),
  }..addAll(_contentStatistics.map.values));

  @override
  DataCollection<Symbol, Dimension> get dimensions => _dimensions;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get measurementTypes => _measurementTypes;

  @override
  DataCollection<Symbol, Ingredient> get ingredients => _ingredients;

  @override
  DataCollection<Symbol, Dish> get dishes => _dishes;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get contentStatistics => _contentStatistics;

}
