
import 'indexable.dart';
import 'quantity.dart';
import 'translation.dart';


/// Represents a unit in a particular kind of dimensions
class Units extends Indexable {
  final Symbol id;
  final Symbol dimensionsId;
  final num multiplier;

  static const MicroGrams = Units(#ug, #Mass, 0.000001);
  static const MilliGrams = Units(#mg, #Mass, 0.001);
  static const Grams = Units(#g, #Mass, 1);
  static const KiloGrams = Units(#kg, #Mass, 1000);
  static const GramsPerMilligram = Units(#g_per_mg, #FractionByMass, 1000);
  static const GramsPerCentigram = Units(#g_per_cg, #FractionByMass, 100);
  static const GramsPerGram = Units(#g_per_g, #FractionByMass, 1);
  static const GramsPerHectogram = Units(#g_per_hg, #FractionByMass, 0.01);
  static const GramsPerKiloGram = Units(#g_per_kg, #FractionByMass, 0.001);

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
  String toString() => "Units(id: ${TL8(id)}, dims: ${TL8(dimensionsId)}, multiplier: $multiplier)";


  static Units get rogueValue => Units(Symbol(''), Symbol(''), 0);
}
