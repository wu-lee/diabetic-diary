

import 'package:flutter/foundation.dart';

import 'composite_edible.dart';
import 'database.dart';
import 'measureable.dart';
import 'quantified.dart';
import 'quantity.dart';
import 'seen_check.dart';
import 'translation.dart';

/// Represents a meal diary entry
class Meal extends CompositeEdible {

  Meal({
    required this.id,
    required this.timestamp,
    required this.label,
    required this.notes,
    required this.contents,
    this.portions = 1,
  });

  @override
  final Symbol id;

  @override
  final num portions;

  final DateTime timestamp;

  @override
  final String label;

  final String notes;

  final Map<Symbol, Quantity> contents;

  @override
  Map<Symbol, Quantity> aggregateContents(Map<Symbol, Quantified> index, bool Function(Symbol) seen) =>
      Quantified.aggregate(contents, totalMass, index, chainSeenChecker(id, seen));


  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Meal &&
        that.runtimeType == this.runtimeType) {
      return id == that.id && mapEquals(contents, that.contents);
    }
    return false;
  }

  @override
  int get hashCode => contents.hashCode ^ id.hashCode;

  String format() =>
      "Meal(id: ${symbolToString(id)}, $label, $timestamp, $notes, contents: ${Quantified.formatContents(contents)})";

  @override
  Future<Map<Symbol, Quantity>> invalidContents(Database db, [Map<Symbol, Measurable>? cache]) =>
      invalidMassContents(db, cache);
}