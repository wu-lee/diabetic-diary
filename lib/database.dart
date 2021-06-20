
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
  T? maybeGet(Symbol index, [T? otherwise]);

  /// Get a named item, or the otherwise value if absent
  T get(Symbol index, T otherwise);

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
  Database({required this.dimensions, required this.measurementTypes, required this.ingredients,
    required this.dishes, required this.compositionStatistics, required this.config});

  final DataCollection<Dimensions> dimensions;
  final DataCollection<MeasurementType> measurementTypes;
  final DataCollection<MeasurementType> compositionStatistics;
  final DataCollection<Ingredient> ingredients;
  final DataCollection<Dish> dishes;
  final DataCollection<DPair> config;

  /// Sets up an empty database
  static void initialiseData(Database db) {
    final int? version = db.config.maybeGet(#version)?.value;
    print("Database $db version $version");
    if (version == null)
      schemas[schemas.length-1].init(db);
  }

  static final schemas = [
    DbSchema( // 0
      init: (Database db) {
        const version = 0;
        print("Initialising $db as version $version");
        const
          Mass = Dimensions(
            id: #Mass,
            units: {#ug: 0.000001, #mg: 0.001, #g: 1, #kg: 1000},
            components: {#Mass:1},
          ),
          FractionByMass = Dimensions(
            id: #FractionByMass,
            units: {
              #g_per_mg: 0.001,
              #g_per_cg: 0.01,
              #g_per_g: 1,
              #g_per_hg: 100,
              #g_per_kg: 1000
            },
            components: {},
          ),
          GramsPerHectogram = Units(#g_per_hg, FractionByMass, 100),
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
              Carbs: FractionByMass.of(1, #g_per_hg),
              Fat: FractionByMass.of(2, #g_per_hg),
            },
          ),
          cabbage = Ingredient(
            id: #Cabbage,
            compositionStats: {
              Carbs: FractionByMass.of(1, #g_per_hg),
              Fibre: FractionByMass.of(1, #g_per_hg),
            },
          ),
          salad = Dish(
            id: #Salad,
            ingredients: {
              tahini: Mass.of(1, #g),
              cabbage: Mass.of(2, #g),
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

  const DbSchema({required this.init});
}

