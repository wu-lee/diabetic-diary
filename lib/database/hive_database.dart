 
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../measurement_type.dart';
import '../unit.dart';
import 'mock_database.dart';

class HiveDatabase implements Database {

  static final _dimensions = MockDataCollection<Symbol, Dimensions>();

  static final _compositionStatistics = MockDataCollection<Symbol, MeasurementType>();

  static final _measurementTypes = MockDataCollection<Symbol, MeasurementType>();

  @override
  DataCollection<Symbol, Dimensions> get dimensions => _dimensions;

  @override
  DataCollection<Symbol, MeasurementType> get compositionStatistics => _compositionStatistics;

  @override
  BoxDataCollection<Symbol, Dish> dishes;

  @override
  BoxDataCollection<Symbol, Ingredient> ingredients;

  @override
  DataCollection<Symbol, MeasurementType> get measurementTypes => _measurementTypes;

  /// Private constructor
  HiveDatabase._init({
    this.dishes,
    this.ingredients,
  });

  /// Public factory
  static Future<HiveDatabase> create() async {
    await Hive.initFlutter();
    return HiveDatabase._init(
      dishes: BoxDataCollection(await Hive.openBox<Dish>('dishes')),
      ingredients: BoxDataCollection(await Hive.openBox<Ingredient>('ingredients')),
    );
  }

}

// FIXME symbol <-> string everywhere
class BoxDataCollection<I, T> implements DataCollection<I, T> {
  Box<T> box;

  BoxDataCollection(this.box);

  @override
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
  int count() => box.length;

  @override
  T fetch(I index) {
    if (box.containsKey(index)) return box.get(index.toString());
    throw RangeError("No item with index $index");
  }

  @override
  forEach(void Function(I p1, T p2) visitor) {
    box.keys.forEach((k) => visitor(k, box.get(k.toString())));
  }

  @override
  T get(I index, [T otherwise = null]) {
    return box.get(index.toString(), defaultValue: otherwise);
  }

  @override
  Map<I, T> getAll() {
    final map = box.toMap();
    return map.cast();
  }

  @override
  void put(I index, T value) async {
    await box.put(index.toString(), value);
  }

  @override
  void remove(I index) async {
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

  MeasurementType<Dimensions> lookupMeasurement(String name) {
    return MeasurementType();
  }
  Quantity makeQuantity(int amount) {
    return Quantity(amount, Units(Dimensions(), #FIXME)); // FIXME
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
    return Quantity(amount, Units(Dimensions(), #FIXME)); // FIXME
  }
}

