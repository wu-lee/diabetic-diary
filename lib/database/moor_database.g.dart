// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class _DimensionUnit extends DataClass implements Insertable<_DimensionUnit> {
  final String dimensionId;
  final String unitId;
  final double multiplier;
  _DimensionUnit(
      {required this.dimensionId,
      required this.unitId,
      required this.multiplier});
  factory _DimensionUnit.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _DimensionUnit(
      dimensionId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimension_id'])!,
      unitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit_id'])!,
      multiplier: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}multiplier'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dimension_id'] = Variable<String>(dimensionId);
    map['unit_id'] = Variable<String>(unitId);
    map['multiplier'] = Variable<double>(multiplier);
    return map;
  }

  _DimensionUnitsCompanion toCompanion(bool nullToAbsent) {
    return _DimensionUnitsCompanion(
      dimensionId: Value(dimensionId),
      unitId: Value(unitId),
      multiplier: Value(multiplier),
    );
  }

  factory _DimensionUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _DimensionUnit(
      dimensionId: serializer.fromJson<String>(json['dimensionId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      multiplier: serializer.fromJson<double>(json['multiplier']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dimensionId': serializer.toJson<String>(dimensionId),
      'unitId': serializer.toJson<String>(unitId),
      'multiplier': serializer.toJson<double>(multiplier),
    };
  }

  _DimensionUnit copyWith(
          {String? dimensionId, String? unitId, double? multiplier}) =>
      _DimensionUnit(
        dimensionId: dimensionId ?? this.dimensionId,
        unitId: unitId ?? this.unitId,
        multiplier: multiplier ?? this.multiplier,
      );
  @override
  String toString() {
    return (StringBuffer('_DimensionUnit(')
          ..write('dimensionId: $dimensionId, ')
          ..write('unitId: $unitId, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(dimensionId.hashCode, $mrjc(unitId.hashCode, multiplier.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _DimensionUnit &&
          other.dimensionId == this.dimensionId &&
          other.unitId == this.unitId &&
          other.multiplier == this.multiplier);
}

class _DimensionUnitsCompanion extends UpdateCompanion<_DimensionUnit> {
  final Value<String> dimensionId;
  final Value<String> unitId;
  final Value<double> multiplier;
  const _DimensionUnitsCompanion({
    this.dimensionId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.multiplier = const Value.absent(),
  });
  _DimensionUnitsCompanion.insert({
    required String dimensionId,
    required String unitId,
    required double multiplier,
  })  : dimensionId = Value(dimensionId),
        unitId = Value(unitId),
        multiplier = Value(multiplier);
  static Insertable<_DimensionUnit> custom({
    Expression<String>? dimensionId,
    Expression<String>? unitId,
    Expression<double>? multiplier,
  }) {
    return RawValuesInsertable({
      if (dimensionId != null) 'dimension_id': dimensionId,
      if (unitId != null) 'unit_id': unitId,
      if (multiplier != null) 'multiplier': multiplier,
    });
  }

  _DimensionUnitsCompanion copyWith(
      {Value<String>? dimensionId,
      Value<String>? unitId,
      Value<double>? multiplier}) {
    return _DimensionUnitsCompanion(
      dimensionId: dimensionId ?? this.dimensionId,
      unitId: unitId ?? this.unitId,
      multiplier: multiplier ?? this.multiplier,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dimensionId.present) {
      map['dimension_id'] = Variable<String>(dimensionId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (multiplier.present) {
      map['multiplier'] = Variable<double>(multiplier.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_DimensionUnitsCompanion(')
          ..write('dimensionId: $dimensionId, ')
          ..write('unitId: $unitId, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }
}

class $_DimensionUnitsTable extends _DimensionUnits
    with TableInfo<$_DimensionUnitsTable, _DimensionUnit> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_DimensionUnitsTable(this._db, [this._alias]);
  final VerificationMeta _dimensionIdMeta =
      const VerificationMeta('dimensionId');
  @override
  late final GeneratedTextColumn dimensionsId = _constructDimensionId();
  GeneratedTextColumn _constructDimensionId() {
    return GeneratedTextColumn(
      'dimension_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedTextColumn unitId = _constructUnitId();
  GeneratedTextColumn _constructUnitId() {
    return GeneratedTextColumn(
      'unit_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _multiplierMeta = const VerificationMeta('multiplier');
  @override
  late final GeneratedRealColumn multiplier = _constructMultiplier();
  GeneratedRealColumn _constructMultiplier() {
    return GeneratedRealColumn(
      'multiplier',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [dimensionsId, unitId, multiplier];
  @override
  $_DimensionUnitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'dimension_units';
  @override
  final String actualTableName = 'dimension_units';
  @override
  VerificationContext validateIntegrity(Insertable<_DimensionUnit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dimension_id')) {
      context.handle(
          _dimensionIdMeta,
          dimensionsId.isAcceptableOrUnknown(
              data['dimension_id']!, _dimensionIdMeta));
    } else if (isInserting) {
      context.missing(_dimensionIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('multiplier')) {
      context.handle(
          _multiplierMeta,
          multiplier.isAcceptableOrUnknown(
              data['multiplier']!, _multiplierMeta));
    } else if (isInserting) {
      context.missing(_multiplierMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dimensionsId, unitId};
  @override
  _DimensionUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _DimensionUnit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_DimensionUnitsTable createAlias(String alias) {
    return $_DimensionUnitsTable(_db, alias);
  }
}

class _DimensionComponent extends DataClass
    implements Insertable<_DimensionComponent> {
  final String dimensionId;
  final String componentId;
  final int exponent;
  _DimensionComponent(
      {required this.dimensionId,
      required this.componentId,
      required this.exponent});
  factory _DimensionComponent.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _DimensionComponent(
      dimensionId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimension_id'])!,
      componentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}component_id'])!,
      exponent: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exponent'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dimension_id'] = Variable<String>(dimensionId);
    map['component_id'] = Variable<String>(componentId);
    map['exponent'] = Variable<int>(exponent);
    return map;
  }

  _DimensionComponentsCompanion toCompanion(bool nullToAbsent) {
    return _DimensionComponentsCompanion(
      dimensionId: Value(dimensionId),
      componentId: Value(componentId),
      exponent: Value(exponent),
    );
  }

  factory _DimensionComponent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _DimensionComponent(
      dimensionId: serializer.fromJson<String>(json['dimensionId']),
      componentId: serializer.fromJson<String>(json['componentId']),
      exponent: serializer.fromJson<int>(json['exponent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dimensionId': serializer.toJson<String>(dimensionId),
      'componentId': serializer.toJson<String>(componentId),
      'exponent': serializer.toJson<int>(exponent),
    };
  }

  _DimensionComponent copyWith(
          {String? dimensionId, String? componentId, int? exponent}) =>
      _DimensionComponent(
        dimensionId: dimensionId ?? this.dimensionId,
        componentId: componentId ?? this.componentId,
        exponent: exponent ?? this.exponent,
      );
  @override
  String toString() {
    return (StringBuffer('_DimensionComponent(')
          ..write('dimensionId: $dimensionId, ')
          ..write('componentId: $componentId, ')
          ..write('exponent: $exponent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      dimensionId.hashCode, $mrjc(componentId.hashCode, exponent.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _DimensionComponent &&
          other.dimensionId == this.dimensionId &&
          other.componentId == this.componentId &&
          other.exponent == this.exponent);
}

class _DimensionComponentsCompanion
    extends UpdateCompanion<_DimensionComponent> {
  final Value<String> dimensionId;
  final Value<String> componentId;
  final Value<int> exponent;
  const _DimensionComponentsCompanion({
    this.dimensionId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.exponent = const Value.absent(),
  });
  _DimensionComponentsCompanion.insert({
    required String dimensionId,
    required String componentId,
    required int exponent,
  })  : dimensionId = Value(dimensionId),
        componentId = Value(componentId),
        exponent = Value(exponent);
  static Insertable<_DimensionComponent> custom({
    Expression<String>? dimensionId,
    Expression<String>? componentId,
    Expression<int>? exponent,
  }) {
    return RawValuesInsertable({
      if (dimensionId != null) 'dimension_id': dimensionId,
      if (componentId != null) 'component_id': componentId,
      if (exponent != null) 'exponent': exponent,
    });
  }

  _DimensionComponentsCompanion copyWith(
      {Value<String>? dimensionId,
      Value<String>? componentId,
      Value<int>? exponent}) {
    return _DimensionComponentsCompanion(
      dimensionId: dimensionId ?? this.dimensionId,
      componentId: componentId ?? this.componentId,
      exponent: exponent ?? this.exponent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dimensionId.present) {
      map['dimension_id'] = Variable<String>(dimensionId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (exponent.present) {
      map['exponent'] = Variable<int>(exponent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_DimensionComponentsCompanion(')
          ..write('dimensionId: $dimensionId, ')
          ..write('componentId: $componentId, ')
          ..write('exponent: $exponent')
          ..write(')'))
        .toString();
  }
}

class $_DimensionComponentsTable extends _DimensionComponents
    with TableInfo<$_DimensionComponentsTable, _DimensionComponent> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_DimensionComponentsTable(this._db, [this._alias]);
  final VerificationMeta _dimensionIdMeta =
      const VerificationMeta('dimensionId');
  @override
  late final GeneratedTextColumn dimensionsId = _constructDimensionId();
  GeneratedTextColumn _constructDimensionId() {
    return GeneratedTextColumn(
      'dimension_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _componentIdMeta =
      const VerificationMeta('componentId');
  @override
  late final GeneratedTextColumn componentId = _constructComponentId();
  GeneratedTextColumn _constructComponentId() {
    return GeneratedTextColumn(
      'component_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _exponentMeta = const VerificationMeta('exponent');
  @override
  late final GeneratedIntColumn exponent = _constructExponent();
  GeneratedIntColumn _constructExponent() {
    return GeneratedIntColumn(
      'exponent',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [dimensionsId, componentId, exponent];
  @override
  $_DimensionComponentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'dimension_components';
  @override
  final String actualTableName = 'dimension_components';
  @override
  VerificationContext validateIntegrity(
      Insertable<_DimensionComponent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('dimension_id')) {
      context.handle(
          _dimensionIdMeta,
          dimensionsId.isAcceptableOrUnknown(
              data['dimension_id']!, _dimensionIdMeta));
    } else if (isInserting) {
      context.missing(_dimensionIdMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
          _componentIdMeta,
          componentId.isAcceptableOrUnknown(
              data['component_id']!, _componentIdMeta));
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    if (data.containsKey('exponent')) {
      context.handle(_exponentMeta,
          exponent.isAcceptableOrUnknown(data['exponent']!, _exponentMeta));
    } else if (isInserting) {
      context.missing(_exponentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dimensionsId, componentId};
  @override
  _DimensionComponent map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _DimensionComponent.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_DimensionComponentsTable createAlias(String alias) {
    return $_DimensionComponentsTable(_db, alias);
  }
}

class _Measurable extends DataClass implements Insertable<_Measurable> {
  final String id;
  final String dimensionsId;
  _Measurable({required this.id, required this.dimensionsId});
  factory _Measurable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Measurable(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      dimensionsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimensions_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dimensions_id'] = Variable<String>(dimensionsId);
    return map;
  }

  _MeasurablesCompanion toCompanion(bool nullToAbsent) {
    return _MeasurablesCompanion(
      id: Value(id),
      dimensionsId: Value(dimensionsId),
    );
  }

  factory _Measurable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Measurable(
      id: serializer.fromJson<String>(json['id']),
      dimensionsId: serializer.fromJson<String>(json['dimensionsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dimensionsId': serializer.toJson<String>(dimensionsId),
    };
  }

  _Measurable copyWith({String? id, String? dimensionsId}) => _Measurable(
        id: id ?? this.id,
        dimensionsId: dimensionsId ?? this.dimensionsId,
      );
  @override
  String toString() {
    return (StringBuffer('_Measurable(')
          ..write('id: $id, ')
          ..write('dimensionsId: $dimensionsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, dimensionsId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Measurable &&
          other.id == this.id &&
          other.dimensionsId == this.dimensionsId);
}

class _MeasurablesCompanion extends UpdateCompanion<_Measurable> {
  final Value<String> id;
  final Value<String> dimensionsId;
  const _MeasurablesCompanion({
    this.id = const Value.absent(),
    this.dimensionsId = const Value.absent(),
  });
  _MeasurablesCompanion.insert({
    required String id,
    required String dimensionsId,
  })  : id = Value(id),
        dimensionsId = Value(dimensionsId);
  static Insertable<_Measurable> custom({
    Expression<String>? id,
    Expression<String>? dimensionsId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dimensionsId != null) 'dimensions_id': dimensionsId,
    });
  }

  _MeasurablesCompanion copyWith(
      {Value<String>? id, Value<String>? dimensionsId}) {
    return _MeasurablesCompanion(
      id: id ?? this.id,
      dimensionsId: dimensionsId ?? this.dimensionsId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dimensionsId.present) {
      map['dimensions_id'] = Variable<String>(dimensionsId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_MeasurablesCompanion(')
          ..write('id: $id, ')
          ..write('dimensionsId: $dimensionsId')
          ..write(')'))
        .toString();
  }
}

class $_MeasurablesTable extends _Measurables
    with TableInfo<$_MeasurablesTable, _Measurable> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_MeasurablesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dimensionsIdMeta =
      const VerificationMeta('dimensionsId');
  @override
  late final GeneratedTextColumn dimensionsId = _constructDimensionsId();
  GeneratedTextColumn _constructDimensionsId() {
    return GeneratedTextColumn(
      'dimensions_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, dimensionsId];
  @override
  $_MeasurablesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'measurables';
  @override
  final String actualTableName = 'measurables';
  @override
  VerificationContext validateIntegrity(Insertable<_Measurable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('dimensions_id')) {
      context.handle(
          _dimensionsIdMeta,
          dimensionsId.isAcceptableOrUnknown(
              data['dimensions_id']!, _dimensionsIdMeta));
    } else if (isInserting) {
      context.missing(_dimensionsIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  _Measurable map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Measurable.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_MeasurablesTable createAlias(String alias) {
    return $_MeasurablesTable(_db, alias);
  }
}

abstract class _$_MoorDatabase extends GeneratedDatabase {
  _$_MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $_DimensionUnitsTable dimensionUnits = $_DimensionUnitsTable(this);
  late final $_DimensionComponentsTable dimensionComponents =
      $_DimensionComponentsTable(this);
  late final $_MeasurablesTable measurables = $_MeasurablesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dimensionUnits, dimensionComponents, measurables];
}
