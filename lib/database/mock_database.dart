 
import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../unit.dart';

class MockDatabase extends Database {

  static final _dimensions = MockDataCollection<Dimensions>();

  static final _ingredients = MockDataCollection<Ingredient>();

  static final _dishes = MockDataCollection<Dish>();

  static final _compositionStatistics = MockDataCollection<MeasurementType>();

  static final _measurementTypes = MockDataCollection<MeasurementType>();

  static final _config = MockDataCollection<DPair>();

  @override
  AsyncDataCollection<Dimensions> get dimensions => _dimensions;

  @override
  AsyncDataCollection<MeasurementType> get measurementTypes => _measurementTypes;

  @override
  AsyncDataCollection<Ingredient> get ingredients => _ingredients;

  @override
  AsyncDataCollection<Dish> get dishes => _dishes;

  @override
  AsyncDataCollection<MeasurementType> get compositionStatistics => _compositionStatistics;

  @override
  AsyncDataCollection<DPair> get config => _config;

  @override
  // TODO: implement units
  AsyncDataCollection<Units> get units => throw UnimplementedError();
}

class MockDataCollection<T extends Indexable> implements AsyncDataCollection<T> {
  final Map<Symbol, T> map;

  MockDataCollection([Map<Symbol, T>? map]) : this.map = map ?? {};

  static MockDataCollection<T> fromIndexables<T extends Indexable>(Set<T> items) {
    return MockDataCollection(
        Map.fromEntries(
            items.map((e) => MapEntry(e.id, e))
        )
    );
  }

  Future<Symbol> add(T value) {
    map[value.id] = value;
    return Future(() => value.id);
  }

  @override
  Future<Map<Symbol, T>> cannedQuery(Symbol id, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() => Future(() => map.length);

  @override
  forEach(void Function(Symbol ix, T val) visitor) {
    map.forEach(visitor);
  }

  @override
  Future<T> get(Symbol index, T otherwise) {
    if (map.containsKey(index))
      return Future(() => map[index] ?? otherwise);
    else
      return Future(() => otherwise);
  }

  @override
  Future<T?> maybeGet(Symbol index, [T? otherwise]) {
    return Future(() => map.containsKey(index)? map[index] : otherwise);
  }

  @override
  Future<T> fetch(Symbol index) {
    final value = map[index];
    if (value == null)
      throw RangeError("No item with index $index");
    return Future(() => value);
  }

  @override
  void put(Symbol index, T value) {
    map[index] = value;
  }

  @override
  Future<int> remove(Symbol index) {
    final val = map.remove(index);
    return Future(() => val == null? 0 : 1);
  }

  @override
  Future<int> removeAll() {
    int length = map.length;
    map.clear();
    return Future(() => length);
  }

  @override
  Future<Map<Symbol, T>> getAll() {
    return Future(() => Map.of(map));
  }
}
