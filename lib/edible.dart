import 'package:flutter/foundation.dart';
import 'quantified.dart';
import 'quantity.dart';


class Edible implements Quantified {
  final Symbol id;
  final bool isDish;
  final Map<Symbol, Quantity> contents;

  const Edible({required this.id, this.isDish = false, required this.contents});

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



  static String format(Map<Edible, Quantity> ingredients) {
    return "ingredients ${ingredients.entries.map((e) => "${TL8(e.key.id)}: ${e.value.amount} ${TL8(e.value.units.id)}").join("; ")}";
  }*/
}

