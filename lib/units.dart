
import 'indexable.dart';
import 'quantity.dart';
import 'translation.dart';


/// Represents a unit in a particular kind of dimensions
class Units extends Indexable {
  final Symbol id;
  final Symbol dimensionsId;
  final num multiplier;

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
}
