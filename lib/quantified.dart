

import 'indexable.dart';
import 'quantity.dart';

/// Something with an ID which has a list of zero or more Measurables.
///
/// A common abstract base type for Edible and Measurable
abstract class Quantified implements Indexable {
  Map<Symbol, Quantity> get contents;
}