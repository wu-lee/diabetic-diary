

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

