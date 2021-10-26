import 'package:flutter/foundation.dart';

import 'edible.dart';
import 'indexable.dart';
import 'translation.dart';
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

  static const Mass = Dimensions(id: #Mass, components: {#Mass:1});
  static const FractionByMass = Dimensions(id: #FractionByMass, components: {});
  static const Energy = Dimensions(id: #Energy, components: {#Energy:1});
  static const EnergyByMass = Dimensions(id: #EnergyByMass, components: {#Energy:1,#Mass:-1});


  const Dimensions({required this.id, required this.components});

  @override
  bool operator== (Object that) => equals(that);

  @override
  int get hashCode => components.hashCode;

  bool equals(Object? that) => that is Dimensions &&
      id == that.id &&
      mapEquals(components, that.components);

  Units units(Symbol unitsId, multiplier) => Units(unitsId, id, multiplier);

  String format() => "Dimensions(id: ${symbolToString(id)}, components: ${_formatComponents()})";

  String _formatComponents() => "{"+components.entries.map((e) => "${symbolToString(e.key)}: ${e.value}").join(",")+"}";
}
