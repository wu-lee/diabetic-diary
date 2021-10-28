

import 'package:flutter/foundation.dart';

import 'basic_ingredient.dart';
import 'database.dart';
import 'dimensions.dart';
import 'indexable.dart';
import 'meal.dart';
import 'measureable.dart';
import 'quantity.dart';
import 'seen_check.dart';
import 'translation.dart';

/// Something with an ID which has a list of zero or more [Measurable]s.
///
/// More specifically, all the contents units must be expressed as something
/// (mass, energy, etc.) per unit of mass. Although it is not necessarily a complete
/// non-overlapping list with the same units. So for example, it may contain
/// both mass per unit and energy per unit measurements, and/or measurements of
/// fat and saturated fat (where fat includes saturated fat). The important thing
/// is that they can be aggregated in the same way to create a net Quantified,
/// without needing to divide the constituent quantities to get back to
/// fractional measurements.
///
/// A common abstract base type for [Edible] and [Measurable].
abstract class Quantified implements Indexable {

  const Quantified();

  /// A unique identifier
  ///
  /// Must be unique to all [Quantified] instances
  Symbol get id;

  /// A list of raw contents, with no aggregation
  Map<Symbol, Quantity> get contents;

  /// Returns an aggregated list of contents
  ///
  /// Looks up symbols using the index, and expands accordingly.
  Map<Symbol, Quantity> aggregateContents(Map<Symbol, Quantified> index, bool Function(Symbol) seen);

  static String formatContents(Map<Symbol, Quantity> contents) {
    final entries = contents.entries.map((e) {
      final quantity = e.value.format();
      return "#${symbolToString(e.key)}: $quantity";
    });
    return "{${entries.join(",")}}";
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
  static Map<Symbol, Quantity> aggregate(Map<Symbol, Quantity> contents, num totalMass, Map<Symbol, Quantified> index, bool Function(Symbol) seen) {
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
                "a cyclic reference to the dish ID #${symbolToString(id)}"
        );

      final item = index[id];
      if (item == null) {
        return <MapEntry<Symbol, Quantity>>[]; // Probably shouldn't ever happen
      }

      if (item is Measurable)
        return [elem];

      // If we get here we're not a Measurable.

      // Convert the contents of item into fractional content statistics
      final aggregated = item.aggregateContents(index, seen);

      // Multiply this item's content measurements by the parent item's quantity
      // (which must be a mass quantity), divided by the parent's net total contents mass.
      // The multiplier has no dimension, since the mass dimensions cancel,
      // which means the sub-quantity's dimensions will be preserved.
      final multiplier = quantity.amount * quantity.units.multiplier / totalMass;

      debugPrint("multiplier = ${quantity.amount} * ${quantity.units.multiplier} / $totalMass = $multiplier");
      return aggregated.entries.map((elem) {
        final measurable = index[elem.key] as Measurable; // something is wrong if not a Measurable!
        final subQuantity = elem.value.toUnits(measurable.defaultUnits);
        debugPrint("multiply ${subQuantity.format()} by $multiplier");
        return MapEntry(elem.key, subQuantity.multiply(multiplier));
      });
    });

    final result = expanded.fold<Map<Symbol, Quantity>>({}, (map, entry) =>
    map..update(entry.key, (value) => entry.value.addQuantity(value), ifAbsent: () => entry.value)
    );
    return result;
  }
}