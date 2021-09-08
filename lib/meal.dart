

import 'package:flutter/foundation.dart';

import 'edible.dart';
import 'quantity.dart';

/// Represents a meal diary entry
class Meal implements Edible {

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
}