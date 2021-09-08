 
import 'package:diabetic_diary/translation.dart';

import '../basic_ingredient.dart';
import '../database.dart';
import '../dimensions.dart';
import '../dish.dart';
import '../edible.dart';
import '../indexable.dart';
import '../meal.dart';
import '../measureable.dart';
import '../units.dart';

class MockDatabase extends Database {

  static final _dimensions = MockDataCollection<Dimensions>();

  static final _units = MockDataCollection<Units>();

  static final _measurables = MockDataCollection<Measurable>();

  static final _edibles = MockDataCollection<Edible>();

  static final _ingredients = MockDataCollection<BasicIngredient>();

  static final _dishes = MockDataCollection<Dish>();

  static final _meals = MockDataCollection<Meal>();


  final int _version;

  int _deployedVersion;

  MockDatabase({required int version, required int deployedVersion}) :
      _version = version,
      _deployedVersion = deployedVersion;

  @override
  AsyncDataCollection<Dimensions> get dimensions => _dimensions;

  @override
  AsyncDataCollection<Units> get units => _units;

  @override
  AsyncDataCollection<Measurable> get measurables => _measurables;

  @override
  AsyncDataCollection<Edible> get edibles => _edibles;

  @override
  AsyncDataCollection<Dish> get dishes => _dishes;

  @override
  AsyncDataCollection<Meal> get meals => _meals;

  @override
  AsyncDataCollection<BasicIngredient> get ingredients => _ingredients;

  @override
  Future<int> get version async => Future(() => _version);

  @override
  Future<int> get deployedVersion => Future(() => _deployedVersion);

  @override
  Future<void> setDeployedVersion(int version) {
    _deployedVersion = version;
    return Future(() => null);
  }

  @override
  Future<void> clear() async {
    dimensions.removeAll();
    units.removeAll();
    measurables.removeAll();
    dishes.removeAll();
    _deployedVersion = 0;
    return;
  }
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
    print("add ${symbolToString(value.id)}");
    return Future(() => value.id);
  }

  @override
  Future<int> count() => Future(() => map.length);

  @override
  Future<bool> containsId(Symbol index) {
    return Future(() => map.containsKey(index));
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
