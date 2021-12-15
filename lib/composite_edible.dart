import 'database.dart';
import 'dimensions.dart';
import 'edible.dart';
import 'measureable.dart';
import 'quantified.dart';
import 'quantity.dart';

/// Represents something edible, which contains a [Quantified] list of nutrient statistics
///
/// The physical contents may be expressed differently in some cases -
/// specifically see [Dish]
abstract class CompositeEdible extends Edible {
  const CompositeEdible();

  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on Dishes, Meals
  num get totalMass =>
      contents.values.fold(
          0,
              (sum, quantity) => sum + quantity.units.multiplier*quantity.amount
      );

  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on Dishes, Meals
  static num getTotalMass(Map<Symbol, Quantity> contents) =>
      contents.values.fold(
          0,
              (sum, quantity) => sum + quantity.units.multiplier*quantity.amount
      );
}

