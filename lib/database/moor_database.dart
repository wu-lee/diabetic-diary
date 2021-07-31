import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/translation.dart';
import 'package:diabetic_diary/units.dart';
import 'package:moor/ffi.dart';
// don't import moor_web.dart or moor_flutter/moor_flutter.dart in shared code
import 'package:moor/moor.dart';
//import 'package:moor/moor_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '../dimensions.dart';
import '../edible.dart';
import '../indexable.dart';
import '../quantity.dart';

// Include the autogenerated code
part 'moor_database.g.dart';

class _Dimensions extends Table {
  TextColumn get id => text()();
  TextColumn get componentId => text()();
  IntColumn get exponent => integer()();

  @override
  Set<Column> get primaryKey => {id, componentId};
}

class _Units extends Table {
  TextColumn get id => text()();
  TextColumn get dimensionsId => text()();
  RealColumn get multiplier => real()();

  @override
  Set<Column> get primaryKey => {dimensionsId, id};
}

class _Measurables extends Table {
  TextColumn get id => text()();
  TextColumn get dimensionsId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class _Edibles extends Table {
  TextColumn get id => text()();
  TextColumn get contains => text()();
  RealColumn get amount => real()();
  TextColumn get unitsId => text()();

  @override
  Set<Column> get primaryKey => {id, contains};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    print("opening moor db at $file");
    return VmDatabase(file);
//    return WebDatabase('db');
  });
}

@UseMoor(tables: [_Units, _Dimensions, _Measurables, _Edibles])
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
        measurables = MoorMeasurablesCollection(db),
        edibles = MoorEdiblesCollection(db: db);

  static MoorDatabase create() {
    return MoorDatabase(_MoorDatabase());
  }


  @override
  final AsyncDataCollection<Dimensions> dimensions;

  @override
  final AsyncDataCollection<Units> units;

  @override
  final AsyncDataCollection<Measurable> measurables;

  @override
  final AsyncDataCollection<Edible> edibles;

  @override
  Future<int> get version async => db.schemaVersion;
}

abstract class MoorDataCollection<T extends Table, D extends DataClass, D2 extends Indexable> implements AsyncDataCollection<D2> {
  final _MoorDatabase db;
  final TableInfo<T, D> tableInfo;
  final GeneratedTextColumn idCol;

  MoorDataCollection(this.db, this.tableInfo, this.idCol);

  Insertable<D> valueToRow(D2 val);
  D2 rowToValue(D row);

  SimpleSelectStatement<T, D> _rowFor(Symbol index) {
    return db
      .select(tableInfo)
      ..where((a) => idCol.equals(symbolToString(index)));
  }

  @override
  Future<Symbol> add(D2 value) async {
    final row = valueToRow(value);
//    final result = await db.into(tableInfo).insertOnConflictUpdate(row);
    final result = await db.into(tableInfo).insert(row);
    return value.id;
  }

