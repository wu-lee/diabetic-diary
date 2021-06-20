 
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database.dart';
import '../entities/dish.dart';
import '../entities/ingredient.dart';
import '../indexable.dart';
import '../measurement_type.dart';
import '../translation.dart';
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
    box.put(value.id.toString(), value);
    return value.id;
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

class DPairTypeAdaptor extends TypeAdapter<DPair> {
  static const TYPE_ID = 1;

  @override
  int get typeId => TYPE_ID;

  @override
  DPair read(BinaryReader reader) {
    final id = Symbol(reader.readString());
    final value = reader.read();
    return DPair(id, value);
  }

  @override
  void write(BinaryWriter writer, DPair obj) {
    writer.writeString(symbolToString(obj.id));
    writer.write(obj.value);
  }
}

class DimensionsTypeAdapter extends TypeAdapter<Dimensions> {
  static const TYPE_ID = 2;

  @override
  int get typeId => TYPE_ID;

  @override
  Dimensions read(BinaryReader reader) {
    final id = Symbol(reader.readString());
    final Map<Symbol, num> components = reader.readMap();
    final Map<Symbol, num> unitsMap = reader.readMap();
    return Dimensions(id: id, units: unitsMap, components: components);
  }

  @override
  void write(BinaryWriter writer, Dimensions obj) {
    writer.writeString(symbolToString(obj.id));
    writer.writeMap(obj.components);
    writer.writeMap(obj.unitsMap);
  }
}

class UnitsTypeAdapter extends TypeAdapter<Units> {
  static const TYPE_ID = 3;

  @override
  int get typeId => TYPE_ID;

  @override
  Units read(BinaryReader reader) {
    final id = Symbol(reader.readString());
    final Dimensions dimensions = reader.read(DimensionsTypeAdapter.TYPE_ID);
    final multiplier = reader.readDouble();
    return Units(id, dimensions, multiplier);
  }

  @override
  void write(BinaryWriter writer, Units obj) {
    writer.writeString(symbolToString(obj.id));
    writer.write(obj.dims, writeTypeId: false);
    writer.writeDouble(obj.multiplier);
  }
}


class QuantityTypeAdaptor extends TypeAdapter<Quantity> {
  static const TYPE_ID = 4;

  @override
  int get typeId => TYPE_ID;

  @override
  Quantity read(BinaryReader reader) {
    final amount = reader.readDouble();
    final units = reader.read(UnitsTypeAdapter.TYPE_ID);
    return Quantity(amount, units);
  }

  @override
  void write(BinaryWriter writer, Quantity obj) {
    writer.writeDouble(obj.amount);
    writer.write(obj.units, writeTypeId: false);
  }
}

class IngredientAdapter extends TypeAdapter<Ingredient> {
  static const TYPE_ID = 5;

  @override
  int get typeId => TYPE_ID;

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
  static const TYPE_ID = 6;

  @override
  int get typeId => TYPE_ID;

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

