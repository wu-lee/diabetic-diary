import 'edible.dart';
import 'quantified.dart';
import 'quantity.dart';
import 'units.dart';

/// Represents an [Edible] with a concrete list of other [Edible]s as [contents]
///
/// As distinct from those like [BasicIngredient] which do not have a specific
/// [totalMass], being made up of fractional amounts of nutritional components.
abstract class CompositeEdible extends Edible {
  const CompositeEdible();

  /// Defines the number of portions the listed contents represents
  ///
  /// [portionSize] is calculated from this in derived classes
  num get portions;

  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on Dishes, Meals
  num get totalMass => getTotalMass(contents);

  /// The mass of one portion, in grams.
  ///
  /// Calculated from [totalMass] and [portions].
  @override
  num get portionSize => totalMass / portions;



  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass and do not overlap!
  /// In other words, only works on [CompositeEdible] (not [BasicIngredient])
  static num getTotalMass(Map<Symbol, Quantity> contents) =>
      contents.values.fold(
          0, (sum, quantity) => sum + quantity.units.multiplier*quantity.amount
      );
}

