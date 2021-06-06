
import 'package:flutter/foundation.dart';

import 'entities/dish.dart';
import 'indexable.dart';
import 'entities/ingredient.dart';
import 'measurement_type.dart';
import 'unit.dart';

typedef DataMapper = R Function<I, T, R>(I, T);

abstract class DataCollection<I, T> {
  /// Count all items
  int count();

  /// Get a named item, or the otherwise value if absent
  T get(I index, [T otherwise = null]); // ignore: avoid_init_to_null

  /// Get a named item, or throw
  T fetch(I index);

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
  Database({this.dimensions, this.measurementTypes, this.ingredients, this.dishes, this.compositionStatistics});

  final DataCollection<Symbol, Dimensions> dimensions;
  final DataCollection<Symbol, MeasurementType> measurementTypes;
  final DataCollection<Symbol, MeasurementType> compositionStatistics;
  final DataCollection<Symbol, Ingredient> ingredients;
  final DataCollection<Symbol, Dish> dishes;

  /// Sets up an empty database
  static void initialiseData(Database db) {
    // FIXME check the version and check it hasn't been initialised
    schemas[0].init(db);
  }

  static final schemas = [
    DbSchema(
      init: (Database db) {
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
              #per_Dg: 100,
              #per_kg: 1000
            },
          ),
          Carbs = MeasurementType(id: #Carbs, units: FractionByMass),
          Fat = MeasurementType(id: #Fat, units: FractionByMass),
          Fibre = MeasurementType(id: #Fibre, units: FractionByMass),
          Protein = MeasurementType(id: #Protein, units: FractionByMass),
          Sugar = MeasurementType(id: #Sugar, units: FractionByMass),
          Salt = MeasurementType(id: #Salt, units: FractionByMass)
/*          Tahini = Ingredient(
            id: #Tahini,
            compositionStats: {
              Carbs: Mass.of(0, #g),
            },
          ),
          Salad = Dish(
            id: #Salad,
            ingredients: {
              Tahini: Mass.of(200, #g),
            },
          ),*/
        ;
        db.dimensions..add(Mass)..add(FractionByMass);
        db.compositionStatistics..add(Carbs)..add(Fat)..add(Fibre)..add(
            Protein)..add(Sugar)..add(Salt);
      }
    )
  ];
}

class DbSchema {
  final void Function(Database db) init;

  const DbSchema({@required this.init});
}

