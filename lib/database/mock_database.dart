 
import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../unit.dart';

class MockDatabase implements Database {

  static final _dimensions = MockDataCollection<Dimensions>();

  static final _ingredients = MockDataCollection<Ingredient>();

  static final _dishes = MockDataCollection<Dish>();

  static final _compositionStatistics = MockDataCollection<MeasurementType>();

  static final _measurementTypes = MockDataCollection<MeasurementType>();

  static final _config = MockDataCollection<DPair>();

  @override
  DataCollection<Dimensions> get dimensions => _dimensions;

  @override
  DataCollection<MeasurementType> get measurementTypes => _measurementTypes;

  @override
  DataCollection<Ingredient> get ingredients => _ingredients;

  @override
  DataCollection<Dish> get dishes => _dishes;

  @override
  DataCollection<MeasurementType> get compositionStatistics => _compositionStatistics;

  @override
  DataCollection<DPair> get config => _config;
}

class MockDataCollection<T extends Indexable> implements DataCollection<T> {
  final Map<Symbol, T> map;

  MockDataCollection([Map<Symbol, T>? map]) : this.map = map ?? {};

  static MockDataCollection<T> fromIndexables<T extends Indexable>(Set<T> items) {
    return MockDataCollection(
        Map.fromEntries(
            items.map((e) => MapEntry(e.id, e))
        )
    );
  }

  Symbol add(T value) {
    map[value.id] = value;
    return value.id;
  }

  @override
  Map<Symbol, T> cannedQuery(Symbol id, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  int count() => map.length;

  @override
  forEach(void Function(Symbol ix, T val) visitor) {
    map.forEach(visitor);
  }

  @override
  T get(Symbol index, T otherwise) {
    if (map.containsKey(index))
      return map[index] ?? otherwise;
    else
      return otherwise;
  }

  @override
  T? maybeGet(Symbol index, [T? otherwise]) {
    return map.containsKey(index)? map[index] : otherwise;
  }

  @override
  T fetch(Symbol index) {
    final value = map[index];
    if (value == null)
      throw RangeError("No item with index $index");
    return value;
  }

  @override
  void put(Symbol index, T value) {
    map[index] = value;
  }

  @override
  void remove(Symbol index) {
    map.remove(index);
  }

  @override
  int removeAll() {
    int length = map.length;
    map.clear();
    return length;
  }

  @override
  Map<Symbol, T> getAll() {
    return Map.of(map);
  }
}
