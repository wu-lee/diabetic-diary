import 'package:diabetic_diary/basic_ingredient.dart';
import 'package:diabetic_diary/database.dart';
import 'package:diabetic_diary/measureable.dart';
import 'package:diabetic_diary/translation.dart';
import 'package:diabetic_diary/units.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
// don't import moor_web.dart or moor_flutter/moor_flutter.dart in shared code
import 'package:moor/moor.dart';
//import 'package:moor/moor_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '../composite_edible.dart';
import '../dimensions.dart';
import '../dish.dart';
import '../edible.dart';
import '../indexable.dart';
import '../meal.dart';
import '../quantity.dart';

// Include the autogenerated code
part 'moor_database.g.dart';

//  Generate the code needed with:
//      flutter packages pub run build_runner build
//
//  To continuously rebuild the generated code when changed:
//      flutter packages pub run build_runner watch

class _Labels extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get label => text().customConstraint('NOT NULL')();
}

class _Dimensions extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get componentId => text().customConstraint('NOT NULL')();
  IntColumn get exponent => integer().customConstraint('NOT NULL')();

  @override
  Set<Column> get primaryKey => {id, componentId};
}

class _Units extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get dimensionsId => text().customConstraint('NOT NULL REFERENCES dimensions(id)')();
  RealColumn get multiplier => real().customConstraint('NOT NULL')();

  @override
  Set<Column> get primaryKey => {dimensionsId, id};
}

class _Measurables extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get unitsId => text().customConstraint('NOT NULL REFERENCES units(id)')();

  @override
  Set<Column> get primaryKey => {id};
}

class _Edibles extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')(); // a BasicIngredient or an Dish
  TextColumn get label => text().customConstraint('NOT NULL')(); // These labels are user-entered, so not localised
  BoolColumn get isBasic => boolean().customConstraint('NOT NULL')(); // True if a BasicIngredient
  RealColumn get portions => real().customConstraint('NOT NULL')(); // Number of portions from the given contents
  @override
  Set<Column> get primaryKey => {id};
}

class _BasicIngredientContents extends Table {
  TextColumn get id => text().customConstraint('NOT NULL REFERENCES edibles(id)')();
  TextColumn get contains => text().customConstraint('NOT NULL REFERENCES measurables(id)')();
  RealColumn get amount => real().customConstraint('NOT NULL')();
  TextColumn get unitsId => text().customConstraint('NOT NULL REFERENCES units(id)')();

  @override
  Set<Column> get primaryKey => {id, contains};
}

class _DishContents extends Table {
  TextColumn get id => text().customConstraint('NOT NULL REFERENCES edibles(id)')();
  TextColumn get contains => text().customConstraint('NOT NULL REFERENCES edibles(id)')();
  RealColumn get amount => real().customConstraint('NOT NULL')();
  TextColumn get unitsId => text().customConstraint('NOT NULL REFERENCES units(id)')();

  @override
  Set<Column> get primaryKey => {id, contains};
}

class _Meals extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get label => text().customConstraint('NOT NULL')();
  TextColumn get notes => text().customConstraint('NOT NULL')();
  DateTimeColumn get timestamp => dateTime().customConstraint('NOT NULL')();

  @override
  Set<Column> get primaryKey => {id};
}

class _MealContents extends Table {
  TextColumn get id => text().customConstraint('NOT NULL REFERENCES meals(id)')();
  TextColumn get contains => text().customConstraint('NOT NULL REFERENCES edibles(id)')();
  RealColumn get amount => real().customConstraint('NOT NULL')();
  TextColumn get unitsId => text().customConstraint('NOT NULL REFERENCES units(id)')();

  @override
  Set<Column> get primaryKey => {id, contains};
}

class _Config extends Table {
  TextColumn get id => text().customConstraint('NOT NULL')();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {id};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    debugPrint("opening moor db at $file");
    return VmDatabase(file);
//    return WebDatabase('db');
  });
}

