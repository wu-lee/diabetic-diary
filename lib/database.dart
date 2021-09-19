
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

  String formatDimensions(Dimensions dims) => "Dimensions(id: ${TL8(dims.id)}, components: ${formatComponents(dims.components)})";

  String formatComponents(Map<Symbol, int> comps) => "{"+comps.entries.map((e) => "${TL8(e.key)}: ${e.value}").join(",")+"}";

  String formatUnits(Units units) => "Units(id: ${TL8(units.id)}, dimensionId: ${units.dimensionsId}, multiplier: ${units.multiplier})";

  String formatMeasurable(Measurable meas) => "Measurable(id: ${TL8(meas.id)}, units: ${TL8(meas.dimensionsId)})";

  Future<String> formatDish(Dish dish) async => "Dish(id: ${TL8(dish.id)}, contents: ${await formatContents(dish.contents)})";

  Future<String> formatBasicIngredient(BasicIngredient ingredient) async => "BasicIngredient(id: ${TL8(ingredient.id)}, contents: ${await formatContents(ingredient.contents)})";

  Future<String> formatMeal(Meal meal) async =>
      "Meal(id: ${TL8(meal.id)}, ${meal.title}, ${meal.timestamp}, ${meal.notes}, contents: ${await formatContents(meal.contents)})";

  Future<String> formatContents(Map<Symbol, Quantity> contents) async {
    final entries = contents.entries.map((e) async {
      final quantity = await formatQuantity(e.value);
      return "#${TL8(e.key)}: $quantity";
    });
    return "{"+(await Future.wait(entries)).join(",")+"}";
  }

  /// Deeply traverse the [Edible]s with the given [ids], and return an index
  /// of all [Quantified]s encountered.
  ///
  /// [Measurable]s are irreducible nutritional components and therefore have no contents, just a [dimensionId].
  Future<Map<Symbol, Quantified>> traverseContents(Iterable<Symbol> ids) async {
    // expand all the symbols into Dishs recursively
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
  Future<Map<Symbol, Quantity>> aggregate(Map<Symbol, Quantity> contents, [Symbol? edibleId]) async {
    final seen = edibleId == null? (id) => false : (id) => id == edibleId;
    return _aggregate(contents, await traverseContents(contents.keys), seen);
  }

  /// Convert [contents] into a table of nutritional component quantities.
  ///
  /// [contents] should be a map defining [Quantities] of [Edible] instances named by their ID.
  /// There should be no null keys or values. Nor should there be any cycles, where an dish
  /// contains itself, directly or indirectly.
  ///
  /// All IDs in [content] must exist in [index], mapped to the appropriate instance of an [Dish]
  /// or a [Measurable].
  ///
  /// The function [seen] is used to detect cycles, and should return true if a symbol identifies
  /// an [Edible] instance including this one.
  ///
  /// Returns a map of [Measurable] identifiers and the appropriate total quantities thereof.
  ///
  /// May throw a [StateError] if a cycle is detected.
  Map<Symbol, Quantity> _aggregate(Map<Symbol, Quantity> contents, Map<Symbol, Quantified> index, bool Function(Symbol) seen) {
    final expanded = contents.entries.expand((elem) {
      final id = elem.key;
      final quantity = elem.value;

      // All dish contents must be in the same dimensions, i.e. fraction by mass.
      //assert(quantity.units.dimensionsId == #FractionByMass);

      // Prevent infinite loops in cyclic graphs (which should not exist: you
      // should not include an ingredient as an ingredient of itself, even
      // indirectly).
      if (seen(id))
        throw StateError(
            "Cannot aggregate this ingredient list as it contains "
            "a cyclic reference to the dish ID #${symbolToString(id)} "
        );

      final item = index[id];
      if (item == null) {
        return <MapEntry<Symbol, Quantity>>[]; // Probably shouldn't ever happen
      }

      if (item is Measurable)
        return [elem];

      final aggregated = _aggregate(item.contents, index, (newId) => id == newId || seen(newId));

      // Multiply this dish's contents by the parent dish's quantity
      final multiplier = quantity.amount * quantity.units.multiplier;
      print("multiplier = ${quantity.amount} * ${quantity.units.multiplier} = $multiplier");
      return aggregated.entries.map((elem) => MapEntry(elem.key, elem.value.multiply(multiplier)));
    });

    final result = expanded.fold<Map<Symbol, Quantity>>({}, (map, entry) =>
      map..update(entry.key, (value) => entry.value.addQuantity(value), ifAbsent: () => entry.value)
    );
    return result;
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
        const
          Mass = Dimensions(
            id: #Mass,
            components: {#Mass:1},
          ),
          FractionByMass = Dimensions(
            id: #FractionByMass,
            components: {},
          ),
          Carbs = Measurable(id: #Carbs, dimensionsId: #GramsPerHectogram),
          Fat = Measurable(id: #Fat, dimensionsId: #GramsPerHectogram),
          Fibre = Measurable(id: #Fibre, dimensionsId: #GramsPerHectogram),
          Protein = Measurable(id: #Protein, dimensionsId: #GramsPerHectogram),
          Sugar = Measurable(id: #Sugar, dimensionsId: #GramsPerHectogram),
          Salt = Measurable(id: #Salt, dimensionsId: #GramsPerHectogram);
        final
          tahini = BasicIngredient(
            id: #Tahini,
            contents: {
              Carbs.id: Units.GramsPerHectogram.times(1),
              Fat.id: Units.GramsPerHectogram.times(2),
            },
          ),
          cabbage = BasicIngredient(
            id: #Cabbage,
            contents: {
              Carbs.id: Units.GramsPerHectogram.times(1),
              Fibre.id: Units.GramsPerHectogram.times(1),
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
        db.dimensions..add(Mass)..add(FractionByMass);
        db.units..add(Units.Grams)..add(Units.KiloGrams)
          ..add(Units.GramsPerHectogram)..add(Units.GramsPerKiloGram)..add(Units.GramsPerGram);
        db.measurables..add(Carbs)..add(Fat)..add(Fibre)..add(
            Protein)..add(Sugar)..add(Salt);
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

