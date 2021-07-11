import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/entities/dish.dart';
import 'package:diabetic_diary/entities/ingredient.dart';
import 'package:diabetic_diary/translation.dart';
import 'package:diabetic_diary/unit.dart';
import 'package:moor/ffi.dart';
// don't import moor_web.dart or moor_flutter/moor_flutter.dart in shared code
import 'package:moor/moor.dart';
//import 'package:moor/moor_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '../indexable.dart';
import '../measurement_type.dart';
import 'mock_database.dart';

// Include the autogenerated code
part 'moor_database.g.dart';

class _DimensionComponents extends Table {
  TextColumn get dimensionId => text()();
  TextColumn get componentId => text()();
  IntColumn get exponent => integer()();

  @override
  Set<Column> get primaryKey => {dimensionId, componentId};
}

class _DimensionUnits extends Table {
  TextColumn get dimensionId => text()();
  TextColumn get unitId => text()();
  RealColumn get multiplier => real()();

  @override
  Set<Column> get primaryKey => {dimensionId, unitId};
}

class _MeasurementTypes extends Table {
  TextColumn get id => text()();
  TextColumn get unitId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class _CompositionStatistics extends Table {
  TextColumn get id => text()();
  TextColumn get unitId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
class _Ingredients extends Table {
  TextColumn get id => text()();
  TextColumn get measurementId => text()();
  TextColumn get unitId => text()();
  RealColumn get amount => real()();

  @override
  Set<Column> get primaryKey => {id, measurementId};
}

@DataClassName("_Dish")
class _Dishes extends Table {
  TextColumn get id => text()();
  TextColumn get ingredientId => text()();
  TextColumn get unitId => text()();
  RealColumn get amount => real()();

  @override
  Set<Column> get primaryKey => {id, ingredientId};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
//    return WebDatabase('db');
  });
}

@UseMoor(tables: [_DimensionUnits, _DimensionComponents, _MeasurementTypes, _CompositionStatistics, _Ingredients, _Dishes])
class _MoorDatabase extends _$_MoorDatabase {
  // we tell the database where to store the data with this constructor
  _MoorDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}


class MoorDatabase extends Database {
  final _MoorDatabase db;

  MoorDatabase(this.db) :
        dimensions = MoorDimensionsCollection(db),
        units = MoorUnitsCollection(db),
        measurementTypes = MoorMTypeCollection(db),
        compositionStatistics = MoorCStatCollection(db),
        ingredients = MoorIngredientCollection(db),
        dishes = MockDataCollection<Dish>(),
        config = MockDataCollection<DPair>();

  static MoorDatabase create() {
    return MoorDatabase(_MoorDatabase());
  }


  @override
  final AsyncDataCollection<Dimensions> dimensions;

  @override
  final AsyncDataCollection<Units> units;

  @override
  final AsyncDataCollection<MeasurementType> measurementTypes;

  @override
  final AsyncDataCollection<MeasurementType> compositionStatistics;

  @override
  final AsyncDataCollection<Ingredient> ingredients;

  @override
  final AsyncDataCollection<Dish> dishes;

  @override
  final AsyncDataCollection<DPair> config;
}

abstract class MoorDataCollection<D extends DataClass, D2 extends Indexable, TI extends TableInfo> implements AsyncDataCollection<D2> {
  final _MoorDatabase db;
  final TI tableInfo;
  final GeneratedTextColumn idCol;

  MoorDataCollection(this.db, this.tableInfo, this.idCol);

  Insertable<D> valueToRow(D2 val);
  D2 rowToValue(D row);

  @override
  Future<Symbol> add(D2 value) async {
    final row = valueToRow(value);
//    final result = await db.into(tableInfo).insertOnConflictUpdate(row);
    final result = await db.into(tableInfo).insert(row);
    print("result "+result.toString());
    return Future(() => value.id);
  }

