import 'package:diabetic_diary/quantified.dart';
import 'package:flutter/foundation.dart';
import 'composite_edible.dart';
import 'database.dart';
import 'measureable.dart';
import 'quantity.dart';
import 'translation.dart';


class BasicIngredient extends CompositeEdible {

  @override
  final Symbol id;

  @override
  final String label;

  @override
  final Map<Symbol, Quantity> contents;

  /// Constant, therefore non-validating constructor.
  ///
  /// Make sure you only put IDs of [Measurables] in, and use the appropriate units,
  /// which should be fractional by mass (#FractionalMass, #EnergyByMass, etc.).
  const BasicIngredient({required this.id, required this.contents, required this.label});

  @override
  Map<Symbol, Quantity> aggregateContents(Map<Symbol, Quantified> index, bool Function(Symbol) seen) =>
      contents;

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is BasicIngredient &&
        that.runtimeType == this.runtimeType) {
      return id == that.id && mapEquals(contents, that.contents);
    }
    return false;
  }

  @override
  int get hashCode => aggregateContents.hashCode ^ id.hashCode;

  String format() =>
      "BasicIngredient(id: ${symbolToString(id)}, label: $label, contents: ${Quantified.formatContents(contents)})";

  @override
  Future<Map<Symbol, Quantity>> invalidContents(Database db, [Map<Symbol, Measurable>? cache]) =>
      invalidMeasurableContents(db, cache);
}

