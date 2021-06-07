
import 'package:flutter/foundation.dart';

import 'entities/dish.dart';
import 'indexable.dart';
import 'entities/ingredient.dart';
import 'measurement_type.dart';
import 'unit.dart';

class DPair extends Indexable {
  final dynamic value;

  DPair(Symbol id, this.value) : super(id: id);
}

abstract class DataCollection<T extends Indexable> {
  /// Count all items
  int count();

  /// Get a named item, or the otherwise value if absent
  T get(Symbol index, [T otherwise = null]); // ignore: avoid_init_to_null

  /// Get a named item, or throw
  T fetch(Symbol index);

  /// Get all items as a map
  Map<Symbol, T> getAll();

  /// Put an indexable item
  Symbol add(T value);

  /// Put a named item
  void put(Symbol index, T value);

  /// Remove a named item
  void remove(Symbol index);

  /// Remove all items, returning the number
  int removeAll();

  /// Retrieve all items of the collection in some arbitrary order, and pass to the visitor
  forEach(void Function(Symbol, T) visitor);

  /// Invoke a named predefined query with some parameters. May throw an exception if this
  /// name doesn't exist or the parameters are wrong.
  Map<Symbol, T> cannedQuery(Symbol name, [List<dynamic> parameters]);
}

class Database {
  Database({this.dimensions, this.measurementTypes, this.ingredients, this.dishes, this.compositionStatistics, this.config});

  final DataCollection<Dimensions> dimensions;
  final DataCollection<MeasurementType> measurementTypes;
  final DataCollection<MeasurementType> compositionStatistics;
  final DataCollection<Ingredient> ingredients;
  final DataCollection<Dish> dishes;
  final DataCollection<DPair> config;

  /// Sets up an empty database
  static void initialiseData(Database db) {
    final int version = db.config.get(#version)?.value;
    print("Database $db version $version");
    if (version == null)
      schemas[schemas.length-1].init(db);
  }

  static final schemas = [
    DbSchema( // 0
      init: (Database db) {
        const version = 0;
        print("Initalising $db as version $version");
        const
          Mass = Dimensions(
            id: #Mass,
            units: {#ug: 0.000001, #mg: 0.001, #g: 1, #kg: 1000},
          ),
          FractionByMass = Dimensions(
            id: #FractionByMass,
            units: {
              #per_mg: 0.001,
              #per_cg: 0.01,
              #per_g: 1,
              #per_hg: 100,
              #per_kg: 1000
            },
          ),
          GramsPerHectogram = Units(#per_hg, FractionByMass, 100),
          Carbs = MeasurementType(id: #Carbs, units: GramsPerHectogram),
          Fat = MeasurementType(id: #Fat, units: GramsPerHectogram),
          Fibre = MeasurementType(id: #Fibre, units: GramsPerHectogram),
          Protein = MeasurementType(id: #Protein, units: GramsPerHectogram),
          Sugar = MeasurementType(id: #Sugar, units: GramsPerHectogram),
          Salt = MeasurementType(id: #Salt, units: GramsPerHectogram);
        final
          tahini = Ingredient(
            id: #Tahini,
            compositionStats: {
              Carbs: Mass.of(1, #g),
              Fat: Mass.of(99, #g),
            },
          ),
          cabbage = Ingredient(
            id: #Cabbage,
            compositionStats: {
              Carbs: Mass.of(1, #g),
              Fibre: Mass.of(99, #g),
            },
          ),
          salad = Dish(
            id: #Salad,
            ingredients: {
              tahini: Mass.of(10, #g),
              cabbage: Mass.of(200, #g),
            },
          );
        db.config
          ..add(DPair(#version, version));
        db.dimensions..add(Mass)..add(FractionByMass);
        db.compositionStatistics..add(Carbs)..add(Fat)..add(Fibre)..add(
            Protein)..add(Sugar)..add(Salt);
        db.ingredients..add(tahini)..add(cabbage);
        db.dishes..add(salad);
      }
    )
  ];
}

class DbSchema {
  final void Function(Database db) init;

  const DbSchema({@required this.init});
}

