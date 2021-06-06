
import 'entities/dish.dart';
import 'indexable.dart';
import 'entities/ingredient.dart';
import 'measurement_type.dart';
import 'unit.dart';

typedef DataMapper = R Function<I, T, R>(I, T);

abstract class DataCollection<I, T> {
  /// Count all items
  int count();

  /// Get a named item, or the otherwise value if absent
  T get(I index, [T otherwise = null]); // ignore: avoid_init_to_null

  /// Get a named item, or throw
  T fetch(I index);

  /// Get all items as a map
  Map<I, T> getAll();

  /// Put a named item
  void put(I index, T value);

  /// Put an unnamed item, generating a name for it
  I add(T value);

  /// Remove a named item
  void remove(I index);

  /// Remove all items, returning the number
  int removeAll();

  /// Retrieve all items of the collection in some arbitrary order, and pass to the visitor
  forEach(void Function(I, T) visitor);

  /// Invoke a named predefined query with some parameters. May throw an exception if this
  /// name doesn't exist or the parameters are wrong.
  Map<I, T> cannedQuery(Symbol name, [List<dynamic> parameters]);
}

class Database {
  Database({this.dimensions, this.measurementTypes, this.ingredients, this.dishes, this.compositionStatistics});

  final DataCollection<Symbol, Dimension> dimensions;
  final DataCollection<Symbol, MeasurementType> measurementTypes;
  final DataCollection<Symbol, MeasurementType> compositionStatistics;
  final DataCollection<Symbol, Ingredient> ingredients;
  final DataCollection<Symbol, Dish> dishes;
}


