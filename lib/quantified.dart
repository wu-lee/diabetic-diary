

import 'indexable.dart';
import 'quantity.dart';
import 'translation.dart';

/// Something with an ID which has a list of zero or more Measurables.
///
/// A common abstract base type for Edible and Measurable
abstract class Quantified implements Indexable {
  Map<Symbol, Quantity> get contents;

  static String formatContents(Map<Symbol, Quantity> contents) {
    final entries = contents.entries.map((e) {
      final quantity = e.value.format();
      return "#${symbolToString(e.key)}: $quantity";
    });
    return "{${entries.join(",")}}";
  }
}