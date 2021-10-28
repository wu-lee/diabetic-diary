import 'package:flutter/foundation.dart';
import 'composite_edible.dart';
import 'database.dart';
import 'measureable.dart';
import 'quantified.dart';
import 'quantity.dart';
import 'seen_check.dart';
import 'translation.dart';


class Dish extends CompositeEdible {
  final Symbol id;
  final Map<Symbol, Quantity> contents;

  /// Constant, therefore non-validating constructor.
  ///
  /// Make sure you only put IDs of [Edibles] in, and use the appropriate units,
  /// which should be mass.
  const Dish({required this.id, required this.contents});

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Dish &&
        that.runtimeType == this.runtimeType) {
      return id == that.id && mapEquals(contents, that.contents);
    }
    return false;
  }

  @override
  Map<Symbol, Quantity> aggregateContents(Map<Symbol, Quantified> index, SeenChecker seen) =>
      Quantified.aggregate(contents, totalMass, index, chainSeenChecker(id, seen));

  @override
  int get hashCode => contents.hashCode ^ id.hashCode;

  String format() =>
      "Dish(id: ${symbolToString(id)}, contents: ${Quantified.formatContents(contents)})";

  @override
  Future<Map<Symbol, Quantity>> invalidContents(Database db, [Map<Symbol, Measurable>? cache]) =>
      invalidMassContents(db, cache);
}