@UseMoor(tables: [_Config, _Units, _Dimensions, _Measurables, _BasicIngredientContents, _Edibles, _DishContents,
                  _Meals, _MealContents, _Labels])
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
        edibles = MoorEdiblesCollection(db: db),
        ingredients = MoorBasicIngredientsCollection(db: db),
        dishes = MoorDishesCollection(db: db),
        meals = MoorMealsCollection(db: db);

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
  final AsyncDataCollection<BasicIngredient> ingredients;

  @override
  final AsyncDataCollection<Dish> dishes;

  @override
  final AsyncDataCollection<Meal> meals;

  @override
  Future<int> get version async => db.schemaVersion;

  @override
  Future<int> get deployedVersion async {
    try {
      final versionQuery = db.select(db.config)
        ..where((t) => t.id.equals('version'));
      final result = await versionQuery.getSingleOrNull();
      if (result == null)
        return 0;
      final version = int.tryParse(result.value);
      return version == null ? 0 : version;
    }
    catch(e) {
      return 0;
    }
  }

  @override
  Future<void> setDeployedVersion(int version) async {
    final versionRecord = _ConfigData(id: 'version', value: version.toString());
    await db.into(db.config).insertOnConflictUpdate(versionRecord);
    return;
  }

  @override
  Future<void> clear() async {
    final foo = await db.customSelect("SELECT * FROM sqlite_master WHERE type='table'").get();
    for(final row in foo) {
      final name = row.data['name'].toString();
      debugPrint("Deleting table $name");
      await db.customStatement("DROP TABLE IF EXISTS '"+name.replaceAll("'", "''")+"'");
    }
    // Create tables
    final m = db.createMigrator();
    for (final table in db.allTables.toList()) {
      debugPrint("Creating table ${table.actualTableName}");
      await m.createTable(table);
    }
    return;
  }
}

abstract class MoorAbstractDataCollection<T extends Table, D extends DataClass, X extends Indexable> implements AsyncDataCollection<X> {
  final _MoorDatabase db;
  final TableInfo<T, D> tableInfo;
  final GeneratedTextColumn idCol;

  MoorAbstractDataCollection(this.db, this.tableInfo, this.idCol);

  JoinedSelectStatement<Table, dynamic> get _query =>
  // We use .addColumns to ensure we get a JoinedSelectStatement
  // instead of a SimpleSelectStatement. This allows us to be more
  // flexible by overriding this method to join in extra columns when needed.
  // Note, we don't support *writing* extra columns, only reading them.
    db.select(tableInfo).addColumns(tableInfo.$columns);

  Future<TypedResult?> _rowFor(Symbol index) => (
      _query
      ..where(idCol.equals(symbolToString(index)))
  ).getSingleOrNull();

  Insertable<D> valueToRow(X val);

  X rowToValue(TypedResult row);

  @override
  Future<bool> containsId(Symbol index) async {
    final count = db
        .selectOnly(tableInfo)
      ..addColumns([idCol])
      ..where(idCol.equals(symbolToString(index)))
      ..limit(1);
    return null != await count.getSingleOrNull();
  }

