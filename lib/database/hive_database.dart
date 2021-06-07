 
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../unit.dart';
import 'mock_database.dart';

class HiveDatabase implements Database {

  static final _dimensions = MockDataCollection<Dimensions>();

  static final _compositionStatistics = MockDataCollection<MeasurementType>();

  static final _measurementTypes = MockDataCollection<MeasurementType>();

  @override
  DataCollection<Dimensions> get dimensions => _dimensions;

  @override
  DataCollection<MeasurementType> get compositionStatistics => _compositionStatistics;

  @override
  BoxDataCollection<Dish> dishes;

  @override
  BoxDataCollection<Ingredient> ingredients;

  @override
  DataCollection<MeasurementType> get measurementTypes => _measurementTypes;

  @override
  DataCollection<DPair> config;

  /// Private constructor
  HiveDatabase._init({
    this.dishes,
    this.ingredients,
    this.config,
  });

  /// Public factory
  static Future<HiveDatabase> create() async {
    await Hive.initFlutter();
    return HiveDatabase._init(
      dishes: BoxDataCollection(await Hive.openBox<Dish>('dishes')),
      ingredients: BoxDataCollection(await Hive.openBox<Ingredient>('ingredients')),
      config: BoxDataCollection(await Hive.openBox('config')),
    );
  }

}

// FIXME symbol <-> string everywhere
class BoxDataCollection<T extends Indexable> implements DataCollection<T> {
  Box<T> box;

  BoxDataCollection(this.box);

  @override
  Symbol add(T value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Map<Symbol, T> cannedQuery(Symbol name, [List parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  int count() => box.length;

  @override
  T fetch(Symbol index) {
    if (box.containsKey(index)) return box.get(index.toString());
    throw RangeError("No item with index $index");
  }

  @override
  forEach(void Function(Symbol p1, T p2) visitor) {
    box.keys.forEach((k) => visitor(k, box.get(k.toString())));
  }

  @override
  T get(Symbol index, [T otherwise = null]) {
    return box.get(index.toString(), defaultValue: otherwise);
  }

  @override
  Map<Symbol, T> getAll() {
    final map = box.toMap();
    return map.cast();
  }

  @override
  void put(Symbol index, T value) async {
    await box.put(index.toString(), value);
  }

  @override
  void remove(Symbol index) async {
    await box.delete(index.toString());
  }

  @override
  int removeAll() {
    int count = box.length;
    box.clear();
    return count;
  }
}



class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final typeId = 1;

  @override
  Ingredient read(BinaryReader reader) {
    final name = reader.readString();
    final Map<String, int> compositionStats = reader.readMap();

    return Ingredient(
      id: new Symbol(name),
      compositionStats: compositionStats.map((k, v) {
        return MapEntry(lookupMeasurement(k), makeQuantity(v));
      })
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer.write(obj.id);
    final compositionStats = obj.compositionStats.map((k,v) => MapEntry(1,1));
    writer.writeMap(compositionStats);
  }

  MeasurementType lookupMeasurement(String name) {
    return MeasurementType();
  }
  Quantity makeQuantity(int amount) {
    return Quantity(amount, Units(#FIXME, Dimensions(), 1)); // FIXME
  }
}

class DishAdapter extends TypeAdapter<Dish> {
  @override
  final typeId = 2;

  @override
  Dish read(BinaryReader reader) {
    final name = reader.readString();
    final Map<Ingredient, int> ingredients = reader.readMap();

    return Dish(
        id: new Symbol(name),
        ingredients: ingredients.map((k, v) {
          return MapEntry(lookupIngredient(k.id), makeQuantity(v));
        })
    );
  }

  @override
  void write(BinaryWriter writer, Dish obj) {
    writer.write(obj.id);
    final ingredients = obj.ingredients.map((k,v) => MapEntry(1,1));
    writer.writeMap(ingredients);
  }

  Ingredient lookupIngredient(Symbol id) {
    return Ingredient();
  }
  Quantity makeQuantity(int amount) {
    return Quantity(amount, Units(#FIXME, Dimensions(), 1)); // FIXME
  }
}

