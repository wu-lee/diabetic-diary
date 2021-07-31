

import 'indexable.dart';

/// A common abstract base type for Edible and Measurable
abstract class EdibleContent extends Indexable {
  EdibleContent({required Symbol id}) : super(id: id);
}