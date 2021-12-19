import 'package:diabetic_diary/basic_ingredient.dart';

import 'dimensions.dart';
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

  /// The mass of one portion, in grams.
  ///
  /// Calculated from [totalMass] and [portions].
//  @override
//  num get portionSize => totalMass / portions;



  /// Get the total mass of the contents in grams
  ///
  /// Assumes that the contents all have units of mass/portions and do not overlap!
  /// In other words, only works on [CompositeEdible] (not [BasicIngredient])
  /// 
  /// The index has [Quantified] values rather than [Edibles] purely so it can be used
  /// within the function [Quantified.aggregate]. Any [Quantified] values are ignored.
  static num getTotalMass(Map<Symbol, Quantity> contents, Map<Symbol, Quantified> index) =>
      contents.entries.fold(
        0, (sum, entry) {
          final id = entry.key;
          final quantity = entry.value;
          num multiplier = quantity.units.multiplier; // multiplier converts to the base unit (g)

          // Deal with portion units. These indicate that the quantity has to
          // be multiplied by the mass of a portion, which needs to be calculated
          // differently depending on the class.
          if (quantity.units.dimensionsId == Dimensions.NumPortions.id) {
            final quantified = index[id];
            if (quantified is BasicIngredient) {
              //  Just multiply the amount by the portion size
              multiplier *= quantified.portionSize;
            }
            else if (quantified is CompositeEdible) {
              // Multiply the amount by portion size, which is
              // the total mass divided by the number of portions.
              // Total mass needs to be calculated first.
              // FIXME can we make this more efficient?
              final totalMass = CompositeEdible.getTotalMass(quantified.contents, index);
              multiplier = totalMass / quantified.portions;
            }
            // anything else, leave multiplier unchanged
          }

          return sum + multiplier * quantity.amount;
        }
      );
}

