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
  late final GeneratedTextColumn dimensionId = _constructDimensionId();
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
  List<GeneratedColumn> get $columns => [dimensionId, unitId, multiplier];
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
          dimensionId.isAcceptableOrUnknown(
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
  Set<GeneratedColumn> get $primaryKey => {dimensionId, unitId};
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
  late final GeneratedTextColumn dimensionId = _constructDimensionId();
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
  List<GeneratedColumn> get $columns => [dimensionId, componentId, exponent];
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
          dimensionId.isAcceptableOrUnknown(
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
  Set<GeneratedColumn> get $primaryKey => {dimensionId, componentId};
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

class _MeasurementType extends DataClass
    implements Insertable<_MeasurementType> {
  final String id;
  final String unitId;
  _MeasurementType({required this.id, required this.unitId});
  factory _MeasurementType.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _MeasurementType(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      unitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unit_id'] = Variable<String>(unitId);
    return map;
  }

  _MeasurementTypesCompanion toCompanion(bool nullToAbsent) {
    return _MeasurementTypesCompanion(
      id: Value(id),
      unitId: Value(unitId),
    );
  }

  factory _MeasurementType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _MeasurementType(
      id: serializer.fromJson<String>(json['id']),
      unitId: serializer.fromJson<String>(json['unitId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitId': serializer.toJson<String>(unitId),
    };
  }

  _MeasurementType copyWith({String? id, String? unitId}) => _MeasurementType(
        id: id ?? this.id,
        unitId: unitId ?? this.unitId,
      );
  @override
  String toString() {
    return (StringBuffer('_MeasurementType(')
          ..write('id: $id, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, unitId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _MeasurementType &&
          other.id == this.id &&
          other.unitId == this.unitId);
}

class _MeasurementTypesCompanion extends UpdateCompanion<_MeasurementType> {
  final Value<String> id;
  final Value<String> unitId;
  const _MeasurementTypesCompanion({
    this.id = const Value.absent(),
    this.unitId = const Value.absent(),
  });
  _MeasurementTypesCompanion.insert({
    required String id,
    required String unitId,
  })  : id = Value(id),
        unitId = Value(unitId);
  static Insertable<_MeasurementType> custom({
    Expression<String>? id,
    Expression<String>? unitId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitId != null) 'unit_id': unitId,
    });
  }

  _MeasurementTypesCompanion copyWith(
      {Value<String>? id, Value<String>? unitId}) {
    return _MeasurementTypesCompanion(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_MeasurementTypesCompanion(')
          ..write('id: $id, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }
}

class $_MeasurementTypesTable extends _MeasurementTypes
    with TableInfo<$_MeasurementTypesTable, _MeasurementType> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_MeasurementTypesTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [id, unitId];
  @override
  $_MeasurementTypesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'measurement_types';
  @override
  final String actualTableName = 'measurement_types';
  @override
  VerificationContext validateIntegrity(Insertable<_MeasurementType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  _MeasurementType map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _MeasurementType.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_MeasurementTypesTable createAlias(String alias) {
    return $_MeasurementTypesTable(_db, alias);
  }
}

class _CompositionStatistic extends DataClass
    implements Insertable<_CompositionStatistic> {
  final String id;
  final String unitId;
  _CompositionStatistic({required this.id, required this.unitId});
  factory _CompositionStatistic.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _CompositionStatistic(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      unitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unit_id'] = Variable<String>(unitId);
    return map;
  }

  _CompositionStatisticsCompanion toCompanion(bool nullToAbsent) {
    return _CompositionStatisticsCompanion(
      id: Value(id),
      unitId: Value(unitId),
    );
  }

  factory _CompositionStatistic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _CompositionStatistic(
      id: serializer.fromJson<String>(json['id']),
      unitId: serializer.fromJson<String>(json['unitId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitId': serializer.toJson<String>(unitId),
    };
  }

  _CompositionStatistic copyWith({String? id, String? unitId}) =>
      _CompositionStatistic(
        id: id ?? this.id,
        unitId: unitId ?? this.unitId,
      );
  @override
  String toString() {
    return (StringBuffer('_CompositionStatistic(')
          ..write('id: $id, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, unitId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _CompositionStatistic &&
          other.id == this.id &&
          other.unitId == this.unitId);
}

class _CompositionStatisticsCompanion
    extends UpdateCompanion<_CompositionStatistic> {
  final Value<String> id;
  final Value<String> unitId;
  const _CompositionStatisticsCompanion({
    this.id = const Value.absent(),
    this.unitId = const Value.absent(),
  });
  _CompositionStatisticsCompanion.insert({
    required String id,
    required String unitId,
  })  : id = Value(id),
        unitId = Value(unitId);
  static Insertable<_CompositionStatistic> custom({
    Expression<String>? id,
    Expression<String>? unitId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitId != null) 'unit_id': unitId,
    });
  }

  _CompositionStatisticsCompanion copyWith(
      {Value<String>? id, Value<String>? unitId}) {
    return _CompositionStatisticsCompanion(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_CompositionStatisticsCompanion(')
          ..write('id: $id, ')
          ..write('unitId: $unitId')
          ..write(')'))
        .toString();
  }
}

class $_CompositionStatisticsTable extends _CompositionStatistics
    with TableInfo<$_CompositionStatisticsTable, _CompositionStatistic> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_CompositionStatisticsTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [id, unitId];
  @override
  $_CompositionStatisticsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'composition_statistics';
  @override
  final String actualTableName = 'composition_statistics';
  @override
  VerificationContext validateIntegrity(
      Insertable<_CompositionStatistic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  _CompositionStatistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _CompositionStatistic.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_CompositionStatisticsTable createAlias(String alias) {
    return $_CompositionStatisticsTable(_db, alias);
  }
}

class _Ingredient extends DataClass implements Insertable<_Ingredient> {
  final String id;
  final String measurementId;
  final String unitId;
  final double amount;
  _Ingredient(
      {required this.id,
      required this.measurementId,
      required this.unitId,
      required this.amount});
  factory _Ingredient.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Ingredient(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      measurementId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}measurement_id'])!,
      unitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit_id'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['measurement_id'] = Variable<String>(measurementId);
    map['unit_id'] = Variable<String>(unitId);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  _IngredientsCompanion toCompanion(bool nullToAbsent) {
    return _IngredientsCompanion(
      id: Value(id),
      measurementId: Value(measurementId),
      unitId: Value(unitId),
      amount: Value(amount),
    );
  }

  factory _Ingredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Ingredient(
      id: serializer.fromJson<String>(json['id']),
      measurementId: serializer.fromJson<String>(json['measurementId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'measurementId': serializer.toJson<String>(measurementId),
      'unitId': serializer.toJson<String>(unitId),
      'amount': serializer.toJson<double>(amount),
    };
  }

  _Ingredient copyWith(
          {String? id,
          String? measurementId,
          String? unitId,
          double? amount}) =>
      _Ingredient(
        id: id ?? this.id,
        measurementId: measurementId ?? this.measurementId,
        unitId: unitId ?? this.unitId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('_Ingredient(')
          ..write('id: $id, ')
          ..write('measurementId: $measurementId, ')
          ..write('unitId: $unitId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(measurementId.hashCode, $mrjc(unitId.hashCode, amount.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Ingredient &&
          other.id == this.id &&
          other.measurementId == this.measurementId &&
          other.unitId == this.unitId &&
          other.amount == this.amount);
}

class _IngredientsCompanion extends UpdateCompanion<_Ingredient> {
  final Value<String> id;
  final Value<String> measurementId;
  final Value<String> unitId;
  final Value<double> amount;
  const _IngredientsCompanion({
    this.id = const Value.absent(),
    this.measurementId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  _IngredientsCompanion.insert({
    required String id,
    required String measurementId,
    required String unitId,
    required double amount,
  })  : id = Value(id),
        measurementId = Value(measurementId),
        unitId = Value(unitId),
        amount = Value(amount);
  static Insertable<_Ingredient> custom({
    Expression<String>? id,
    Expression<String>? measurementId,
    Expression<String>? unitId,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (measurementId != null) 'measurement_id': measurementId,
      if (unitId != null) 'unit_id': unitId,
      if (amount != null) 'amount': amount,
    });
  }

  _IngredientsCompanion copyWith(
      {Value<String>? id,
      Value<String>? measurementId,
      Value<String>? unitId,
      Value<double>? amount}) {
    return _IngredientsCompanion(
      id: id ?? this.id,
      measurementId: measurementId ?? this.measurementId,
      unitId: unitId ?? this.unitId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (measurementId.present) {
      map['measurement_id'] = Variable<String>(measurementId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('measurementId: $measurementId, ')
          ..write('unitId: $unitId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $_IngredientsTable extends _Ingredients
    with TableInfo<$_IngredientsTable, _Ingredient> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_IngredientsTable(this._db, [this._alias]);
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

  final VerificationMeta _measurementIdMeta =
      const VerificationMeta('measurementId');
  @override
  late final GeneratedTextColumn measurementId = _constructMeasurementId();
  GeneratedTextColumn _constructMeasurementId() {
    return GeneratedTextColumn(
      'measurement_id',
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

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedRealColumn amount = _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, measurementId, unitId, amount];
  @override
  $_IngredientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ingredients';
  @override
  final String actualTableName = 'ingredients';
  @override
  VerificationContext validateIntegrity(Insertable<_Ingredient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('measurement_id')) {
      context.handle(
          _measurementIdMeta,
          measurementId.isAcceptableOrUnknown(
              data['measurement_id']!, _measurementIdMeta));
    } else if (isInserting) {
      context.missing(_measurementIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, measurementId};
  @override
  _Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Ingredient.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_IngredientsTable createAlias(String alias) {
    return $_IngredientsTable(_db, alias);
  }
}

class _Dish extends DataClass implements Insertable<_Dish> {
  final String id;
  final String ingredientId;
  final String unitId;
  final double amount;
  _Dish(
      {required this.id,
      required this.ingredientId,
      required this.unitId,
      required this.amount});
  factory _Dish.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Dish(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      ingredientId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ingredient_id'])!,
      unitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit_id'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ingredient_id'] = Variable<String>(ingredientId);
    map['unit_id'] = Variable<String>(unitId);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  _DishesCompanion toCompanion(bool nullToAbsent) {
    return _DishesCompanion(
      id: Value(id),
      ingredientId: Value(ingredientId),
      unitId: Value(unitId),
      amount: Value(amount),
    );
  }

  factory _Dish.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Dish(
      id: serializer.fromJson<String>(json['id']),
      ingredientId: serializer.fromJson<String>(json['ingredientId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ingredientId': serializer.toJson<String>(ingredientId),
      'unitId': serializer.toJson<String>(unitId),
      'amount': serializer.toJson<double>(amount),
    };
  }

  _Dish copyWith(
          {String? id, String? ingredientId, String? unitId, double? amount}) =>
      _Dish(
        id: id ?? this.id,
        ingredientId: ingredientId ?? this.ingredientId,
        unitId: unitId ?? this.unitId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('_Dish(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('unitId: $unitId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(ingredientId.hashCode, $mrjc(unitId.hashCode, amount.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Dish &&
          other.id == this.id &&
          other.ingredientId == this.ingredientId &&
          other.unitId == this.unitId &&
          other.amount == this.amount);
}

class _DishesCompanion extends UpdateCompanion<_Dish> {
  final Value<String> id;
  final Value<String> ingredientId;
  final Value<String> unitId;
  final Value<double> amount;
  const _DishesCompanion({
    this.id = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  _DishesCompanion.insert({
    required String id,
    required String ingredientId,
    required String unitId,
    required double amount,
  })  : id = Value(id),
        ingredientId = Value(ingredientId),
        unitId = Value(unitId),
        amount = Value(amount);
  static Insertable<_Dish> custom({
    Expression<String>? id,
    Expression<String>? ingredientId,
    Expression<String>? unitId,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (unitId != null) 'unit_id': unitId,
      if (amount != null) 'amount': amount,
    });
  }

  _DishesCompanion copyWith(
      {Value<String>? id,
      Value<String>? ingredientId,
      Value<String>? unitId,
      Value<double>? amount}) {
    return _DishesCompanion(
      id: id ?? this.id,
      ingredientId: ingredientId ?? this.ingredientId,
      unitId: unitId ?? this.unitId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<String>(ingredientId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_DishesCompanion(')
          ..write('id: $id, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('unitId: $unitId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $_DishesTable extends _Dishes with TableInfo<$_DishesTable, _Dish> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_DishesTable(this._db, [this._alias]);
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

  final VerificationMeta _ingredientIdMeta =
      const VerificationMeta('ingredientId');
  @override
  late final GeneratedTextColumn ingredientId = _constructIngredientId();
  GeneratedTextColumn _constructIngredientId() {
    return GeneratedTextColumn(
      'ingredient_id',
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

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedRealColumn amount = _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, ingredientId, unitId, amount];
  @override
  $_DishesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'dishes';
  @override
  final String actualTableName = 'dishes';
  @override
  VerificationContext validateIntegrity(Insertable<_Dish> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
          _ingredientIdMeta,
          ingredientId.isAcceptableOrUnknown(
              data['ingredient_id']!, _ingredientIdMeta));
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, ingredientId};
  @override
  _Dish map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Dish.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_DishesTable createAlias(String alias) {
    return $_DishesTable(_db, alias);
  }
}

abstract class _$_MoorDatabase extends GeneratedDatabase {
  _$_MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $_DimensionUnitsTable dimensionUnits = $_DimensionUnitsTable(this);
  late final $_DimensionComponentsTable dimensionComponents =
      $_DimensionComponentsTable(this);
  late final $_MeasurementTypesTable measurementTypes =
      $_MeasurementTypesTable(this);
  late final $_CompositionStatisticsTable compositionStatistics =
      $_CompositionStatisticsTable(this);
  late final $_IngredientsTable ingredients = $_IngredientsTable(this);
  late final $_DishesTable dishes = $_DishesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        dimensionUnits,
        dimensionComponents,
        measurementTypes,
        compositionStatistics,
        ingredients,
        dishes
      ];
}