  @override
  Future<int> count() async {
    final count = countAll();
    final query = db.selectOnly(tableInfo)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count);
  }

  @override
  Future<D2> fetch(Symbol index) async {
    final row = await _rowFor(index).getSingleOrNull();
    if (row == null)
      throw ArgumentError("no $D2 value for id ${symbolToString(index)}");

    // Convert the list of rows into a map from dimension id to exponent
    return rowToValue(row);
  }

  @override
  Future<D2> get(Symbol index, D2 otherwise) async {
    final row = await _rowFor(index).getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  Future<Map<Symbol, D2>> getAll() async {
    final query = db.select(tableInfo);
    final rows = await query.get();
    return Map.fromEntries(rows.map((row) {
      final value = rowToValue(row);
      return MapEntry(value.id, value);
    }));
  }

  @override
  Future<D2?> maybeGet(Symbol index, [D2? otherwise]) async {
    final row = await _rowFor(index).getSingleOrNull();
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  Future<int> remove(Symbol index) async {
    final results = db
        .delete(tableInfo)
      ..where((u) => idCol.equals(symbolToString(index)));
    return results.go();
  }

  @override
  Future<int> removeAll() {
    final results = db
        .delete(tableInfo);
    return results.go();
  }
}

class MoorDimensionsCollection implements AsyncDataCollection<Dimensions> {
  final _MoorDatabase db;
  final $_DimensionsTable table;
  final GeneratedTextColumn idCol;
  SimpleSelectStatement<Table, dynamic> get commonQuery => db.select(db.dimensions);

  MoorDimensionsCollection(this.db) :
        table = db.dimensions,
        idCol = db.dimensions.id;

  Iterable<Insertable<_Dimension>> valueToRows(Dimensions value) {
    List<Insertable<_Dimension>> rows = [];
    value.components.forEach((k, v) {
      rows.add(_Dimension(
        id: symbolToString(value.id),
        componentId: symbolToString(k),
        exponent: v,
      ));
    });
    return rows;
  }

  Map<Symbol, Dimensions> rowsToValues(Iterable<_Dimension> rows) {
    final Map<Symbol, Map<Symbol, int>> map = {};
    rows.forEach((row) {
      final dim = map[Symbol(row.id)] ??= <Symbol, int>{};
      dim[Symbol(row.componentId)] ??= row.exponent;
    });
    return map.map((k,v) => MapEntry(k, Dimensions(id: k, components: v)));
  }

  SimpleSelectStatement<$_DimensionsTable, _Dimension> _rowsFor(Symbol index) {
    return db
        .select(table, distinct: true)
      ..where((a) => idCol.equals(symbolToString(index)));
  }

  @override
  Future<Symbol> add(Dimensions value) {
    final newRows = valueToRows(value).toList(); // FIXME stream this?
    final delRows = db.delete(table)..where((t) => idCol.equals(symbolToString(value.id)));
    return db.transaction(() async {
      await delRows.go();
      await db.batch((batch) {
        batch.insertAll(
          table,
          newRows,
        );
      });
      return value.id;
    });
  }

  @override
  Future<int> count() async {
    final count = idCol.count(distinct: true);
    final query = db.selectOnly(table)
      ..addColumns([count]);

    final r = await query.getSingle();
    return r.read(count);
  }

  @override
  Future<Dimensions> fetch(Symbol index) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      throw ArgumentError("no value for id ${symbolToString(index)}");
    return rowsToValues(rows).values.first;
  }

  @override
  Future<Dimensions> get(Symbol index, Dimensions otherwise) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      return otherwise;
    return rowsToValues(rows).values.first;
  }

  @override
  Future<Map<Symbol, Dimensions>> getAll() async {
    final rows = await db
        .select(table, distinct: true).get();
    return rowsToValues(rows);
  }

  @override
  Future<Dimensions?> maybeGet(Symbol index, [Dimensions? otherwise]) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      return otherwise;

    // Convert the list of rows into a map from dimension id to exponent
    return rowsToValues(rows).values.first;
  }

  @override
  Future<int> remove(Symbol index) {
    final results = db
        .delete(table)
      ..where((a) => idCol.equals(symbolToString(index)));
    return results.go();
  }

  @override
  Future<int> removeAll() {
    final results = db
        .delete(table);
    return results.go();
  }
}


class MoorUnitsCollection extends MoorDataCollection<$_UnitsTable, _Unit, Units> {

  MoorUnitsCollection(_MoorDatabase db) : super(db, db.units, db.units.id);

  @override
  Units rowToValue(_Unit row) {
    return Units(Symbol(row.id), Symbol(row.dimensionsId), row.multiplier);
  }

  @override
  Insertable<_Unit> valueToRow(Units val)  {
    return _Unit(
      dimensionsId: symbolToString(val.dimensionsId),
      id: symbolToString(val.id),
      multiplier: val.multiplier.toDouble(),
    );
  }
}

class MoorMeasurablesCollection extends MoorDataCollection<$_MeasurablesTable, _Measurable, Measurable> {

  MoorMeasurablesCollection(_MoorDatabase db) : super(db, db.measurables, db.measurables.id);

  @override
  Measurable rowToValue(_Measurable row) {
    return Measurable(id: Symbol(row.id), dimensionsId: Symbol(row.dimensionsId));
  }

  @override
  Insertable<_Measurable> valueToRow(Measurable val)  {
    return _Measurable(
      id: symbolToString(val.id),
      dimensionsId: symbolToString(val.dimensionsId),
    );
  }
}

