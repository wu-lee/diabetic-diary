// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class _DimensionUnit extends DataClass implements Insertable<_DimensionUnit> {
  final String dimensionsId;
  final String unitsId;
  final double multiplier;
  _DimensionUnit(
      {required this.dimensionsId,
      required this.unitsId,
      required this.multiplier});
  factory _DimensionUnit.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _DimensionUnit(
      dimensionsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimensions_id'])!,
      unitsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_id'])!,
      multiplier: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}multiplier'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dimensions_id'] = Variable<String>(dimensionsId);
    map['units_id'] = Variable<String>(unitsId);
    map['multiplier'] = Variable<double>(multiplier);
    return map;
  }

  _DimensionUnitsCompanion toCompanion(bool nullToAbsent) {
    return _DimensionUnitsCompanion(
      dimensionsId: Value(dimensionsId),
      unitsId: Value(unitsId),
      multiplier: Value(multiplier),
    );
  }

  factory _DimensionUnit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _DimensionUnit(
      dimensionsId: serializer.fromJson<String>(json['dimensionsId']),
      unitsId: serializer.fromJson<String>(json['unitsId']),
      multiplier: serializer.fromJson<double>(json['multiplier']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dimensionsId': serializer.toJson<String>(dimensionsId),
      'unitsId': serializer.toJson<String>(unitsId),
      'multiplier': serializer.toJson<double>(multiplier),
    };
  }

  _DimensionUnit copyWith(
          {String? dimensionsId, String? unitsId, double? multiplier}) =>
      _DimensionUnit(
        dimensionsId: dimensionsId ?? this.dimensionsId,
        unitsId: unitsId ?? this.unitsId,
        multiplier: multiplier ?? this.multiplier,
      );
  @override
  String toString() {
    return (StringBuffer('_DimensionUnit(')
          ..write('dimensionsId: $dimensionsId, ')
          ..write('unitsId: $unitsId, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      dimensionsId.hashCode, $mrjc(unitsId.hashCode, multiplier.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _DimensionUnit &&
          other.dimensionsId == this.dimensionsId &&
          other.unitsId == this.unitsId &&
          other.multiplier == this.multiplier);
}

class _DimensionUnitsCompanion extends UpdateCompanion<_DimensionUnit> {
  final Value<String> dimensionsId;
  final Value<String> unitsId;
  final Value<double> multiplier;
  const _DimensionUnitsCompanion({
    this.dimensionsId = const Value.absent(),
    this.unitsId = const Value.absent(),
    this.multiplier = const Value.absent(),
  });
  _DimensionUnitsCompanion.insert({
    required String dimensionsId,
    required String unitsId,
    required double multiplier,
  })  : dimensionsId = Value(dimensionsId),
        unitsId = Value(unitsId),
        multiplier = Value(multiplier);
  static Insertable<_DimensionUnit> custom({
    Expression<String>? dimensionsId,
    Expression<String>? unitsId,
    Expression<double>? multiplier,
  }) {
    return RawValuesInsertable({
      if (dimensionsId != null) 'dimensions_id': dimensionsId,
      if (unitsId != null) 'units_id': unitsId,
      if (multiplier != null) 'multiplier': multiplier,
    });
  }

  _DimensionUnitsCompanion copyWith(
      {Value<String>? dimensionsId,
      Value<String>? unitsId,
      Value<double>? multiplier}) {
    return _DimensionUnitsCompanion(
      dimensionsId: dimensionsId ?? this.dimensionsId,
      unitsId: unitsId ?? this.unitsId,
      multiplier: multiplier ?? this.multiplier,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dimensionsId.present) {
      map['dimensions_id'] = Variable<String>(dimensionsId.value);
    }
    if (unitsId.present) {
      map['units_id'] = Variable<String>(unitsId.value);
    }
    if (multiplier.present) {
      map['multiplier'] = Variable<double>(multiplier.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_DimensionUnitsCompanion(')
          ..write('dimensionsId: $dimensionsId, ')
          ..write('unitsId: $unitsId, ')
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

  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedTextColumn unitsId = _constructUnitsId();
  GeneratedTextColumn _constructUnitsId() {
    return GeneratedTextColumn(
      'units_id',
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
  List<GeneratedColumn> get $columns => [dimensionsId, unitsId, multiplier];
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
    if (data.containsKey('dimensions_id')) {
      context.handle(
          _dimensionsIdMeta,
          dimensionsId.isAcceptableOrUnknown(
              data['dimensions_id']!, _dimensionsIdMeta));
    } else if (isInserting) {
      context.missing(_dimensionsIdMeta);
    }
    if (data.containsKey('units_id')) {
      context.handle(_unitsIdMeta,
          unitsId.isAcceptableOrUnknown(data['units_id']!, _unitsIdMeta));
    } else if (isInserting) {
      context.missing(_unitsIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {dimensionsId, unitsId};
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
  final String dimensionsId;
  final String componentId;
  final int exponent;
  _DimensionComponent(
      {required this.dimensionsId,
      required this.componentId,
      required this.exponent});
  factory _DimensionComponent.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _DimensionComponent(
      dimensionsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimensions_id'])!,
      componentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}component_id'])!,
      exponent: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exponent'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['dimensions_id'] = Variable<String>(dimensionsId);
    map['component_id'] = Variable<String>(componentId);
    map['exponent'] = Variable<int>(exponent);
    return map;
  }

  _DimensionComponentsCompanion toCompanion(bool nullToAbsent) {
    return _DimensionComponentsCompanion(
      dimensionsId: Value(dimensionsId),
      componentId: Value(componentId),
      exponent: Value(exponent),
    );
  }

  factory _DimensionComponent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _DimensionComponent(
      dimensionsId: serializer.fromJson<String>(json['dimensionsId']),
      componentId: serializer.fromJson<String>(json['componentId']),
      exponent: serializer.fromJson<int>(json['exponent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dimensionsId': serializer.toJson<String>(dimensionsId),
      'componentId': serializer.toJson<String>(componentId),
      'exponent': serializer.toJson<int>(exponent),
    };
  }

  _DimensionComponent copyWith(
          {String? dimensionsId, String? componentId, int? exponent}) =>
      _DimensionComponent(
        dimensionsId: dimensionsId ?? this.dimensionsId,
        componentId: componentId ?? this.componentId,
        exponent: exponent ?? this.exponent,
      );
  @override
  String toString() {
    return (StringBuffer('_DimensionComponent(')
          ..write('dimensionsId: $dimensionsId, ')
          ..write('componentId: $componentId, ')
          ..write('exponent: $exponent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      dimensionsId.hashCode, $mrjc(componentId.hashCode, exponent.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _DimensionComponent &&
          other.dimensionsId == this.dimensionsId &&
          other.componentId == this.componentId &&
          other.exponent == this.exponent);
}

class _DimensionComponentsCompanion
    extends UpdateCompanion<_DimensionComponent> {
  final Value<String> dimensionsId;
  final Value<String> componentId;
  final Value<int> exponent;
  const _DimensionComponentsCompanion({
    this.dimensionsId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.exponent = const Value.absent(),
  });
  _DimensionComponentsCompanion.insert({
    required String dimensionsId,
    required String componentId,
    required int exponent,
  })  : dimensionsId = Value(dimensionsId),
        componentId = Value(componentId),
        exponent = Value(exponent);
  static Insertable<_DimensionComponent> custom({
    Expression<String>? dimensionsId,
    Expression<String>? componentId,
    Expression<int>? exponent,
  }) {
    return RawValuesInsertable({
      if (dimensionsId != null) 'dimensions_id': dimensionsId,
      if (componentId != null) 'component_id': componentId,
      if (exponent != null) 'exponent': exponent,
    });
  }

  _DimensionComponentsCompanion copyWith(
      {Value<String>? dimensionsId,
      Value<String>? componentId,
      Value<int>? exponent}) {
    return _DimensionComponentsCompanion(
      dimensionsId: dimensionsId ?? this.dimensionsId,
      componentId: componentId ?? this.componentId,
      exponent: exponent ?? this.exponent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dimensionsId.present) {
      map['dimensions_id'] = Variable<String>(dimensionsId.value);
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
          ..write('dimensionsId: $dimensionsId, ')
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
    if (data.containsKey('dimensions_id')) {
      context.handle(
          _dimensionsIdMeta,
          dimensionsId.isAcceptableOrUnknown(
              data['dimensions_id']!, _dimensionsIdMeta));
    } else if (isInserting) {
      context.missing(_dimensionsIdMeta);
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

class _Edible extends DataClass implements Insertable<_Edible> {
  final String id;
  final String contains;
  final double amount;
  final String unitsId;
  _Edible(
      {required this.id,
      required this.contains,
      required this.amount,
      required this.unitsId});
  factory _Edible.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Edible(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      contains: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contains'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      unitsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['contains'] = Variable<String>(contains);
    map['amount'] = Variable<double>(amount);
    map['units_id'] = Variable<String>(unitsId);
    return map;
  }

  _EdiblesCompanion toCompanion(bool nullToAbsent) {
    return _EdiblesCompanion(
      id: Value(id),
      contains: Value(contains),
      amount: Value(amount),
      unitsId: Value(unitsId),
    );
  }

  factory _Edible.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Edible(
      id: serializer.fromJson<String>(json['id']),
      contains: serializer.fromJson<String>(json['contains']),
      amount: serializer.fromJson<double>(json['amount']),
      unitsId: serializer.fromJson<String>(json['unitsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contains': serializer.toJson<String>(contains),
      'amount': serializer.toJson<double>(amount),
      'unitsId': serializer.toJson<String>(unitsId),
    };
  }

  _Edible copyWith(
          {String? id, String? contains, double? amount, String? unitsId}) =>
      _Edible(
        id: id ?? this.id,
        contains: contains ?? this.contains,
        amount: amount ?? this.amount,
        unitsId: unitsId ?? this.unitsId,
      );
  @override
  String toString() {
    return (StringBuffer('_Edible(')
          ..write('id: $id, ')
          ..write('contains: $contains, ')
          ..write('amount: $amount, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(contains.hashCode, $mrjc(amount.hashCode, unitsId.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Edible &&
          other.id == this.id &&
          other.contains == this.contains &&
          other.amount == this.amount &&
          other.unitsId == this.unitsId);
}

class _EdiblesCompanion extends UpdateCompanion<_Edible> {
  final Value<String> id;
  final Value<String> contains;
  final Value<double> amount;
  final Value<String> unitsId;
  const _EdiblesCompanion({
    this.id = const Value.absent(),
    this.contains = const Value.absent(),
    this.amount = const Value.absent(),
    this.unitsId = const Value.absent(),
  });
  _EdiblesCompanion.insert({
    required String id,
    required String contains,
    required double amount,
    required String unitsId,
  })  : id = Value(id),
        contains = Value(contains),
        amount = Value(amount),
        unitsId = Value(unitsId);
  static Insertable<_Edible> custom({
    Expression<String>? id,
    Expression<String>? contains,
    Expression<double>? amount,
    Expression<String>? unitsId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contains != null) 'contains': contains,
      if (amount != null) 'amount': amount,
      if (unitsId != null) 'units_id': unitsId,
    });
  }

  _EdiblesCompanion copyWith(
      {Value<String>? id,
      Value<String>? contains,
      Value<double>? amount,
      Value<String>? unitsId}) {
    return _EdiblesCompanion(
      id: id ?? this.id,
      contains: contains ?? this.contains,
      amount: amount ?? this.amount,
      unitsId: unitsId ?? this.unitsId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contains.present) {
      map['contains'] = Variable<String>(contains.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unitsId.present) {
      map['units_id'] = Variable<String>(unitsId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_EdiblesCompanion(')
          ..write('id: $id, ')
          ..write('contains: $contains, ')
          ..write('amount: $amount, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }
}

class $_EdiblesTable extends _Edibles with TableInfo<$_EdiblesTable, _Edible> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_EdiblesTable(this._db, [this._alias]);
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

  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedTextColumn contains = _constructContains();
  GeneratedTextColumn _constructContains() {
    return GeneratedTextColumn(
      'contains',
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

  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedTextColumn unitsId = _constructUnitsId();
  GeneratedTextColumn _constructUnitsId() {
    return GeneratedTextColumn(
      'units_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  $_EdiblesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'edibles';
  @override
  final String actualTableName = 'edibles';
  @override
  VerificationContext validateIntegrity(Insertable<_Edible> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('contains')) {
      context.handle(_containsMeta,
          contains.isAcceptableOrUnknown(data['contains']!, _containsMeta));
    } else if (isInserting) {
      context.missing(_containsMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('units_id')) {
      context.handle(_unitsIdMeta,
          unitsId.isAcceptableOrUnknown(data['units_id']!, _unitsIdMeta));
    } else if (isInserting) {
      context.missing(_unitsIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, contains};
  @override
  _Edible map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Edible.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_EdiblesTable createAlias(String alias) {
    return $_EdiblesTable(_db, alias);
  }
}

abstract class _$_MoorDatabase extends GeneratedDatabase {
  _$_MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $_DimensionUnitsTable dimensionUnits = $_DimensionUnitsTable(this);
  late final $_DimensionComponentsTable dimensionComponents =
      $_DimensionComponentsTable(this);
  late final $_MeasurablesTable measurables = $_MeasurablesTable(this);
  late final $_EdiblesTable edibles = $_EdiblesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dimensionUnits, dimensionComponents, measurables, edibles];
}
