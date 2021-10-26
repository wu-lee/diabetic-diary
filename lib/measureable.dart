
import 'package:diabetic_diary/quantity.dart';

import 'quantified.dart';
import 'translation.dart';
import 'units.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
class Measurable implements Quantified {
  final Symbol id;
  final Symbol dimensionsId;
  const Measurable({required this.id, required this.dimensionsId});

  static const Carbs = Measurable(id: #Carbs, dimensionsId: #FractionByMass);
  static const Fat = Measurable(id: #Fat, dimensionsId: #FractionByMass);
  static const SaturatedFat = Measurable(id: #SaturatedFat, dimensionsId: #FractionByMass);
  static const Fibre = Measurable(id: #Fibre, dimensionsId: #FractionByMass);
  static const Protein = Measurable(id: #Protein, dimensionsId: #FractionByMass);
  static const Sugar = Measurable(id: #Sugar, dimensionsId: #FractionByMass);
  static const Salt = Measurable(id: #Salt, dimensionsId: #FractionByMass);
  static const Energy = Measurable(id: #Energy, dimensionsId: #EnergyByMass);


  @override
  String toString() => "MeasurementType(id: ${TL8(id)}, dimensionId: $dimensionsId)";

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Measurable &&
        that.runtimeType == this.runtimeType) {
      return dimensionsId == that.dimensionsId && id == that.id;
    }
    return false;
  }

  @override
  int get hashCode => dimensionsId.hashCode ^ id.hashCode;

  @override
  Map<Symbol, Quantity> get contents => Map.unmodifiable({id: Quantity(1, Units.GramsPerHectogram)});

  String format() => "Measurable(id: ${symbolToString(id)}, units: ${symbolToString(dimensionsId)})";
}
