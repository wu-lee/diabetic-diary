
import 'indexable.dart';
import 'translation.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
class Measurable implements Indexable {
  final Symbol id;
  final Symbol dimensionsId;
  const Measurable({required this.id, required this.dimensionsId});

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
}
