import 'package:flutter/foundation.dart';
import 'edible.dart';
import 'quantity.dart';


class BasicIngredient implements Edible {
  final Symbol id;
  final Map<Symbol, Quantity> contents;

  const BasicIngredient({required this.id, required this.contents});

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
  int get hashCode => contents.hashCode ^ id.hashCode;

/*
  static bool _validate(final Map<Measurable, Quantity> compositionStats) {
    return compositionStats.entries.any(
            (e) => e.key.units.dims.components.isNotEmpty ||
                e.value.units.dims.components.isNotEmpty
    );
  }

  BasicIngredient.compose({required this.id, required Map<BasicIngredient, Quantity> ingredients}) :
    contents = aggregate(ingredients);



  static String format(Map<BasicIngredient, Quantity> ingredients) {
    return "ingredients ${ingredients.entries.map((e) => "${TL8(e.key.id)}: ${e.value.amount} ${TL8(e.value.units.id)}").join("; ")}";
  }*/
}

