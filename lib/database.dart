
import 'package:diabetic_diary/translation.dart';

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
  Map<Symbol, T> cannedQuery(Symbol name, [List<dynamic>? parameters]);
}

abstract class AsyncDataCollection<T extends Indexable> {
  /// Count all items
  Future<int> count();

  /// Get a named item, or the otherwise value if absent
  Future<T?> maybeGet(Symbol index, [T? otherwise]);

  /// Get a named item, or the otherwise value if absent
  Future<T> get(Symbol index, T otherwise);

  /// Get a named item, or throw
  Future<T> fetch(Symbol index);

  /// Get all items as a map
  Future<Map<Symbol, T>> getAll();

  /// Put an indexable item
  Future<Symbol> add(T value);

  /// Put a named item
  void put(Symbol index, T value);

  /// Remove a named item
  void remove(Symbol index);

  /// Remove all items, returning the number
  Future<int> removeAll();

  /// Retrieve all items of the collection in some arbitrary order, and pass to the visitor
  void forEach(void Function(Symbol, T) visitor);

  /// Invoke a named predefined query with some parameters. May throw an exception if this
  /// name doesn't exist or the parameters are wrong.
  Future<Map<Symbol, T>> cannedQuery(Symbol name, [List<dynamic>? parameters]);
}

abstract class Database {
  Database();

  AsyncDataCollection<Dimensions> get dimensions;
  AsyncDataCollection<Units> get units;
  AsyncDataCollection<MeasurementType> get measurementTypes;
  AsyncDataCollection<MeasurementType> get compositionStatistics;
  AsyncDataCollection<Ingredient> get ingredients;
  AsyncDataCollection<Dish> get dishes;
  AsyncDataCollection<DPair> get config;

  /// Find the natural units for an amount (the next smallest in the list of defined units)
  Symbol naturalUnitsFor(num amount, Symbol dimensionId) {
    List<Units> inOrder = [];
    units.forEach((id, unit) { inOrder.add(unit); });
    inOrder = inOrder
      .toList()
      ..sort((a,b) => b.multiplier.compareTo(a.multiplier));
    final nextSmallest = inOrder
        .firstWhere(
          (element) => (element.multiplier < amount),
          orElse: () => inOrder.first
        );
    return nextSmallest.id;
  }

  Future<Quantity> quantity(num amount, Symbol unitId) async {
    return Quantity(amount, await units.fetch(unitId));
  }

  Future<String> formatQuantity(Quantity quantity, [Symbol? unitsId]) async {
    num amount = quantity.amount;
    if (unitsId != null) {
      amount *= (await units.fetch(unitsId))
          .multiplier;
    }
    else {
      unitsId = quantity.units.id;
    }

    final abs = amount.abs();
    var formatted = amount.toStringAsFixed(abs < 1? 2 : abs < 10? 1 : 0);
    return "$formatted ${TL8(unitsId)}";
  }

  String formatDimensions(Dimensions dims) => "Dimensions(id: ${TL8(dims.id)})";

  /// Sets up an empty database
  static void initialiseData(Database db) async {
    final int? version = (await db.config.maybeGet(#version))?.value;
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
            components: {#Mass:1},
          ),
          FractionByMass = Dimensions(
            id: #FractionByMass,
            components: {},
          ),
          MicroGrams = Units(#ug, #Mass, 0.000001),
          MilliGrams = Units(#mg, #Mass, 0.001),
          Grams = Units(#g, #Mass, 1),
          KiloGrams = Units(#kg, #Mass, 1000),
          GramsPerMilligram = Units(#g_per_mg, #FractionByMass, 0.001),
          GramsPerCentigram = Units(#g_per_cg, #FractionByMass, 0.01),
          GramsPerGram = Units(#g_per_g, #FractionByMass, 1),
          GramsPerHectogram = Units(#g_per_hg, #FractionByMass, 100),
          GramsPerKiloGram = Units(#g_per_kg, #FractionByMass, 1000),
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
              Carbs: GramsPerHectogram.times(1),
              Fat: GramsPerHectogram.times(2),
            },
          ),
          cabbage = Ingredient(
            id: #Cabbage,
            compositionStats: {
              Carbs: GramsPerHectogram.times(1),
              Fibre: GramsPerHectogram.times(1),
            },
          ),
          salad = Dish(
            id: #Salad,
            ingredients: {
              tahini: Grams.times(1),
              cabbage: Grams.times(2),
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

