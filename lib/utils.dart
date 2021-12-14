

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'edible.dart';
import 'quantity.dart';
import 'translation.dart';

abstract class Functions {
  //static void noop0() {}
  //static void noop1<A>(A a) {}
  //static void noop2<A, B>(A a, B b) {}
  static Future<bool> thenTrue() => Future(() => true);
  static Future<bool> thenTrue1<T>(T t) => Future(() => true);
  //static Future<bool> thenFalse1<T>(T t) => Future(() => false);
  //static T identity<T>(T t) => t;
}

T? nullDebug<T>(String s) { debugPrint(s); return null; }

/// Colours a widget
Widget dbc(Widget w, {color: Colors.red}) {
  return Container(
    color: color,
    child: w,
  );
}

Map<Symbol, MapEntry<String, Quantity>> labelledQuantities(
    Map<Symbol, Quantity> quantities,
    Map<Symbol, Edible> edibles
) {
  return quantities.map((id, q) => MapEntry(id, MapEntry(edibles[id]?.label ?? '', q)));
}

Map<Symbol, MapEntry<String, String>> formatLabelledQuantities(
    Map<Symbol, Quantity> quantities,
    Map<Symbol, Edible> edibles
) {
  return quantities.map((id, q) => MapEntry(id, MapEntry(edibles[id]?.label ?? '', q.format())));
}

Map<Symbol, MapEntry<String, String>> formatLocalisedQuantities(
    Map<Symbol, Quantity> quantities
) {
  return quantities.map((id, q) => MapEntry(id, MapEntry(TL8(id), q.format())));
}

/// Rudimentary ID generator
class ID {
  final String prefix;
  final int value;

  ID([this.prefix = '']) :
        value = DateTime.now().millisecondsSinceEpoch;

  @override
  String toString() => "$prefix${value.toRadixString(16)}";
}

