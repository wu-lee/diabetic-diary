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
}

