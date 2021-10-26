

import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:flutter/foundation.dart';

import 'edible.dart';
import 'quantified.dart';
import 'quantity.dart';
import 'translation.dart';

/// Represents a meal diary entry
class Meal extends Edible {

  Meal({
    required this.id,
    required this.timestamp,
    required this.title,
    required this.notes,
    required this.contents,
  });

  @override
  final Symbol id;

  final DateTime timestamp;

  final String title;

  final String notes;

  @override
  final Map<Symbol, Quantity> contents;

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
      "Meal(id: ${symbolToString(id)}, $title, $timestamp, $notes, contents: ${Quantified.formatContents(contents)})";

  @override
  Future<Map<Symbol, Quantity>> invalidContents(Database db, [Map<Symbol, Measurable>? cache]) =>
      invalidMassContents(db, cache);
}