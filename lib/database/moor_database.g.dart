// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class _ConfigData extends DataClass implements Insertable<_ConfigData> {
  final String id;
  final String value;
  _ConfigData({required this.id, required this.value});
  factory _ConfigData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _ConfigData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  _ConfigCompanion toCompanion(bool nullToAbsent) {
    return _ConfigCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory _ConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _ConfigData(
      id: serializer.fromJson<String>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  _ConfigData copyWith({String? id, String? value}) => _ConfigData(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('_ConfigData(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, value.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _ConfigData &&
          other.id == this.id &&
          other.value == this.value);
}

class _ConfigCompanion extends UpdateCompanion<_ConfigData> {
  final Value<String> id;
  final Value<String> value;
  const _ConfigCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  _ConfigCompanion.insert({
    required String id,
    required String value,
  })  : id = Value(id),
        value = Value(value);
  static Insertable<_ConfigData> custom({
    Expression<String>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  _ConfigCompanion copyWith({Value<String>? id, Value<String>? value}) {
    return _ConfigCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_ConfigCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $_ConfigTable extends _Config with TableInfo<$_ConfigTable, _ConfigData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_ConfigTable(this._db, [this._alias]);
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

  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedTextColumn value = _constructValue();
  GeneratedTextColumn _constructValue() {
    return GeneratedTextColumn(
      'value',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  $_ConfigTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'config';
  @override
  final String actualTableName = 'config';
  @override
  VerificationContext validateIntegrity(Insertable<_ConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  _ConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _ConfigData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_ConfigTable createAlias(String alias) {
    return $_ConfigTable(_db, alias);
  }
}

class _Unit extends DataClass implements Insertable<_Unit> {
  final String id;
  final String dimensionsId;
  final double multiplier;
  _Unit(
      {required this.id, required this.dimensionsId, required this.multiplier});
  factory _Unit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Unit(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      dimensionsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dimensions_id'])!,
      multiplier: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}multiplier'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['dimensions_id'] = Variable<String>(dimensionsId);
    map['multiplier'] = Variable<double>(multiplier);
    return map;
  }

  _UnitsCompanion toCompanion(bool nullToAbsent) {
    return _UnitsCompanion(
      id: Value(id),
      dimensionsId: Value(dimensionsId),
      multiplier: Value(multiplier),
    );
  }

  factory _Unit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Unit(
      id: serializer.fromJson<String>(json['id']),
      dimensionsId: serializer.fromJson<String>(json['dimensionsId']),
      multiplier: serializer.fromJson<double>(json['multiplier']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dimensionsId': serializer.toJson<String>(dimensionsId),
      'multiplier': serializer.toJson<double>(multiplier),
    };
  }

  _Unit copyWith({String? id, String? dimensionsId, double? multiplier}) =>
      _Unit(
        id: id ?? this.id,
        dimensionsId: dimensionsId ?? this.dimensionsId,
        multiplier: multiplier ?? this.multiplier,
      );
  @override
  String toString() {
    return (StringBuffer('_Unit(')
          ..write('id: $id, ')
          ..write('dimensionsId: $dimensionsId, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(dimensionsId.hashCode, multiplier.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Unit &&
          other.id == this.id &&
          other.dimensionsId == this.dimensionsId &&
          other.multiplier == this.multiplier);
}

class _UnitsCompanion extends UpdateCompanion<_Unit> {
  final Value<String> id;
  final Value<String> dimensionsId;
  final Value<double> multiplier;
  const _UnitsCompanion({
    this.id = const Value.absent(),
    this.dimensionsId = const Value.absent(),
    this.multiplier = const Value.absent(),
  });
  _UnitsCompanion.insert({
    required String id,
    required String dimensionsId,
    required double multiplier,
  })  : id = Value(id),
        dimensionsId = Value(dimensionsId),
        multiplier = Value(multiplier);
  static Insertable<_Unit> custom({
    Expression<String>? id,
    Expression<String>? dimensionsId,
    Expression<double>? multiplier,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dimensionsId != null) 'dimensions_id': dimensionsId,
      if (multiplier != null) 'multiplier': multiplier,
    });
  }

  _UnitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? dimensionsId,
      Value<double>? multiplier}) {
    return _UnitsCompanion(
      id: id ?? this.id,
      dimensionsId: dimensionsId ?? this.dimensionsId,
      multiplier: multiplier ?? this.multiplier,
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
    if (multiplier.present) {
      map['multiplier'] = Variable<double>(multiplier.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_UnitsCompanion(')
          ..write('id: $id, ')
          ..write('dimensionsId: $dimensionsId, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }
}

class $_UnitsTable extends _Units with TableInfo<$_UnitsTable, _Unit> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_UnitsTable(this._db, [this._alias]);
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
    return GeneratedTextColumn('dimensions_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES dimensions(id)');
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
  List<GeneratedColumn> get $columns => [id, dimensionsId, multiplier];
  @override
  $_UnitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'units';
  @override
  final String actualTableName = 'units';
  @override
  VerificationContext validateIntegrity(Insertable<_Unit> instance,
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
  Set<GeneratedColumn> get $primaryKey => {dimensionsId, id};
  @override
  _Unit map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Unit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_UnitsTable createAlias(String alias) {
    return $_UnitsTable(_db, alias);
  }
}

class _Dimension extends DataClass implements Insertable<_Dimension> {
  final String id;
  final String componentId;
  final int exponent;
  _Dimension(
      {required this.id, required this.componentId, required this.exponent});
  factory _Dimension.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Dimension(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      componentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}component_id'])!,
      exponent: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}exponent'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['component_id'] = Variable<String>(componentId);
    map['exponent'] = Variable<int>(exponent);
    return map;
  }

  _DimensionsCompanion toCompanion(bool nullToAbsent) {
    return _DimensionsCompanion(
      id: Value(id),
      componentId: Value(componentId),
      exponent: Value(exponent),
    );
  }

  factory _Dimension.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Dimension(
      id: serializer.fromJson<String>(json['id']),
      componentId: serializer.fromJson<String>(json['componentId']),
      exponent: serializer.fromJson<int>(json['exponent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'componentId': serializer.toJson<String>(componentId),
      'exponent': serializer.toJson<int>(exponent),
    };
  }

  _Dimension copyWith({String? id, String? componentId, int? exponent}) =>
      _Dimension(
        id: id ?? this.id,
        componentId: componentId ?? this.componentId,
        exponent: exponent ?? this.exponent,
      );
  @override
  String toString() {
    return (StringBuffer('_Dimension(')
          ..write('id: $id, ')
          ..write('componentId: $componentId, ')
          ..write('exponent: $exponent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(componentId.hashCode, exponent.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Dimension &&
          other.id == this.id &&
          other.componentId == this.componentId &&
          other.exponent == this.exponent);
}

class _DimensionsCompanion extends UpdateCompanion<_Dimension> {
  final Value<String> id;
  final Value<String> componentId;
  final Value<int> exponent;
  const _DimensionsCompanion({
    this.id = const Value.absent(),
    this.componentId = const Value.absent(),
    this.exponent = const Value.absent(),
  });
  _DimensionsCompanion.insert({
    required String id,
    required String componentId,
    required int exponent,
  })  : id = Value(id),
        componentId = Value(componentId),
        exponent = Value(exponent);
  static Insertable<_Dimension> custom({
    Expression<String>? id,
    Expression<String>? componentId,
    Expression<int>? exponent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (componentId != null) 'component_id': componentId,
      if (exponent != null) 'exponent': exponent,
    });
  }

  _DimensionsCompanion copyWith(
      {Value<String>? id, Value<String>? componentId, Value<int>? exponent}) {
    return _DimensionsCompanion(
      id: id ?? this.id,
      componentId: componentId ?? this.componentId,
      exponent: exponent ?? this.exponent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    return (StringBuffer('_DimensionsCompanion(')
          ..write('id: $id, ')
          ..write('componentId: $componentId, ')
          ..write('exponent: $exponent')
          ..write(')'))
        .toString();
  }
}

class $_DimensionsTable extends _Dimensions
    with TableInfo<$_DimensionsTable, _Dimension> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_DimensionsTable(this._db, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, componentId, exponent];
  @override
  $_DimensionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'dimensions';
  @override
  final String actualTableName = 'dimensions';
  @override
  VerificationContext validateIntegrity(Insertable<_Dimension> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id, componentId};
  @override
  _Dimension map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Dimension.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_DimensionsTable createAlias(String alias) {
    return $_DimensionsTable(_db, alias);
  }
}

class _Measurable extends DataClass implements Insertable<_Measurable> {
  final String id;
  final String unitsId;
  _Measurable({required this.id, required this.unitsId});
  factory _Measurable.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Measurable(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      unitsId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}units_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['units_id'] = Variable<String>(unitsId);
    return map;
  }

  _MeasurablesCompanion toCompanion(bool nullToAbsent) {
    return _MeasurablesCompanion(
      id: Value(id),
      unitsId: Value(unitsId),
    );
  }

  factory _Measurable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Measurable(
      id: serializer.fromJson<String>(json['id']),
      unitsId: serializer.fromJson<String>(json['unitsId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitsId': serializer.toJson<String>(unitsId),
    };
  }

  _Measurable copyWith({String? id, String? unitsId}) => _Measurable(
        id: id ?? this.id,
        unitsId: unitsId ?? this.unitsId,
      );
  @override
  String toString() {
    return (StringBuffer('_Measurable(')
          ..write('id: $id, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, unitsId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Measurable &&
          other.id == this.id &&
          other.unitsId == this.unitsId);
}

class _MeasurablesCompanion extends UpdateCompanion<_Measurable> {
  final Value<String> id;
  final Value<String> unitsId;
  const _MeasurablesCompanion({
    this.id = const Value.absent(),
    this.unitsId = const Value.absent(),
  });
  _MeasurablesCompanion.insert({
    required String id,
    required String unitsId,
  })  : id = Value(id),
        unitsId = Value(unitsId);
  static Insertable<_Measurable> custom({
    Expression<String>? id,
    Expression<String>? unitsId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitsId != null) 'units_id': unitsId,
    });
  }

  _MeasurablesCompanion copyWith({Value<String>? id, Value<String>? unitsId}) {
    return _MeasurablesCompanion(
      id: id ?? this.id,
      unitsId: unitsId ?? this.unitsId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitsId.present) {
      map['units_id'] = Variable<String>(unitsId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_MeasurablesCompanion(')
          ..write('id: $id, ')
          ..write('unitsId: $unitsId')
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

  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedTextColumn unitsId = _constructUnitsId();
  GeneratedTextColumn _constructUnitsId() {
    return GeneratedTextColumn('units_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES units(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, unitsId];
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
    if (data.containsKey('units_id')) {
      context.handle(_unitsIdMeta,
          unitsId.isAcceptableOrUnknown(data['units_id']!, _unitsIdMeta));
    } else if (isInserting) {
      context.missing(_unitsIdMeta);
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

class _BasicIngredientContent extends DataClass
    implements Insertable<_BasicIngredientContent> {
  final String id;
  final String contains;
  final double amount;
  final String unitsId;
  _BasicIngredientContent(
      {required this.id,
      required this.contains,
      required this.amount,
      required this.unitsId});
  factory _BasicIngredientContent.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _BasicIngredientContent(
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

  _BasicIngredientContentsCompanion toCompanion(bool nullToAbsent) {
    return _BasicIngredientContentsCompanion(
      id: Value(id),
      contains: Value(contains),
      amount: Value(amount),
      unitsId: Value(unitsId),
    );
  }

  factory _BasicIngredientContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _BasicIngredientContent(
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

  _BasicIngredientContent copyWith(
          {String? id, String? contains, double? amount, String? unitsId}) =>
      _BasicIngredientContent(
        id: id ?? this.id,
        contains: contains ?? this.contains,
        amount: amount ?? this.amount,
        unitsId: unitsId ?? this.unitsId,
      );
  @override
  String toString() {
    return (StringBuffer('_BasicIngredientContent(')
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
      (other is _BasicIngredientContent &&
          other.id == this.id &&
          other.contains == this.contains &&
          other.amount == this.amount &&
          other.unitsId == this.unitsId);
}

class _BasicIngredientContentsCompanion
    extends UpdateCompanion<_BasicIngredientContent> {
  final Value<String> id;
  final Value<String> contains;
  final Value<double> amount;
  final Value<String> unitsId;
  const _BasicIngredientContentsCompanion({
    this.id = const Value.absent(),
    this.contains = const Value.absent(),
    this.amount = const Value.absent(),
    this.unitsId = const Value.absent(),
  });
  _BasicIngredientContentsCompanion.insert({
    required String id,
    required String contains,
    required double amount,
    required String unitsId,
  })  : id = Value(id),
        contains = Value(contains),
        amount = Value(amount),
        unitsId = Value(unitsId);
  static Insertable<_BasicIngredientContent> custom({
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

  _BasicIngredientContentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? contains,
      Value<double>? amount,
      Value<String>? unitsId}) {
    return _BasicIngredientContentsCompanion(
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
    return (StringBuffer('_BasicIngredientContentsCompanion(')
          ..write('id: $id, ')
          ..write('contains: $contains, ')
          ..write('amount: $amount, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }
}

class $_BasicIngredientContentsTable extends _BasicIngredientContents
    with TableInfo<$_BasicIngredientContentsTable, _BasicIngredientContent> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_BasicIngredientContentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  }

  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedTextColumn contains = _constructContains();
  GeneratedTextColumn _constructContains() {
    return GeneratedTextColumn('contains', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES measurables(id)');
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
    return GeneratedTextColumn('units_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES units(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  $_BasicIngredientContentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'basic_ingredient_contents';
  @override
  final String actualTableName = 'basic_ingredient_contents';
  @override
  VerificationContext validateIntegrity(
      Insertable<_BasicIngredientContent> instance,
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
  _BasicIngredientContent map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return _BasicIngredientContent.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_BasicIngredientContentsTable createAlias(String alias) {
    return $_BasicIngredientContentsTable(_db, alias);
  }
}

class _Edible extends DataClass implements Insertable<_Edible> {
  final String id;
  final bool isBasic;
  _Edible({required this.id, required this.isBasic});
  factory _Edible.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Edible(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      isBasic: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_basic'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['is_basic'] = Variable<bool>(isBasic);
    return map;
  }

  _EdiblesCompanion toCompanion(bool nullToAbsent) {
    return _EdiblesCompanion(
      id: Value(id),
      isBasic: Value(isBasic),
    );
  }

  factory _Edible.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Edible(
      id: serializer.fromJson<String>(json['id']),
      isBasic: serializer.fromJson<bool>(json['isBasic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'isBasic': serializer.toJson<bool>(isBasic),
    };
  }

  _Edible copyWith({String? id, bool? isBasic}) => _Edible(
        id: id ?? this.id,
        isBasic: isBasic ?? this.isBasic,
      );
  @override
  String toString() {
    return (StringBuffer('_Edible(')
          ..write('id: $id, ')
          ..write('isBasic: $isBasic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, isBasic.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Edible &&
          other.id == this.id &&
          other.isBasic == this.isBasic);
}

class _EdiblesCompanion extends UpdateCompanion<_Edible> {
  final Value<String> id;
  final Value<bool> isBasic;
  const _EdiblesCompanion({
    this.id = const Value.absent(),
    this.isBasic = const Value.absent(),
  });
  _EdiblesCompanion.insert({
    required String id,
    required bool isBasic,
  })  : id = Value(id),
        isBasic = Value(isBasic);
  static Insertable<_Edible> custom({
    Expression<String>? id,
    Expression<bool>? isBasic,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isBasic != null) 'is_basic': isBasic,
    });
  }

  _EdiblesCompanion copyWith({Value<String>? id, Value<bool>? isBasic}) {
    return _EdiblesCompanion(
      id: id ?? this.id,
      isBasic: isBasic ?? this.isBasic,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (isBasic.present) {
      map['is_basic'] = Variable<bool>(isBasic.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_EdiblesCompanion(')
          ..write('id: $id, ')
          ..write('isBasic: $isBasic')
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

  final VerificationMeta _isBasicMeta = const VerificationMeta('isBasic');
  @override
  late final GeneratedBoolColumn isBasic = _constructIsBasic();
  GeneratedBoolColumn _constructIsBasic() {
    return GeneratedBoolColumn(
      'is_basic',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, isBasic];
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
    if (data.containsKey('is_basic')) {
      context.handle(_isBasicMeta,
          isBasic.isAcceptableOrUnknown(data['is_basic']!, _isBasicMeta));
    } else if (isInserting) {
      context.missing(_isBasicMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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

class _DishContent extends DataClass implements Insertable<_DishContent> {
  final String id;
  final String contains;
  final double amount;
  final String unitsId;
  _DishContent(
      {required this.id,
      required this.contains,
      required this.amount,
      required this.unitsId});
  factory _DishContent.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _DishContent(
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

  _DishContentsCompanion toCompanion(bool nullToAbsent) {
    return _DishContentsCompanion(
      id: Value(id),
      contains: Value(contains),
      amount: Value(amount),
      unitsId: Value(unitsId),
    );
  }

  factory _DishContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _DishContent(
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

  _DishContent copyWith(
          {String? id, String? contains, double? amount, String? unitsId}) =>
      _DishContent(
        id: id ?? this.id,
        contains: contains ?? this.contains,
        amount: amount ?? this.amount,
        unitsId: unitsId ?? this.unitsId,
      );
  @override
  String toString() {
    return (StringBuffer('_DishContent(')
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
      (other is _DishContent &&
          other.id == this.id &&
          other.contains == this.contains &&
          other.amount == this.amount &&
          other.unitsId == this.unitsId);
}

class _DishContentsCompanion extends UpdateCompanion<_DishContent> {
  final Value<String> id;
  final Value<String> contains;
  final Value<double> amount;
  final Value<String> unitsId;
  const _DishContentsCompanion({
    this.id = const Value.absent(),
    this.contains = const Value.absent(),
    this.amount = const Value.absent(),
    this.unitsId = const Value.absent(),
  });
  _DishContentsCompanion.insert({
    required String id,
    required String contains,
    required double amount,
    required String unitsId,
  })  : id = Value(id),
        contains = Value(contains),
        amount = Value(amount),
        unitsId = Value(unitsId);
  static Insertable<_DishContent> custom({
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

  _DishContentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? contains,
      Value<double>? amount,
      Value<String>? unitsId}) {
    return _DishContentsCompanion(
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
    return (StringBuffer('_DishContentsCompanion(')
          ..write('id: $id, ')
          ..write('contains: $contains, ')
          ..write('amount: $amount, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }
}

class $_DishContentsTable extends _DishContents
    with TableInfo<$_DishContentsTable, _DishContent> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_DishContentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  }

  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedTextColumn contains = _constructContains();
  GeneratedTextColumn _constructContains() {
    return GeneratedTextColumn('contains', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES edibles(id)');
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
    return GeneratedTextColumn('units_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES units(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  $_DishContentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'dish_contents';
  @override
  final String actualTableName = 'dish_contents';
  @override
  VerificationContext validateIntegrity(Insertable<_DishContent> instance,
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
  _DishContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _DishContent.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_DishContentsTable createAlias(String alias) {
    return $_DishContentsTable(_db, alias);
  }
}

class _Meal extends DataClass implements Insertable<_Meal> {
  final String id;
  final String title;
  final String notes;
  final DateTime timestamp;
  _Meal(
      {required this.id,
      required this.title,
      required this.notes,
      required this.timestamp});
  factory _Meal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Meal(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      notes: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notes'])!,
      timestamp: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  _MealsCompanion toCompanion(bool nullToAbsent) {
    return _MealsCompanion(
      id: Value(id),
      title: Value(title),
      notes: Value(notes),
      timestamp: Value(timestamp),
    );
  }

  factory _Meal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Meal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  _Meal copyWith(
          {String? id, String? title, String? notes, DateTime? timestamp}) =>
      _Meal(
        id: id ?? this.id,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('_Meal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(title.hashCode, $mrjc(notes.hashCode, timestamp.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Meal &&
          other.id == this.id &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.timestamp == this.timestamp);
}

class _MealsCompanion extends UpdateCompanion<_Meal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> timestamp;
  const _MealsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  _MealsCompanion.insert({
    required String id,
    required String title,
    required String notes,
    required DateTime timestamp,
  })  : id = Value(id),
        title = Value(title),
        notes = Value(notes),
        timestamp = Value(timestamp);
  static Insertable<_Meal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  _MealsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? notes,
      Value<DateTime>? timestamp}) {
    return _MealsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_MealsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $_MealsTable extends _Meals with TableInfo<$_MealsTable, _Meal> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_MealsTable(this._db, [this._alias]);
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

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedTextColumn notes = _constructNotes();
  GeneratedTextColumn _constructNotes() {
    return GeneratedTextColumn(
      'notes',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedDateTimeColumn timestamp = _constructTimestamp();
  GeneratedDateTimeColumn _constructTimestamp() {
    return GeneratedDateTimeColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, notes, timestamp];
  @override
  $_MealsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'meals';
  @override
  final String actualTableName = 'meals';
  @override
  VerificationContext validateIntegrity(Insertable<_Meal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  _Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Meal.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_MealsTable createAlias(String alias) {
    return $_MealsTable(_db, alias);
  }
}

class _MealContent extends DataClass implements Insertable<_MealContent> {
  final String id;
  final String contains;
  final double amount;
  final String unitsId;
  _MealContent(
      {required this.id,
      required this.contains,
      required this.amount,
      required this.unitsId});
  factory _MealContent.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _MealContent(
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

  _MealContentsCompanion toCompanion(bool nullToAbsent) {
    return _MealContentsCompanion(
      id: Value(id),
      contains: Value(contains),
      amount: Value(amount),
      unitsId: Value(unitsId),
    );
  }

  factory _MealContent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _MealContent(
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

  _MealContent copyWith(
          {String? id, String? contains, double? amount, String? unitsId}) =>
      _MealContent(
        id: id ?? this.id,
        contains: contains ?? this.contains,
        amount: amount ?? this.amount,
        unitsId: unitsId ?? this.unitsId,
      );
  @override
  String toString() {
    return (StringBuffer('_MealContent(')
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
      (other is _MealContent &&
          other.id == this.id &&
          other.contains == this.contains &&
          other.amount == this.amount &&
          other.unitsId == this.unitsId);
}

class _MealContentsCompanion extends UpdateCompanion<_MealContent> {
  final Value<String> id;
  final Value<String> contains;
  final Value<double> amount;
  final Value<String> unitsId;
  const _MealContentsCompanion({
    this.id = const Value.absent(),
    this.contains = const Value.absent(),
    this.amount = const Value.absent(),
    this.unitsId = const Value.absent(),
  });
  _MealContentsCompanion.insert({
    required String id,
    required String contains,
    required double amount,
    required String unitsId,
  })  : id = Value(id),
        contains = Value(contains),
        amount = Value(amount),
        unitsId = Value(unitsId);
  static Insertable<_MealContent> custom({
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

  _MealContentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? contains,
      Value<double>? amount,
      Value<String>? unitsId}) {
    return _MealContentsCompanion(
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
    return (StringBuffer('_MealContentsCompanion(')
          ..write('id: $id, ')
          ..write('contains: $contains, ')
          ..write('amount: $amount, ')
          ..write('unitsId: $unitsId')
          ..write(')'))
        .toString();
  }
}

class $_MealContentsTable extends _MealContents
    with TableInfo<$_MealContentsTable, _MealContent> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_MealContentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES meals(id)');
  }

  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedTextColumn contains = _constructContains();
  GeneratedTextColumn _constructContains() {
    return GeneratedTextColumn('contains', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES edibles(id)');
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
    return GeneratedTextColumn('units_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES units(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  $_MealContentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'meal_contents';
  @override
  final String actualTableName = 'meal_contents';
  @override
  VerificationContext validateIntegrity(Insertable<_MealContent> instance,
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
  _MealContent map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _MealContent.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_MealContentsTable createAlias(String alias) {
    return $_MealContentsTable(_db, alias);
  }
}

abstract class _$_MoorDatabase extends GeneratedDatabase {
  _$_MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $_ConfigTable config = $_ConfigTable(this);
  late final $_UnitsTable units = $_UnitsTable(this);
  late final $_DimensionsTable dimensions = $_DimensionsTable(this);
  late final $_MeasurablesTable measurables = $_MeasurablesTable(this);
  late final $_BasicIngredientContentsTable basicIngredientContents =
      $_BasicIngredientContentsTable(this);
  late final $_EdiblesTable edibles = $_EdiblesTable(this);
  late final $_DishContentsTable dishContents = $_DishContentsTable(this);
  late final $_MealsTable meals = $_MealsTable(this);
  late final $_MealContentsTable mealContents = $_MealContentsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        config,
        units,
        dimensions,
        measurables,
        basicIngredientContents,
        edibles,
        dishContents,
        meals,
        mealContents
      ];
}
