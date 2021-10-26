import 'package:flutter/foundation.dart';
import 'edible.dart';
import 'quantified.dart';
import 'quantity.dart';
import 'translation.dart';


class Dish implements Edible {
  final Symbol id;
  final Map<Symbol, Quantity> contents;

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
  int get hashCode => contents.hashCode ^ id.hashCode;

  String format() =>
      "Dish(id: ${symbolToString(id)}, contents: ${Quantified.formatContents(contents)})";
}

