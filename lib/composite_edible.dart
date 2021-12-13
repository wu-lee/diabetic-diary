import 'database.dart';
import 'dimensions.dart';
import 'edible.dart';
import 'measureable.dart';
import 'quantified.dart';
import 'quantity.dart';

/// Represents something edible, which contains a [Quantified] list of nutrient statistics
///
/// The physical contents may be expressed differently in some cases -
/// specifically see [Dish]
abstract class CompositeEdible extends Edible {
  const CompositeEdible();

  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on Dishes, Meals
  num get totalMass =>
      contents.values.fold(
          0,
              (sum, quantity) => sum + quantity.units.multiplier*quantity.amount
      );

  Future<Map<Symbol, Quantity>> invalidContents(Database db, [Map<Symbol, Measurable>? cache]);

  /// Checks for contents with inconsistent units.
  ///
  /// Specifically, this expects all contents to have contents with units of #Mass.
  ///
  /// If [cache] is supplied, uses this for keeping a shared cache of measurables
  /// for a little added speed.
  ///
  /// Returns a list of maps of invalid content items - obviously, this list will be empty
  /// if the contents are fully valid.
  Future<Map<Symbol, Quantity>> invalidMeasurableContents(Database db, [Map<Symbol, Measurable>? cache]) async {
    cache ??= {};
    final invalids = <Symbol, Quantity>{};
    for(final item in contents.entries) {
      final measurable = cache[item.key] ??= await db.measurables.fetch(item.key);
      if (item.value.units.dimensionsId != measurable.defaultUnits.dimensionsId)
        invalids[item.key] = item.value;
    }
    return invalids;
  }

  /// Checks for contents with inconsistent units.
  ///
  /// Specifically, this expects all contents to have contents with units of #Mass.
  ///
  /// If [cache] is supplied, uses this for keeping a shared cache of measurables
  /// for a little added speed.
  ///
  /// Returns a list of maps of invalid content items - obviously, this list will be empty
  /// if the contents are fully valid.
  Future<Map<Symbol, Quantity>> invalidMassContents(Database db, [Map<Symbol, Measurable>? cache]) async {
    cache ??= {};
    final invalids = <Symbol, Quantity>{};
    for(final item in contents.entries) {
      if (item.value.units.dimensionsId != Dimensions.Mass.id)
        invalids[item.key] = item.value;
    }
    return invalids;
  }

  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on Dishes, Meals
  static num getTotalMass(Map<Symbol, Quantity> contents) =>
      contents.values.fold(
          0,
              (sum, quantity) => sum + quantity.units.multiplier*quantity.amount
      );
}

