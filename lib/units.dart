
import 'indexable.dart';
import 'quantity.dart';
import 'translation.dart';


/// Represents a unit in a particular kind of dimensions
class Units extends Indexable {
  final Symbol id;
  final Symbol dimensionsId;

  /// How large this unit is relative to the base unit for the dimension
  final num multiplier;

  static const Micrograms = Units(#ug, #Mass, 0.000001);
  static const Milligrams = Units(#mg, #Mass, 0.001);
  static const Grams = Units(#g, #Mass, 1);
  static const Kilograms = Units(#kg, #Mass, 1000);
  static const GramsPerMilligram = Units(#g_per_mg, #FractionByMass, 1000);
  static const GramsPerCentigram = Units(#g_per_cg, #FractionByMass, 100);
  static const GramsPerGram = Units(#g_per_g, #FractionByMass, 1);
  static const GramsPerHectogram = Units(#g_per_hg, #FractionByMass, 0.01);
  static const GramsPerKilogram = Units(#g_per_kg, #FractionByMass, 0.001);
  static const Joules = Units(#J, #Energy, 1);
  static const Kilojoules = Units(#kJ, #Energy, 1000);
  static const Calories = Units(#cal, #Energy, 4.184);
  static const Kilocalories = Units(#kcal, #Energy, 4184);
  static const JoulesPerGram = Units(#J_per_g, #EnergyByMass, 1);
  static const JoulesPerHectogram = Units(#J_per_hg, #Energy, 0.01);
  static const JoulesPerKilogram = Units(#J_per_kg, #Energy, 0.001);
  static const KilojoulesPerGram = Units(#kJ_per_g, #EnergyByMass, 1000);
  static const KilojoulesPerHectogram = Units(#kJ_per_g, #EnergyByMass, 10);
  static const CaloriesPerGram = Units(#cal_per_g, #EnergyByMass, 4.184);
  static const KilocaloriesPerGram = Units(#kcal_per_g, #EnergyByMass, 4184);
  static const KilocaloriesPerHectogram = Units(#kcal_per_hg, #EnergyByMass, 41.84);

  const Units(this.id, this.dimensionsId, this.multiplier) : super(id: id);

  @override
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Units &&
        that.runtimeType == this.runtimeType) {
      return dimensionsId == that.dimensionsId && id == that.id && multiplier == that.multiplier;
    }
    return false;
  }
  @override
  int get hashCode => dimensionsId.hashCode ^ id.hashCode ^ multiplier.hashCode;

  Quantity times(num amount) {
    return Quantity(amount, this);
  }

  @override
  String toString() => format();

  String format() => "Units(id: ${symbolToString(id)}, dimensionId: ${symbolToString(dimensionsId)}, multiplier: ${multiplier})";

  static Units get rogueValue => Units(Symbol(''), Symbol(''), 0);
}