  @override
  Future<Symbol> add(X value) async {
    final row = valueToRow(value);
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
  Future<X> fetch(Symbol index) async {
    final row = await _rowFor(index);
    if (row == null)
      throw ArgumentError("no $X value for id ${symbolToString(index)}");

    // Convert the list of rows into a map from dimension id to exponent
    return rowToValue(row);
  }

  @override
  Future<X> get(Symbol index, X otherwise) async {
    final row = await _rowFor(index);
    if (row == null)
      return otherwise;
    return rowToValue(row);
  }

  @override
  Future<Map<Symbol, X>> getAll() async {
    final rows = await _query.get();
    return Map.fromEntries(rows.map((row) {
      final value = rowToValue(row);
      return MapEntry(value.id, value);
    }));
  }

  @override
  Future<X?> maybeGet(Symbol index, [X? otherwise]) async {
    final row = await _rowFor(index);
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
  Future<bool> containsId(Symbol index) async {
    final count = db
        .selectOnly(table)
        ..addColumns([idCol])
        ..where(idCol.equals(symbolToString(index)))
        ..limit(1);
    return null != await count.getSingleOrNull();
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


class MoorUnitsCollection extends MoorAbstractDataCollection<$_UnitsTable, _Unit, Units> {

  MoorUnitsCollection(_MoorDatabase db) : super(db, db.units, db.units.id);

  @override
  Units rowToValue(TypedResult result) {
    final row = result.readTable(tableInfo);
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

class MoorMeasurablesCollection extends MoorAbstractDataCollection<$_MeasurablesTable, _Measurable, Measurable> {

  MoorMeasurablesCollection(_MoorDatabase db) : super(db, db.measurables, db.measurables.id);

  @override
  JoinedSelectStatement<Table, dynamic> get _query =>
      db.select(tableInfo)
      .join([
        leftOuterJoin(db.units, db.measurables.unitsId.equalsExp(db.units.id))
      ]);

  @override
  Future<TypedResult?> _rowFor(Symbol index) => (
      _query..where(idCol.equals(symbolToString(index)))
  ).getSingleOrNull();

  @override
  Measurable rowToValue(TypedResult result) {
    final row = result.readTable(tableInfo);
    final dimensionsId = result.read(db.units.dimensionsId)!;
    final multiplier = result.read(db.units.multiplier)!;
    return Measurable(
        id: Symbol(row.id),
        defaultUnits: Units(
            Symbol(row.unitsId),
            Symbol(dimensionsId),
            multiplier
        )
    );
  }

  @override
  Insertable<_Measurable> valueToRow(Measurable val)  {
    return _Measurable(
      id: symbolToString(val.id),
      unitsId: symbolToString(val.defaultUnits.id),
    );
  }
}

/// Represents a class stored in a table joined 1:N with another, which is joined 1:1 with a third.
///
/// So for example, a Widget which contains a map of [Indexable] components, each of which has a type of Foo
///
/// The third table is assumed pre-exisiting, and not created and deleted like the other two.
abstract class MoorAbstract1ToNTo1Collection<Tx extends Table, Dx extends DataClass, Ty extends Table, Dy extends DataClass, Tz extends Table, Dz extends DataClass, X extends Indexable> implements AsyncDataCollection<X> {
  final _MoorDatabase db;
  final TableInfo<Tx, Dx> table;
  final TableInfo<Ty, Dy> joinedTable;
  final TableInfo<Tz, Dz> farJoinedTable;
  final GeneratedTextColumn idCol;
  final GeneratedTextColumn joinedIdCol;
  final GeneratedTextColumn joinedIdCol2;
  final GeneratedTextColumn farJoinedIdCol;

  MoorAbstract1ToNTo1Collection({
    required this.db,
    required this.table, required this.joinedTable, required this.farJoinedTable,
    required this.idCol,
    required this.joinedIdCol, required this.joinedIdCol2,
    required this.farJoinedIdCol,
  });

  Iterable<Insertable<Dx>> contentToPrimaryRows(X value);

  Iterable<Insertable<Dy>> contentToJoinedRows(X value);

  Iterable<Insertable<Dz>> contentToFarJoinedRows(X value);

  Map<Symbol, X> rowsToValues(List<Dx> rowsX, Iterable<TypedResult> joinedRows);

  SimpleSelectStatement<Tx, Dx> get primaryQuery =>
      db.select(table);

  JoinedSelectStatement<Table, dynamic> get joinedQuery =>
      db.select(joinedTable)
          .join([
        leftOuterJoin(farJoinedTable, joinedIdCol2.equalsExp(farJoinedIdCol))
      ]);

  SimpleSelectStatement<Tx, Dx> _primaryRowsFor(Symbol index) {
    return primaryQuery
      ..where((a) => idCol.equals(symbolToString(index)));
  }

  JoinedSelectStatement<Table, dynamic> _joinedRowsFor(Symbol index) {
    return joinedQuery
      ..where(joinedIdCol.equals(symbolToString(index)));
  }

  @override
  Future<bool> containsId(Symbol index) async {
    final count = db
        .selectOnly(table)
      ..addColumns([idCol])
      ..where(idCol.equals(symbolToString(index)))
      ..limit(1);
    return null != await count.getSingleOrNull();
  }

  @override
  Future<Symbol> add(X value) async {
    final farJoinedRows = contentToFarJoinedRows(value);
    final primaryQuery = contentToPrimaryRows(value); // FIXME stream this?
    final joinedQuery = contentToJoinedRows(value); // FIXME stream this?
    final primaryDelete = db.delete(table)..where((t) => idCol.equals(symbolToString(value.id)));
    final joinedDelete = db.delete(joinedTable)..where((t) => joinedIdCol.equals(symbolToString(value.id)));
    return db.transaction(() async {
      await joinedDelete.go();
      await primaryDelete.go();
      await db.batch((batch) {
        batch.insertAll(
            table,
            primaryQuery.toList(),
        );
        batch.insertAll(
          joinedTable,
          joinedQuery.toList(),
        );
        batch.insertAll(
            farJoinedTable,
            farJoinedRows.toList(),
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
  Future<X> fetch(Symbol index) async {
    final primaryRows = await _primaryRowsFor(index).get();
    if (primaryRows.isEmpty)
      throw ArgumentError("no value for id ${symbolToString(index)}");
    final joinedRows = await _joinedRowsFor(index).get();
    return rowsToValues(primaryRows, joinedRows).values.first;
  }

  @override
  Future<X> get(Symbol index, X otherwise) async {
    final primaryRows = await _primaryRowsFor(index).get();
    if (primaryRows.isEmpty)
      return otherwise;
    final joinedRows = await _joinedRowsFor(index).get();
    return rowsToValues(primaryRows, joinedRows).values.first;
  }

  @override
  Future<Map<Symbol, X>> getAll() async {
    final primaryRows =  await primaryQuery.get();
    final joinedRows = await joinedQuery.get();
    return rowsToValues(primaryRows, joinedRows);
  }

  @override
  Future<X?> maybeGet(Symbol index, [X? otherwise]) async {
    final primaryRows = await _primaryRowsFor(index).get();
    if (primaryRows.isEmpty)
      return otherwise;
    final joinedRows = await _joinedRowsFor(index).get();
    return rowsToValues(primaryRows, joinedRows).values.first;
  }

  @override
  Future<int> remove(Symbol index) async {
    final primaryQuery = db.delete(table)..where((a) => idCol.equals(symbolToString(index)));
    final joinedQuery = db.delete(joinedTable)..where((a) => idCol.equals(symbolToString(index)));
    int deleted = await primaryQuery.go();
    deleted += await joinedQuery.go();
    return deleted;
  }

  @override
  Future<int> removeAll() async {
    int deleted = await db.delete(table).go() + await db.delete(joinedTable).go();
    return deleted;
  }
}

class MoorEdiblesCollection extends MoorAbstract1ToNTo1Collection<$_EdiblesTable, _Edible, $_DishContentsTable, _DishContent, $_UnitsTable, _Unit, Edible> {

  MoorEdiblesCollection({required _MoorDatabase db}) :
        super(
        db: db,
        table: db.edibles,
        joinedTable: db.dishContents,
        farJoinedTable: db.units,
        idCol: db.edibles.id,
        joinedIdCol: db.dishContents.id,
        joinedIdCol2: db.dishContents.unitsId,
        farJoinedIdCol: db.units.id,
      );

  Iterable<Insertable<_Edible>> contentToPrimaryRows(Edible value) {
    List<Insertable<_Edible>> rows = [];
    final isComposite = value is CompositeEdible;
    final num portions = isComposite?
      (value as CompositeEdible).portions : // #portions
      value.portionSize; // portions size in g
    rows.add(_Edible(
      id: symbolToString(value.id),
      label: value.label,
      portions: portions.toDouble(),
      isBasic: !isComposite,
    ));
    return rows;
  }

  Iterable<Insertable<_DishContent>> contentToJoinedRows(Edible value) {
    List<Insertable<_DishContent>> rows = [];
    value.contents.forEach((k, v) {
      rows.add(_DishContent(
        id: symbolToString(value.id),
        contains: symbolToString(k),
        amount: v.amount.toDouble(),
        unitsId: symbolToString(v.units.id),
      ));
    });
    return rows;
  }
  Iterable<Insertable<_Unit>> contentToFarJoinedRows(Edible value) {
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

  Map<Symbol, Edible> rowsToValues(List<_Edible> edibleRows, Iterable<TypedResult> contentRows) {
    final Map<Symbol, _Edible> edibles = Map.fromIterable(
      edibleRows,
      key: (it) => Symbol(it.id),
    );
    final Map<Symbol, Map<Symbol, Quantity>> allContents = {};
    contentRows.forEach((row) {
      final contentFields = row.readTable(db.dishContents);
      final id = Symbol(contentFields.id);
      final contains = Symbol(contentFields.contains);
      final edible = edibles[id];
      if (edible == null)
        return; // not present... FIXME signal an error?
      final unitsFields = row.readTableOrNull(db.units);
      final units = unitsFields == null?
      Units.rogueValue :
      Units(Symbol(contentFields.unitsId), Symbol(unitsFields.dimensionsId), unitsFields.multiplier);

      final contents = allContents.putIfAbsent(id, () => {});
      contents[contains] = Quantity(
          contentFields.amount,
          units
      );
    });
    return edibles.map((id, edible) => MapEntry(
        id,
        edibles[id]?.isBasic == true?
          BasicIngredient(id: id, label: edibles[id]?.label ?? '',
              portionSize: edibles[id]?.portions as num,
              contents: allContents[id] ?? {}) :
          Dish(id: id, label: edibles[id]?.label ?? '',
              portions: edibles[id]?.portions as num,
              contents: allContents[id] ?? {})
    ));
  }


}


class MoorDishesCollection extends MoorAbstract1ToNTo1Collection<$_EdiblesTable, _Edible, $_DishContentsTable, _DishContent, $_UnitsTable, _Unit, Dish> {

  MoorDishesCollection({required _MoorDatabase db}) :
        super(
          db: db,
          table: db.edibles,
          joinedTable: db.dishContents,
          farJoinedTable: db.units,
          idCol: db.edibles.id,
          joinedIdCol: db.dishContents.id,
          joinedIdCol2: db.dishContents.unitsId,
          farJoinedIdCol: db.units.id,
      );

  SimpleSelectStatement<$_EdiblesTable, _Edible> get primaryQuery =>
      db.select(table)..where((tbl) => db.edibles.isBasic.equals(false));

  Iterable<Insertable<_Edible>> contentToPrimaryRows(Dish value) {
    List<Insertable<_Edible>> rows = [];
    rows.add(_Edible(
      id: symbolToString(value.id),
      label: value.label,
      portions: value.portions.toDouble(),
      isBasic: false,
    ));
    return rows;
  }

  Iterable<Insertable<_DishContent>> contentToJoinedRows(Dish value) {
    List<Insertable<_DishContent>> rows = [];
    value.contents.forEach((k, v) {
      rows.add(_DishContent(
        id: symbolToString(value.id),
        contains: symbolToString(k),
        amount: v.amount.toDouble(),
        unitsId: symbolToString(v.units.id),
      ));
    });
    return rows;
  }
  Iterable<Insertable<_Unit>> contentToFarJoinedRows(Dish value) {
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

  Map<Symbol, Dish> rowsToValues(List<_Edible> dishRows, Iterable<TypedResult> contentRows) {
    final Map<Symbol, _Edible> dishes = Map.fromIterable(
      dishRows, key: (it) => Symbol(it.id),
    );
    final Map<Symbol, Map<Symbol, Quantity>> allContents = {};

    contentRows.forEach((row) {
      final contentFields = row.readTable(db.dishContents);
      final id = Symbol(contentFields.id);
      final contains = Symbol(contentFields.contains);
      final dish = dishes[id];
      if (dish == null)
        return; // not present... FIXME signal an error?
      final unitsFields = row.readTableOrNull(db.units);
      final units = unitsFields == null?
      Units.rogueValue :
      Units(Symbol(contentFields.unitsId), Symbol(unitsFields.dimensionsId), unitsFields.multiplier);

      final contents = allContents.putIfAbsent(id, () => {});
      contents[contains] = Quantity(
          contentFields.amount,
          units
      );
    });
    return dishes.map((id, dish) {
      final content = allContents[id] ?? {};
      return MapEntry(
          id,
          Dish(id: id,
              label: dish.label,
              portions: dish.portions,
              contents: content)
      );
    });
  }


}

class MoorBasicIngredientsCollection extends MoorAbstract1ToNTo1Collection<$_EdiblesTable, _Edible, $_BasicIngredientContentsTable, _BasicIngredientContent, $_UnitsTable, _Unit, BasicIngredient> {

  MoorBasicIngredientsCollection({required _MoorDatabase db}) :
        super(
          db: db,
          table: db.edibles,
          joinedTable: db.basicIngredientContents,
          farJoinedTable: db.units,
          idCol: db.edibles.id,
          joinedIdCol: db.basicIngredientContents.id,
          joinedIdCol2: db.basicIngredientContents.unitsId,
          farJoinedIdCol: db.units.id,
      );

  SimpleSelectStatement<$_EdiblesTable, _Edible> get primaryQuery =>
      db.select(table)..where((tbl) => db.edibles.isBasic.equals(true));

  Iterable<Insertable<_Edible>> contentToPrimaryRows(BasicIngredient value) {
    List<Insertable<_Edible>> rows = [];
    rows.add(_Edible(
      id: symbolToString(value.id),
      label: value.label,
      portions: value.portionSize.toDouble(),
      isBasic: true,
    ));
    return rows;
  }

  Iterable<Insertable<_BasicIngredientContent>> contentToJoinedRows(BasicIngredient value) {
    List<Insertable<_BasicIngredientContent>> rows = [];
    value.contents.forEach((k, v) {
      rows.add(_BasicIngredientContent(
        id: symbolToString(value.id),
        contains: symbolToString(k),
        amount: v.amount.toDouble(),
        unitsId: symbolToString(v.units.id),
      ));
    });
    return rows;
  }
  Iterable<Insertable<_Unit>> contentToFarJoinedRows(BasicIngredient value) {
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

  Map<Symbol, BasicIngredient> rowsToValues(List<_Edible> dishRows, Iterable<TypedResult> contentRows) {
    final Map<Symbol, _Edible> edibles = Map.fromIterable(
      dishRows,
      key: (k) => Symbol(k.id),
    );
    final Map<Symbol, Map<Symbol, Quantity>> allContents = {};
    contentRows.forEach((row) {
      final contentFields = row.readTable(db.basicIngredientContents);
      final id = Symbol(contentFields.id);
      final contains = Symbol(contentFields.contains);
      final edible = edibles[id];
      if (edible == null)
        return; // not present... FIXME signal an error?
      final unitsFields = row.readTableOrNull(db.units);
      final units = unitsFields == null?
      Units.rogueValue :
      Units(Symbol(contentFields.unitsId), Symbol(unitsFields.dimensionsId), unitsFields.multiplier);

      final contents = allContents.putIfAbsent(id, () => {});
      contents[contains] = Quantity(
          contentFields.amount,
          units,
      );
    });
    return edibles.map((id, edible) => MapEntry(
        id,
        BasicIngredient(
            id: id, label: edible.label,
            portionSize: edible.portions,
            contents: allContents[id] ?? {},
        )
    ));
  }
}

class MoorMealsCollection extends MoorAbstract1ToNTo1Collection<$_MealsTable, _Meal, $_MealContentsTable, _MealContent, $_UnitsTable, _Unit, Meal> {

  MoorMealsCollection({required _MoorDatabase db}) :
        super(
          db: db,
          table: db.meals,
          joinedTable: db.mealContents,
          farJoinedTable: db.units,
          idCol: db.meals.id,
          joinedIdCol: db.mealContents.id,
          joinedIdCol2: db.mealContents.unitsId,
          farJoinedIdCol: db.units.id,
      );

  Iterable<Insertable<_Meal>> contentToPrimaryRows(Meal value) {
    List<Insertable<_Meal>> rows = [];
    rows.add(_Meal(
      id: symbolToString(value.id),
      timestamp: value.timestamp,
      label: value.label,
      notes: value.notes,
    ));
    return rows;
  }

  Iterable<Insertable<_MealContent>> contentToJoinedRows(Meal value) {
    List<Insertable<_MealContent>> rows = [];
    value.contents.forEach((k, v) {
      rows.add(_MealContent(
        id: symbolToString(value.id),
        contains: symbolToString(k),
        amount: v.amount.toDouble(),
        unitsId: symbolToString(v.units.id),
      ));
    });
    return rows;
  }
  Iterable<Insertable<_Unit>> contentToFarJoinedRows(Meal value) {
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

  Map<Symbol, Meal> rowsToValues(List<_Meal> edibleRows, Iterable<TypedResult> contentRows) {
    final Map<Symbol, _Meal> meals = Map.fromIterable(
      edibleRows, key: (it) => Symbol(it.id),
    );
    final Map<Symbol, Map<Symbol, Quantity>> allContents = {};
    contentRows.forEach((row) {
      final contentFields = row.readTable(db.mealContents);
      final id = Symbol(contentFields.id);
      final contains = Symbol(contentFields.contains);
      final meal = meals[id];
      if (meal == null)
        return; // not present... FIXME signal an error?
      final unitsFields = row.readTableOrNull(db.units);
      final units = unitsFields == null?
      Units.rogueValue :
      Units(Symbol(contentFields.unitsId), Symbol(unitsFields.dimensionsId), unitsFields.multiplier);

      final contents = allContents.putIfAbsent(id, () => {});
      contents[contains] = Quantity(
          contentFields.amount,
          units
      );
    });
    return meals.map((id, meal) => MapEntry(
        id,
        Meal(
            id: id,
            label: meal.label,
            notes: meal.notes,
            timestamp: meal.timestamp,
            contents: allContents[id] ?? {},
        )
    ));
  }
}