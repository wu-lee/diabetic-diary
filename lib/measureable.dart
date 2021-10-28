
import 'package:diabetic_diary/quantity.dart';

import 'quantified.dart';
import 'translation.dart';
import 'units.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
///
class Measurable extends Quantified {
  final Symbol id;
  final Units defaultUnits;

  const Measurable({required this.id, required this.defaultUnits});

  static const Carbs = Measurable(id: #Carbs, defaultUnits: Units.GramsPerHectogram);
  static const Fat = Measurable(id: #Fat, defaultUnits: Units.GramsPerHectogram);
  static const SaturatedFat = Measurable(id: #SaturatedFat, defaultUnits: Units.GramsPerHectogram);
  static const Fibre = Measurable(id: #Fibre, defaultUnits: Units.GramsPerHectogram);
  static const Protein = Measurable(id: #Protein, defaultUnits: Units.GramsPerHectogram);
  static const Sugar = Measurable(id: #Sugar, defaultUnits: Units.GramsPerHectogram);
  static const Salt = Measurable(id: #Salt, defaultUnits: Units.GramsPerHectogram);
  static const Energy = Measurable(id: #Energy, defaultUnits: Units.KilocaloriesPerHectogram);

  @override
  Map<Symbol, Quantity> aggregateContents(Map<Symbol, Quantified> index, bool Function(Symbol p1) seen) {
    // TODO: implement aggregateContents
    throw UnimplementedError();
  }

  @override
  Map<Symbol, Quantity> get contents => {id: Quantity(1, defaultUnits)};

  @override
  String toString() => "MeasurementType(id: ${TL8(id)}, defaultUnits: ${defaultUnits.format()})";

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Measurable &&
        that.runtimeType == this.runtimeType) {
      return defaultUnits == that.defaultUnits && id == that.id;
    }
    return false;
  }

  @override
  int get hashCode => defaultUnits.hashCode ^ id.hashCode;

  String format() => "Measurable(id: ${symbolToString(id)}, defaultUnits: ${defaultUnits.format()})";
}
