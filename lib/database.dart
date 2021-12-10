
import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/translation.dart';
import 'package:flutter/foundation.dart';

import 'dimensions.dart';
import 'dish.dart';
import 'edible.dart';
import 'meal.dart';
import 'quantified.dart';
import 'indexable.dart';
import 'quantity.dart';
import 'seen_check.dart';
import 'units.dart';

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

  Future<bool> containsId(Symbol index);

  /// Get all items as a map
  Future<Map<Symbol, T>> getAll();

  /// Get a named item, or the otherwise value if absent.
  ///
  /// otherwise defaults to null
  Future<T?> maybeGet(Symbol index, [T? otherwise]);

  /// Get a named item, or the otherwise value if absent
  ///
  /// otherwise must be a non-null value
  Future<T> get(Symbol index, T otherwise);

  /// Get a named item, or throw
  Future<T> fetch(Symbol index);

  /// Put an indexable item
  Future<Symbol> add(T value);

  /// Remove a named item
  Future<int> remove(Symbol index);

  /// Remove all items, returning the number
  Future<int> removeAll();
}

abstract class Database {
  Database();

  AsyncDataCollection<Dimensions> get dimensions;
  AsyncDataCollection<Units> get units;
  AsyncDataCollection<Measurable> get measurables;
  AsyncDataCollection<Edible> get edibles;
  AsyncDataCollection<BasicIngredient> get ingredients;
  AsyncDataCollection<Dish> get dishes;
  AsyncDataCollection<Meal> get meals;

  /// Returns the schema version of this database object
  Future<int> get version;

  /// Returns the schema version deployed currently in the database, or zero if nothing deployed yet
  Future<int> get deployedVersion;

  /// Sets the schema version currently deployed in the database
  Future<void> setDeployedVersion(int version);

