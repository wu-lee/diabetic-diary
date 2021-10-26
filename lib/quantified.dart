

import 'database.dart';
import 'dimensions.dart';
import 'indexable.dart';
import 'measureable.dart';
import 'quantity.dart';
import 'translation.dart';

/// Something with an ID which has a list of zero or more Measurables.
///
/// A common abstract base type for Edible and Measurable
abstract class Quantified implements Indexable {
  const Quantified();

  Map<Symbol, Quantity> get contents;

  static String formatContents(Map<Symbol, Quantity> contents) {
    final entries = contents.entries.map((e) {
      final quantity = e.value.format();
      return "#${symbolToString(e.key)}: $quantity";
    });
    return "{${entries.join(",")}}";
  }

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
      if (item.value.units.dimensionsId != measurable.dimensionsId)
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

}