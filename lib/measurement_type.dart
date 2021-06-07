
import 'indexable.dart';
import 'translation.dart';
import 'unit.dart';

/// Represents a category of dimensioned scalar measurement, like weight, volume, etc.
class MeasurementType implements Indexable {
  final Symbol id;
  final Units units;
  const MeasurementType({this.id, this.units});

  static String format(Map<MeasurementType, Quantity> measurements) {
    return "measurements ${measurements.entries.map((e) => "${TL8(e.key.id)} (${TL8(e.key.units.id)}): ${e.value.amount} ${TL8(e.value.units.id)}").join("; ")}";
  }
}
