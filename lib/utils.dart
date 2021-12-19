

import 'package:diabetic_diary/composite_edible.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'database.dart';
import 'edible.dart';
import 'quantity.dart';
import 'translation.dart';
import 'units.dart';

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

Widget totalMassText(Database db, Symbol id, Map<Symbol, Quantity> contents) {
  return FutureBuilder<num>(
    future: db.getTotalMass(contents),
    builder: (context, snapshot) {
      String text = "calculating...";
      if (snapshot.hasData) {
        final totalMass = snapshot.data ?? 0;
        text = "${totalMass.toStringAsFixed(1)}g";
      }
      if (snapshot.hasError) {
        text = "error!";
        debugPrint("error calculating totalMass of $id:@ ${snapshot.stackTrace}");
      }
      return Text(text);
    }
  );
}

Widget portionSizeText(Database db, CompositeEdible edible) {
  return FutureBuilder<num>(
    future: db.getTotalMass(edible.contents),
    builder: (context, snapshot) {
      String text = "calculating...";
      if (snapshot.hasData) {
        final totalMass = snapshot.data ?? 0;
        final portionSize = totalMass/edible.portions;
        text = "${portionSize.toStringAsFixed(1)}g";
      }
      if (snapshot.hasError) {
        text = "error!";
        debugPrint("error calculating totalMass of ${edible.id}:@ ${snapshot.stackTrace}");
      }
      return Text(text);
    }
  );
}

Widget unitsDropDown({
  required Units units,
  required Future<Iterable<Units>> unitsList,
  required void onChanged(Units newUnits)
}) {
  return FutureBuilder<Iterable<Units>>(
      future: unitsList,
      builder: (context, snapshot) {
        final List<Units> unitsList = [];
        if (snapshot.hasData) {
          unitsList.addAll(snapshot.data ?? {});
          unitsList.sort((a, b) => a.multiplier.compareTo(b.multiplier));
        }
        if (snapshot.hasError) {
          debugPrint("error querying database for units: ${snapshot
              .stackTrace}");
        }
        final items = unitsList.map((e) =>
            DropdownMenuItem<Units>(
              child: Text(TL8(e.id)),
              value: e,
            )
        ).toList();
        return DropdownButton<Units>(
          items: items,
          value: units,
          onChanged: (newUnits) {
            if (newUnits == null || newUnits == units)
              return;
            onChanged(newUnits);
          },
        );
      }
  );
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

