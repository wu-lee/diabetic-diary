
import 'indexable.dart';
import 'unit.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
class MeasurementType<D extends Dimensions> implements Indexable {
  final Symbol name;
  final D units;
  const MeasurementType({this.name, this.units});
}
