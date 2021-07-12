import 'package:diabetic_diary/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'indexable.dart';
import 'quantity.dart';


class Edible implements Indexable {
  final Symbol id;
  final Map<Symbol, Quantity> contents;

  const Edible({required this.id, required this.contents});

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Edible &&
        that.runtimeType == this.runtimeType) {
      return id == that.id && mapEquals(contents, that.contents);
    }
    return false;
  }

  @override
  int get hashCode => contents.hashCode ^ id.hashCode;

  /*
  static bool _validate(final Map<Measurable, Quantity> compositionStats) {
    return compositionStats.entries.any(
            (e) => e.key.units.dims.components.isNotEmpty ||
                e.value.units.dims.components.isNotEmpty
    );
  }

  Edible.compose({required this.id, required Map<Edible, Quantity> ingredients}) :
    contents = aggregate(ingredients);


  static Map<Measurable, Quantity> aggregate(Map<Edible, Quantity> contents) {
    final Map<Measurable, Quantity> stats = {};
    contents.forEach((edible, quantityIngredient) {
      assert(quantityIngredient.units.dimensionsId == #Mass);
      edible.contents.forEach((measurable, quanity) {
        assert(measurable.units.dimensionsId == quanity.units.dimensionsId);
        Quantity quantity = stats[measurable] ?? Quantity(0, measurable.units);
        assert(quanity.units.dimensionsId == #FractionByMass);
        assert(quantityIngredient.units.dimensionsId == #Mass);
        stats[measurable] = quantity
            .addQuantity(quanity.multiply(quantityIngredient.amount*quantityIngredient.units.multiplier/quanity.units.multiplier));
      });
    });
    return Map.unmodifiable(stats);
  }

  static String format(Map<Edible, Quantity> ingredients) {
    return "ingredients ${ingredients.entries.map((e) => "${TL8(e.key.id)}: ${e.value.amount} ${TL8(e.value.units.id)}").join("; ")}";
  }*/
}