  /// Find the natural units for an amount (the next smallest in the list of defined units)
  Future<Symbol> naturalUnitsFor(num amount, Symbol dimensionId) async {
    List<Units> inOrder = [];
    final map = await units.getAll();
    map.forEach((id, unit) { inOrder.add(unit); });
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

  /// Checks a list of [Edibles] for invalid contents.
  ///
  /// Returns if they are all valid, otherwise throws an exception.
  Future<void> validateEdibles(List<Edible> edibles) async {
    final cache = <Symbol, Measurable>{};
    for(final edible in edibles) {
      final invalids = await edible.invalidContents(this, cache);
      if (invalids.isNotEmpty)
        throw StateError("invalid units in contents ${Quantified.formatContents(invalids)}");
    }
    return;
  }

  /// Deeply traverse the [Edible]s with the given [ids], and return an index
  /// of all [Quantified]s encountered.
  ///
  /// [Measurable]s are irreducible nutritional components and therefore have no contents, just a [dimensionId].
  Future<Map<Symbol, Quantified>> traverseContents(Iterable<Symbol> ids) async {
    // expand all the symbols into Dishes recursively
    final index = <Symbol, Quantified>{};
    final pending = ids.toSet();

    // We use conventional loops, not closures here, so we can avoid a cascading
    // chain of the async/await caused by DB lookups.
    while(pending.isNotEmpty) {
      final id = pending.first;
      pending.remove(id);
      if (index.containsKey(id))
        continue;
      final dish = await dishes.maybeGet(id);

      if (dish == null) {
        // Not a known dish, maybe an ingredient?
        final ingredient = await ingredients.maybeGet(id);

        if (ingredient == null) {
          // Not a known ingredient, presumably a measurable?
          final measurable = await measurables.maybeGet(id);

          if (measurable == null)
            throw new RangeError("Unknown edible/measurable $id"); // Nope, throw

          // Create a fake ingredient with one item
          index[id] = measurable;
          continue;
        }
        else {
          index[id] = ingredient;
          pending.addAll(ingredient.contents.keys);
        }
      }
      else {
        index[id] = dish;
        pending.addAll(dish.contents.keys);
      }
    }
    return index;
  }

  /// Convert an Dish's content list into a content list of nutritional components
  ///
  /// [contents] should be a map defining [Quantities] of [Edible] instances named by their ID.
  /// There should be no null keys or values. Nor should there be any cycles, where an dish
  /// contains itself, directly or indirectly.
  ///
  /// Optionally, [edibleId] can identify an [Dish] which includes this content list,
  /// in case it needs to be excluded from cycles (i.e. when aggregating an [Dish] existing in the database).
  ///
  /// Returns a map of [Measurable] identifiers and the appropriate total quantities thereof.
  ///
  /// May throw a [StateError] if a cycle is detected.
  Future<Map<Symbol, Quantity>> aggregate(Map<Symbol, Quantity> contents, num totalMass, [Symbol? edibleId]) async {
    final seen = edibleId == null? (id) => false : (id) => id == edibleId;
    return Quantified.aggregate(contents, totalMass, await traverseContents(contents.keys), seen);
  }

  /// Sets up an empty database
  static Future<void> initialiseData(Database db) async {
    final int version = await db.version;
    int deployedVersion = await db.deployedVersion;
    print("Database $db version $version, deployed version is $deployedVersion");
    if (deployedVersion <= 0) {
      debugPrint("Clearing database");
      await db.clear();
      final versionIx = schemas.length - 1;
      debugPrint("Populating database with latest schema #${schemas.length}");
      schemas[versionIx].init(db);
      debugPrint("Done populating");
    }
    else if (deployedVersion > version)
        throw RangeError("Database schema currently deployed is newer than the one we support");
    else while(deployedVersion++ < version) {
        debugPrint("Migrating database schema to $deployedVersion");
        schemas[deployedVersion-1].upgrade(db);
        debugPrint("Done migrating");
      }
    debugPrint("Setting deployed version to $version");
    await db.setDeployedVersion(version);
    debugPrint("Done migrating database to schema #$version");
  }

  static final schemas = [
    DbSchema( // 1
      init: (Database db) {
        const version = 1;
        print("Initialising $db as version $version");
        final
          tahini = BasicIngredient(
            id: #Tahini,
          contents: {
              Measurable.Carbs.id: Units.GramsPerHectogram.times(1),
              Measurable.Fat.id: Units.GramsPerHectogram.times(2),
            },
          ),
          cabbage = BasicIngredient(
            id: #Cabbage,
            contents: {
              Measurable.Carbs.id: Units.GramsPerHectogram.times(1),
              Measurable.Fibre.id: Units.GramsPerHectogram.times(1),
            },
          ),
          salad = Dish(
            id: #Salad,
            contents: {
              tahini.id: Units.Grams.times(1),
              cabbage.id: Units.Grams.times(2),
            },
          );
        final meal1 = Meal(
          id: #Meal1,
          title: "Meal 1",
          timestamp: DateTime(2021),
          notes: "",
            contents: {
            salad.id: Units.Grams.times(500),
          }
        );
        db.dimensions..add(Dimensions.Mass)..add(Dimensions.FractionByMass)
          ..add(Dimensions.Energy)..add(Dimensions.EnergyByMass);
        db.units..add(Units.Grams)..add(Units.Kilograms)
          ..add(Units.GramsPerHectogram)..add(Units.GramsPerKilogram)..add(Units.GramsPerGram)
          ..add(Units.CaloriesPerGram)..add(Units.KilocaloriesPerHectogram)
          ..add(Units.JoulesPerGram)..add(Units.JoulesPerHectogram)..add(Units.JoulesPerKilogram);
        db.measurables..add(Measurable.Carbs)..add(Measurable.Fat)..add(Measurable.Fibre)..add(
            Measurable.Protein)..add(Measurable.Sugar)..add(Measurable.Salt)..add(Measurable.Energy)
            ..add(Measurable.Sodium)..add(Measurable.SaturatedFat)..add(Measurable.Caffeine);
        db.ingredients..add(tahini)..add(cabbage);
        db.dishes..add(salad);
      },
      upgrade: (db) {},
    )
  ];

  Future<void> clear();
}

class DbSchema {
  final void Function(Database db) init;
  final void Function(Database db) upgrade;

  const DbSchema({required this.init, required this.upgrade});
}

