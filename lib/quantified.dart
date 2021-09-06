

import 'indexable.dart';

/// Something with an ID which has a list of zero or more Measurables.
///
/// A common abstract base type for Edible and Measurable
abstract class Quantified extends Indexable {
  Quantified({required Symbol id}) : super(id: id);
}