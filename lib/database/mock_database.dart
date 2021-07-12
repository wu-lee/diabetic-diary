 
import '../database.dart';
import '../dimensions.dart';
import '../edible.dart';
import '../indexable.dart';
import '../measureable.dart';
import '../units.dart';

class MockDatabase extends Database {

  static final _dimensions = MockDataCollection<Dimensions>();

  static final _units = MockDataCollection<Units>();

  static final _measurables = MockDataCollection<Measurable>();

  static final _edibles = MockDataCollection<Edible>();


  static final int _version = 0;

  @override
  AsyncDataCollection<Dimensions> get dimensions => _dimensions;

  @override
  AsyncDataCollection<Units> get units => _units;

  @override
  AsyncDataCollection<Measurable> get measurables => _measurables;

  @override
  AsyncDataCollection<Edible> get edibles => _edibles;

  @override
  Future<int> get version => Future(() => _version);
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