  @override
  Future<Map<Symbol, D2>> cannedQuery(Symbol name, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<D2> fetch(Symbol index) async {
    final results = db
      .select(tableInfo)
      ..where((a) => idCol.equals(symbolToString(index)));
    final row = await results.getSingle();
    // Convert the list of rows into a map from dimension id to exponent
    try {
      return rowToValue(row);
    }
    catch(e) {
      throw Exception("no such thing as "+symbolToString(index));
    }
  }

  @override
  void forEach(void Function(Symbol p1, D2 p2) visitor) {
    // TODO: implement forEach
  }

  @override
  Future<D2> get(Symbol index, D2 otherwise) async {
    final results = db
        .select(tableInfo)
      ..where((a) => idCol.equals(symbolToString(index)));
    final row = await results.getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  Future<Map<Symbol, D2>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<D2?> maybeGet(Symbol index, [D2? otherwise]) async {
    final results = db
        .select(tableInfo)
      ..where((u) => idCol.equals(symbolToString(index)));
    final row = await results.getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  void put(Symbol index, D2 value) {
    // TODO: implement put
  }

  @override
  Future<int> remove(Symbol index) async {
    assert(tableInfo == db.dimensionUnits);
    final results = db
        .delete(tableInfo)
      ..where((u) => idCol.equals(symbolToString(index)));
    return results.go();
  }

  @override
  Future<int> removeAll() {
    assert(tableInfo == db.dimensionUnits);
    final results = db
        .delete(tableInfo);
    return results.go();
  }

}
/* FIXME experimental more concrete implementation of Units collection
abstract class MoorDimensionUnitsCollection implements AsyncDataCollection<D2> {
  final _MoorDatabase db;
  final tableInfo;
  final GeneratedTextColumn idCol;

  MoorDimensionUnitsCollection(this.db, this.idCol) :
      this.tableInfo = db.dimensionUnits,
      this.idCol = db.dimensionUnits.unitId;

  Insertable<D> valueToRow(D2 val);
  D2 rowToValue(D row);

  @override
  Future<Symbol> add(D2 value) async {
    final row = valueToRow(value);
//    final result = await db.into(tableInfo).insertOnConflictUpdate(row);
    final result = await db.into(tableInfo).insert(row);
    print("result "+result.toString());
    return Future(() => value.id);
  }

  @override
  Future<Map<Symbol, D2>> cannedQuery(Symbol name, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<D2> fetch(Symbol index) async {
    final results = db
        .select(tableInfo)
      ..where((a) => idCol.equals(symbolToString(index)));
    final row = await results.getSingle();
    // Convert the list of rows into a map from dimension id to exponent
    try {
      return rowToValue(row);
    }
    catch(e) {
      throw Exception("no such thing as "+symbolToString(index));
    }
  }

  @override
  void forEach(void Function(Symbol p1, D2 p2) visitor) {
    // TODO: implement forEach
  }

  @override
  Future<D2> get(Symbol index, D2 otherwise) async {
    final results = db
        .select(tableInfo)
      ..where((a) => idCol.equals(symbolToString(index)));
    final row = await results.getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  Future<Map<Symbol, D2>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<D2?> maybeGet(Symbol index, [D2? otherwise]) async {
    final results = db
        .select(tableInfo)
      ..where((u) => idCol.equals(symbolToString(index)));
    final row = await results.getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  void put(Symbol index, D2 value) {
    // TODO: implement put
  }

  @override
  Future<int> remove(Symbol index) async {
    assert(tableInfo == db.dimensionUnits);
    final results = db
        .delete(tableInfo)
      ..where((u) => idCol.equals(symbolToString(index)));
    return results.go();
  }

  @override
  Future<int> removeAll() {
    assert(tableInfo == db.dimensionUnits);
    final results = db
        .delete(tableInfo);
    return results.go();
  }

}
*/

class MoorDimensionsCollection implements AsyncDataCollection<Dimensions> {
  final _MoorDatabase db;

  MoorDimensionsCollection(this.db);

  @override
  Future<Symbol> add(Dimensions dimensions) {
    dimensions.components.forEach((key, value) {
      db.into(db.dimensionComponents).insert(_DimensionComponentsCompanion(
        dimensionId: Value(symbolToString(dimensions.id)),
        componentId: Value(symbolToString(key)),
        exponent: Value(value),
      ));
    });
    return Future(() => dimensions.id);
  }

  @override
  Future<Map<Symbol, Dimensions>> cannedQuery(Symbol name, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() async {
    final count = db.dimensionUnits.dimensionId.count(distinct: true);
    final query = db.selectOnly(db.dimensionUnits)
      ..addColumns([count]);

    final r = await query.getSingle();
    return r.read(count);
  }

  @override
  Future<Dimensions> fetch(Symbol index) async {
    final results = db
      .select(db.dimensionComponents, distinct: true)
      ..where((a) => a.dimensionId.equals(symbolToString(index)));
    final rows = await results.get();
    // Convert the list of rows into a map from dimension id to exponent
    final components = Map.fromEntries(rows.map((component) =>
        MapEntry(Symbol(component.dimensionId), component.exponent)));
    // Use that map to construct a Dimensions instance
    return Dimensions(id: index, components: components); 
  }

  @override
  void forEach(void Function(Symbol p1, Dimensions p2) visitor) {
    // TODO: implement forEach
  }

  @override
  Future<Dimensions> get(Symbol index, Dimensions otherwise) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Map<Symbol, Dimensions>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Dimensions?> maybeGet(Symbol index, [Dimensions? otherwise]) async {
    final results = db
        .select(db.dimensionComponents, distinct: true)
      ..where((a) => a.dimensionId.equals(symbolToString(index)));
    final rows = await results.get();
    if (rows.isEmpty)
      return otherwise;

    // Convert the list of rows into a map from dimension id to exponent
    final components = Map.fromEntries(rows.map((component) =>
        MapEntry(Symbol(component.componentId), component.exponent)));

    // Use that map to construct a Dimensions instance
    return Dimensions(id: index, components: components);
  }

  @override
  void put(Symbol index, Dimensions value) {
    // TODO: implement put
  }

  @override
  Future<int> remove(Symbol index) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<int> removeAll() {
    final results = db
        .delete(db.dimensionComponents);
    return results.go();
  }
}

abstract class MoorUnitRefCollection<D extends DataClass, D2 extends Indexable, TI extends TableInfo> implements AsyncDataCollection<D2> {
  final _MoorDatabase db;
  final TI tableInfo;
  final GeneratedTextColumn idCol;
  final GeneratedTextColumn joinCol;
  final JoinedSelectStatement<Table, dynamic> commonQuery;

  MoorUnitRefCollection(this.db, this.tableInfo, this.idCol, this.joinCol) :
      commonQuery = db.select(tableInfo)
        .join([
          leftOuterJoin(db.dimensionUnits, joinCol.equalsExp(db.dimensionUnits.unitId))
        ]);

  Insertable<D> valueToRow(D2 val);
  D2 rowToValue(D row);

  @override
  Future<Symbol> add(D2 value) async {
    final row = valueToRow(value);
    await db.into(tableInfo).insertOnConflictUpdate(row);
    return Future(() => value.id);
  }

  @override
  Future<Map<Symbol, D2>> cannedQuery(Symbol name, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<MeasurementType> fetch(Symbol index) async {
    final results = commonQuery
      ..where(db.dimensionUnits.unitId.equals(symbolToString(index)));

    final value = await results.getSingle();
    final unitsRow = value.readTable(db.dimensionUnits);
    final units = Units(Symbol(unitsRow.unitId), Symbol(unitsRow.dimensionId), unitsRow.multiplier);
    return MeasurementType(id: index, units: units);
  }

  @override
  void forEach(void Function(Symbol p1, MeasurementType p2) visitor) {
    // TODO: implement forEach
  }

  @override
  Future<MeasurementType> get(Symbol index, MeasurementType otherwise) async {
    final results = commonQuery
      ..where(db.dimensionUnits.unitId.equals(symbolToString(index)));

    final value = await results.getSingleOrNull();
    if (value == null)
      return otherwise;
    final unitsRow = value.readTable(db.dimensionUnits);
    final units = Units(Symbol(unitsRow.unitId), Symbol(unitsRow.dimensionId), unitsRow.multiplier);
    return MeasurementType(id: index, units: units);
  }

  @override
  Future<Map<Symbol, MeasurementType>> getAll() async {
    final results = db
        .select(db.compositionStatistics)
        .join([
          leftOuterJoin(db.dimensionUnits, db.compositionStatistics.unitId.equalsExp(db.dimensionUnits.unitId))
        ]);

    final values = await results.get();
    return Map.fromEntries(values.map((row) {
      final val = rowToValue(row); // FIXME why is this nullable?
      return MapEntry(val.id, val);
    }));
  }

  @override
  Future<MeasurementType?> maybeGet(Symbol index, [MeasurementType? otherwise]) {
    // TODO: implement maybeGet
    throw UnimplementedError();
  }

  @override
  void put(Symbol index, MeasurementType value) {
    // TODO: implement put
  }

  @override
  Future<int> remove(Symbol index) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<int> removeAll() async {
    final results = db
        .delete(db.compositionStatistics);
      return results.go();
  }

}

class MoorCStatCollection extends MoorUnitRefCollection<$_CompositionStatisticsTable, _CompositionStatistic> {

  MoorCStatCollection(_MoorDatabase db) : super(db, db.compositionStatistics, db.compositionStatistics.unitId);

  @override
  MeasurementType rowToValue(TypedResult row) {
    final id = Symbol(row.read(db.compositionStatistics.id) ?? ''); // FIXME why is this nullable?
    final unitsRow = row.readTable(db.dimensionUnits);
    final units = Units(Symbol(unitsRow.unitId), Symbol(unitsRow.dimensionId), unitsRow.multiplier);
    return MeasurementType(id: id, units: units);
  }

  @override
  Insertable<_CompositionStatistic> valueToRow(MeasurementType val) {
    return _CompositionStatistic(id: symbolToString(val.id), unitId: symbolToString(val.units.id));
  }
}

class MoorMTypeCollection extends MoorUnitRefCollection<$_MeasurementTypesTable, _MeasurementType> {

  MoorMTypeCollection(_MoorDatabase db) : super(db, db.measurementTypes, db.measurementTypes.unitId);

  @override
  MeasurementType rowToValue(TypedResult row) {
    final id = Symbol(row.read(db.compositionStatistics.id) ?? ''); // FIXME why is this nullable?
    final unitsRow = row.readTable(db.dimensionUnits);
    final units = Units(Symbol(unitsRow.unitId), Symbol(unitsRow.dimensionId), unitsRow.multiplier);
    return MeasurementType(id: id, units: units);
  }

  @override
  Insertable<_MeasurementType> valueToRow(MeasurementType val) {
    return _MeasurementType(id: symbolToString(val.id), unitId: symbolToString(val.units.id));
  }
}

abstract class MoorEntityCollection<T extends Table, D extends DataClass, D2 extends Indexable> implements AsyncDataCollection<D2> {
  final _MoorDatabase db;
  final TableInfo<T, D> tableInfo;
  final GeneratedTextColumn joinCol;
  final GeneratedTextColumn idCol;
  final JoinedSelectStatement<Table, dynamic> commonQuery;


  MoorEntityCollection(this.db, this.tableInfo, this.idCol, this.joinCol, this.commonQuery);

  D2 rowsToValue(Iterable<TypedResult> row);
  Iterable<Insertable<D>> valueToRows(D2 val);

  @override
  Future<Symbol> add(D2 value) async {
    final rows = valueToRows(value); // FIXME stream this?
    await Future.forEach(
        rows,
        (Insertable<D> row) => db.into(tableInfo).insertOnConflictUpdate(row),
    );
    return value.id;
  }

  @override
  Future<Map<Symbol, D2>> cannedQuery(Symbol name, [List? parameters]) {
    // TODO: implement cannedQuery
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<D2> fetch(Symbol index) async {
    final results = db
      .select(tableInfo)
      .join([
        leftOuterJoin(db.dimensionUnits, db.dimensionUnits.unitId.equalsExp(joinCol)) // FIXME get compstats
      ])
      ..where(idCol.equals(symbolToString(index)));
    final rows = await results.get();
    // Convert the list of rows into a map from dimension id to exponent
    try {
      return rowsToValue(rows);
    }
    catch(e) {
      throw Exception("no such thing as "+symbolToString(index));
    }
  }

  @override
  void forEach(void Function(Symbol p1, D2 p2) visitor) {
    // TODO: implement forEach
  }

  @override
  Future<D2> get(Symbol index, D2 otherwise) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Map<Symbol, D2>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<D2?> maybeGet(Symbol index, [D2? otherwise]) {
    // TODO: implement maybeGet
    throw UnimplementedError();
  }

  @override
  void put(Symbol index, D2 value) {
    // TODO: implement put
  }

  @override
  Future<int> remove(Symbol index) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<int> removeAll() {
    // TODO: implement removeAll
    throw UnimplementedError();
  }

}

class MoorIngredientCollection extends MoorEntityCollection<$_IngredientsTable, _Ingredient, Ingredient> {

  MoorIngredientCollection(_MoorDatabase db) : super(
      db,
      db.ingredients,
      db.ingredients.id,
      db.ingredients.unitId,
      db.select(db.ingredients)
          .join([
        leftOuterJoin(db.dimensionUnits, db.ingredients.unitId.equalsExp(db.dimensionUnits.unitId))
      ])
  );

  @override
  Ingredient rowsToValue(Iterable<TypedResult> rows) {
    Symbol index = Symbol('');
    final stats = Map.fromEntries(rows.map((row) {
      final ingRow = row.readTable(db.ingredients);
      final unitsRow = row.readTable(db.dimensionUnits);
      final measId = Symbol(ingRow.measurementId);
      final unitsId = Symbol(ingRow.unitId);
      final dimId = Symbol(unitsRow.dimensionId);
      final multiplier = unitsRow.multiplier;
      final units = Units(unitsId, dimId, multiplier);
      final measurementType = MeasurementType(id: measId, units: units);
      final quantity = Quantity(ingRow.amount, units);
      index = Symbol(ingRow.id);
      return MapEntry(measurementType, quantity);
    }));

    if (stats.isEmpty)
      throw Exception("Parameter `rows` is an empty list");

    // Use that map to construct an instance
    return Ingredient(id: index, compositionStats: stats);
  }

  @override
  Iterable<Insertable<_Ingredient>> valueToRows(Ingredient val)  {
    return val.compositionStats.entries
        .map((stat) => _Ingredient(
          id: symbolToString(val.id),
          measurementId: symbolToString(stat.key.id), //symbolToString(val.compositionStats.first()),
          unitId: symbolToString(stat.key.units.id),
          amount: stat.value.amount.toDouble(),
        )
    );
  }
}
/*
class MoorDishCollection extends MoorEntityCollection<$_DishesTable, _Dish, Dish> {

  MoorDishCollection(_MoorDatabase db) : super(
      db,
      db.dishes,
      db.dishes.id,
      db.dishes.unitId,
      db.select(db.dishes).join([
        leftOuterJoin(
          db.ingredients,
          db.dishes.ingredientId.equalsExp(db.ingredients.id)
        ),
        leftOuterJoin(
            db.measurementTypes,
            db.ingredients.measurementId.equalsExp(db.measurementTypes.id)
        ),
      ])
  )

  @override
  Dish rowsToValue(Iterable<TypedResult> rows) {
    Symbol index = Symbol('');
    final ingredients = Map.fromEntries(rows.map((row) {
      final dishRow = row.readTable(db.dishes);
      final compositionStats = row.readTable(db.dimensionUnits);
//      final unitsRow = row.readTable(db.dimensionUnits);
      final ingId = Symbol(dishRow.ingredientId);
      final unitsId = Symbol(dishRow.unitId);
      final dimId = Symbol(unitsRow.dimensionId);
      final multiplier = unitsRow.multiplier;
      final units = Units(unitsId, dimId, multiplier);
      //db.ingredients.
      final ingredient = Ingredient(id: ingId, compositionStats: compStats);
      final quantity = Quantity(dishRow.amount, units);
      index = Symbol(dishRow.id);
      return MapEntry(ingredient, quantity);
    }));

    if (ingredients.isEmpty)
      throw Exception("Parameter `rows` is an empty list");

    // Use that map to construct an instance
    return Dish(id: index, ingredients: ingredients);
  }

  @override
  Iterable<Insertable<_Dish>> valueToRows(Dish val)  {
    return val.compositionStats.entries
        .map((stat) => _Dish(
      id: symbolToString(val.id),
      measurementId: symbolToString(stat.key.id), //symbolToString(val.compositionStats.first()),
      unitId: symbolToString(stat.key.units.id),
      amount: stat.value.amount.toDouble(),
    )
    );
  }
}
*/
class MoorUnitsCollection extends MoorDataCollection<_DimensionUnit, Units, $_DimensionUnitsTable> {

  MoorUnitsCollection(_MoorDatabase db) : super(db, db.dimensionUnits, db.dimensionUnits.unitId);

  @override
  Units rowToValue(_DimensionUnit row) {
    return Units(Symbol(row.unitId), Symbol(row.dimensionId), row.multiplier);
  }

  @override
  Insertable<_DimensionUnit> valueToRow(Units val)  {
    return _DimensionUnit(
        dimensionId: symbolToString(val.dimensionId),
        unitId: symbolToString(val.id),
        multiplier: val.multiplier.toDouble(),
    );
  }
}