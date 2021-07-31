import 'package:flutter/foundation.dart';

import 'indexable.dart';
import 'units.dart';

/// Represents a measurement dimension, in the sense of dimensional analysis of quantities
class Dimensions implements Indexable {

  final Symbol id;

  /// Components are the basis values which are combined to define a dimensioned value
  ///
  /// The map is between a dimension symbol and an exponent to which that dimension is
  /// raised.
  ///
  /// For example, dimensions of speed would have components of distance (^1)
  /// and time (^-1)
  final Map<Symbol, int> components;

  const Dimensions({required this.id, required this.components});

  @override
  bool operator== (Object that) => equals(that);

  @override
  int get hashCode => components.hashCode;

  bool equals(Object? that) => that is Dimensions &&
      id == that.id &&
      mapEquals(components, that.components);

  Units units(Symbol unitsId, multiplier) => Units(unitsId, id, multiplier);
}
