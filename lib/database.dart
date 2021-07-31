
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/translation.dart';

import 'dimensions.dart';
import 'edible.dart';
import 'edible_content.dart';
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

  Future<int> get version;

//  AsyncDataCollection<Measurable> get compositionStatistics;
//  AsyncDataCollection<Ingredient> get ingredients;
//  AsyncDataCollection<Dish> get dishes;

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

  Future<String> formatEdible(Edible edible) async => "Edible(id: ${TL8(edible.id)}, contents: ${await formatContents(edible.contents)})";

  Future<String> formatContents(Map<Symbol, Quantity> contents) async {
    final entries = contents.entries.map((e) async {
      final quantity = await formatQuantity(e.value);
      return "#${TL8(e.key)}: $quantity";
    });
    return "{"+(await Future.wait(entries)).join(",")+"}";
  }

  /// Deeply traverse the edibles with the given ids, and return an index
  /// of all edibles and measurables encountered. Measurables are irreducible
  /// nutritional components and therefore have no contents, just a dimensionId.
  Future<Map<Symbol, EdibleContent>> traverseContents(Iterable<Symbol> ids) async {
    // expand all the symbols into Edibles recursively
    final index = <Symbol, EdibleContent>{};
    final pending = ids.toSet();

    // We use conventional loops, not closures here, so we can avoid a cascading
    // chain of the async/await caused by DB lookups.
    while(pending.isNotEmpty) {
      final id = pending.first;
      pending.remove(id);
      if (index.containsKey(id))
        continue;
      final edible = await edibles.maybeGet(id);
      if (edible == null) {
        // Not a known edible, presumably a measurable?
        final measurable = await measurables.maybeGet(id);
        if (measurable == null)
          throw new RangeError("Unknown edible $id"); // Nope, throw
        index[id] = measurable;
        continue;
      }
      index[id] = edible;
      pending.addAll(edible.contents.keys);
    }
    return index;
  }

  /// Convert the content list of Edibles into a content list of nutritional components
  ///
  Future<Map<Symbol, Quantity>> aggregate(Map<Symbol, Quantity> contents) async {
    return _aggregate(contents, await traverseContents(contents.keys));
  }

  /// Convert the content list of Edibles into a content list of nutritional components
  ///
  Map<Symbol, Quantity> _aggregate(Map<Symbol, Quantity> contents, Map<Symbol, EdibleContent> index) {

    final expanded = contents.entries.expand((elem) {
      final id = elem.key;
      final quantity = elem.value;

      // All edible contents must be in the same dimensions, i.e. fraction by mass.
      //assert(quantity.units.dimensionsId == #FractionByMass);

      final item = index[id];
      if (item == null)
        return <MapEntry<Symbol, Quantity>>[];

      if (item is Measurable)
        return [elem];

      final aggregated = _aggregate((item as Edible).contents, index);

      // Multiply this edible's contents by the parent edible's quantity
      final multiplier = quantity.amount * quantity.units.multiplier;
      print("multiplier = ${quantity.amount} * ${quantity.units.multiplier} = $multiplier");
      return aggregated.entries.map((elem) => MapEntry(elem.key, elem.value.multiply(multiplier)));
    });

    return expanded.fold({}, (map, entry) =>
      map..update(entry.key, (value) => entry.value.addQuantity(value), ifAbsent: () => entry.value)
    );
  }

  /// Sets up an empty database
  static Future<void> initialiseData(Database db) async {
    final int version = await db.version;
    print("Database $db version $version");
    if (version <= 0)
      schemas[schemas.length-1].init(db);
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
          MicroGrams = Units(#ug, #Mass, 0.000001),
          MilliGrams = Units(#mg, #Mass, 0.001),
          Grams = Units(#g, #Mass, 1),
          KiloGrams = Units(#kg, #Mass, 1000),
          GramsPerMilligram = Units(#g_per_mg, #FractionByMass, 0.001),
          GramsPerCentigram = Units(#g_per_cg, #FractionByMass, 0.01),
          GramsPerGram = Units(#g_per_g, #FractionByMass, 1),
          GramsPerHectogram = Units(#g_per_hg, #FractionByMass, 100),
          GramsPerKiloGram = Units(#g_per_kg, #FractionByMass, 1000),
          Carbs = Measurable(id: #Carbs, dimensionsId: #GramsPerHectogram),
          Fat = Measurable(id: #Fat, dimensionsId: #GramsPerHectogram),
          Fibre = Measurable(id: #Fibre, dimensionsId: #GramsPerHectogram),
          Protein = Measurable(id: #Protein, dimensionsId: #GramsPerHectogram),
          Sugar = Measurable(id: #Sugar, dimensionsId: #GramsPerHectogram),
          Salt = Measurable(id: #Salt, dimensionsId: #GramsPerHectogram);
        final
          tahini = Edible(
            id: #Tahini,
            contents: {
              Carbs.id: GramsPerHectogram.times(1),
              Fat.id: GramsPerHectogram.times(2),
            },
          ),
          cabbage = Edible(
            id: #Cabbage,
            contents: {
              Carbs.id: GramsPerHectogram.times(1),
              Fibre.id: GramsPerHectogram.times(1),
            },
          ),
          salad = Edible(
            id: #Salad,
            contents: {
              tahini.id: Grams.times(1),
              cabbage.id: Grams.times(2),
            },
          );
        db.dimensions..add(Mass)..add(FractionByMass);
        db.units..add(Grams)..add(KiloGrams)
          ..add(GramsPerHectogram)..add(GramsPerKiloGram)..add(GramsPerGram);
        db.measurables..add(Carbs)..add(Fat)..add(Fibre)..add(
            Protein)..add(Sugar)..add(Salt);
        db.edibles..add(tahini)..add(cabbage);
        db.edibles..add(salad);
      }
    )
  ];
}

class DbSchema {
  final void Function(Database db) init;

  const DbSchema({required this.init});
}

