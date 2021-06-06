
import 'indexable.dart';
import 'unit.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
class MeasurementType<D extends Dimensions> implements Indexable {
  final Symbol id;
  final D units;
  const MeasurementType({this.id, this.units});
}
