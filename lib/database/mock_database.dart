 
import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../unit.dart';

class MockDatabase implements Database {

  static final _dimensions = MockDataCollection<Symbol, Dimensions>();

  static final _ingredients = MockDataCollection<Symbol, Ingredient>();

  static final _dishes = MockDataCollection<Symbol, Dish>();

  static final _compositionStatistics = MockDataCollection<Symbol, MeasurementType>();

  static final _measurementTypes = MockDataCollection<Symbol, MeasurementType>();

  @override
  DataCollection<Symbol, Dimensions> get dimensions => _dimensions;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get measurementTypes => _measurementTypes;

  @override
  DataCollection<Symbol, Ingredient> get ingredients => _ingredients;

  @override
  DataCollection<Symbol, Dish> get dishes => _dishes;

  @override
  DataCollection<Symbol, MeasurementType<Dimensions>> get compositionStatistics => _compositionStatistics;

}

class MockDataCollection<I, T> implements DataCollection<I, T> {
  final Map<I, T> map;

  MockDataCollection([this.map = const {}]);

  static MockDataCollection<Symbol, T> fromIndexables<T extends Indexable>(Set<T> items) {
    return MockDataCollection(
        Map.fromEntries(
            items.map((e) => MapEntry(e.id, e))
        )
    );
  }

  I add(T value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Map<I, T> cannedQuery(Symbol id, [List parameters]) {
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
  T fetch(I index) {
    if (map.containsKey(index)) return map[index];
    throw RangeError("No item with index $index");
  }

  @override
  void put(I index, T value) {
    map[index] = value;
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
