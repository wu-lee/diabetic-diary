import 'indexable.dart';

/// An Indexable object with a label
abstract class Labelled extends Indexable {
  final String label;

  const Labelled({required this.label, required Symbol id}) : super(id: id);
}