class MoorEdiblesCollection implements AsyncDataCollection<Edible> {
  final _MoorDatabase db;
  final $_EdiblesTable table;
  final GeneratedTextColumn idCol;
  JoinedSelectStatement<Table, dynamic> get commonQuery =>
    db.select(db.edibles)
      .join([
        leftOuterJoin(db.units, db.edibles.unitsId.equalsExp(db.units.id))
      ]);


  MoorEdiblesCollection({required this.db}) :
    table = db.edibles,
    idCol = db.edibles.id;

  Iterable<Insertable<_Edible>> valueToRows(Edible value) {
    List<Insertable<_Edible>> rows = [];
    value.contents.forEach((k, v) {
      rows.add(_Edible(
        id: symbolToString(value.id),
        contains: symbolToString(k),
        amount: v.amount.toDouble(),
        unitsId: symbolToString(v.units.id),
      ));
    });
    return rows;
  }

  Iterable<Insertable<_Unit>> valueToUnitRows(Edible value) {
    // Dedupe
    final units = value.contents.map((k, v) => MapEntry(
      v.units.id, v.units
    ));

    // Convert
    return units.values.map((v) =>
      _Unit(
        id: symbolToString(v.id),
        dimensionsId: symbolToString(v.dimensionsId),
        multiplier: v.multiplier.toDouble(),
      )
    );
  }

  Map<Symbol, Edible> rowsToValues(Iterable<TypedResult> rows) {
    final Map<Symbol, Map<Symbol, Quantity>> map = {};
    rows.forEach((row) {
      final edibleFields = row.readTable(db.edibles);
      final id = Symbol(edibleFields.id);
      final contains = Symbol(edibleFields.contains);
      final dim = map[id] ??= <Symbol, Quantity>{};
      if (dim.containsKey(contains))
        return; // already present... FIXME signal an error?
      final unitsFields = row.readTableOrNull(db.units);
      final units = unitsFields == null?
        Units.rogueValue :
        Units(Symbol(edibleFields.unitsId), Symbol(unitsFields.dimensionsId), unitsFields.multiplier);

      dim[contains] = Quantity(
          edibleFields.amount,
          units);
    });
    return map.map((k,v) => MapEntry(k, Edible(id: k, contents: v)));
  }

  JoinedSelectStatement<Table, dynamic> _rowsFor(Symbol index) { // same as dims
    return commonQuery
      ..where(idCol.equals(symbolToString(index)));
  }

  @override
  Future<Symbol> add(Edible value) async {
    final unitsRows = valueToUnitRows(value);
    final edibleRows = valueToRows(value); // FIXME stream this?
    final delEdibles = db.delete(table)..where((t) => idCol.equals(symbolToString(value.id)));
    return db.transaction(() async {
      await delEdibles.go();
      await db.batch((batch) {
        batch.insertAll(
            table,
            edibleRows.toList(),
        );
        batch.insertAll(
            db.units,
            unitsRows.toList(),
            mode: InsertMode.insertOrReplace
        );
      });
      return value.id;
    });
  }

  @override
  Future<int> count() async { // same as dims
    final count = idCol.count(distinct: true);
    final query = db.selectOnly(table)
      ..addColumns([count]);

    final r = await query.getSingle();
    return r.read(count);
  }

  @override
  Future<Edible> fetch(Symbol index) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      throw ArgumentError("no value for id ${symbolToString(index)}");
    return rowsToValues(rows).values.first;
  }

  @override
  Future<Edible> get(Symbol index, Edible otherwise) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      return otherwise;
    return rowsToValues(rows).values.first;
  }

  @override
  Future<Map<Symbol, Edible>> getAll() async {
    final rows =  await commonQuery.get();
    return rowsToValues(rows);
  }

  @override
  Future<Edible?> maybeGet(Symbol index, [Edible? otherwise]) async {
    final rows = await _rowsFor(index).get();
    if (rows.isEmpty)
      return otherwise;
    return rowsToValues(rows).values.first;
  }

  @override
  Future<int> remove(Symbol index) {
    final query = db.delete(table)..where((a) => idCol.equals(symbolToString(index)));
    return query.go();
  }

  @override
  Future<int> removeAll() async {
    return db.delete(table).go();
  }
}
