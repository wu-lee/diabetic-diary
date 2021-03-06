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
  int get hashCode => Object.hash(id, value);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'config';
  @override
  String get actualTableName => 'config';
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
  int get hashCode => Object.hash(id, dimensionsId, multiplier);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _dimensionsIdMeta =
      const VerificationMeta('dimensionsId');
  @override
  late final GeneratedColumn<String?> dimensionsId = GeneratedColumn<String?>(
      'dimensions_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES dimensions(id)');
  final VerificationMeta _multiplierMeta = const VerificationMeta('multiplier');
  @override
  late final GeneratedColumn<double?> multiplier = GeneratedColumn<double?>(
      'multiplier', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, dimensionsId, multiplier];
  @override
  String get aliasedName => _alias ?? 'units';
  @override
  String get actualTableName => 'units';
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
  int get hashCode => Object.hash(id, componentId, exponent);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _componentIdMeta =
      const VerificationMeta('componentId');
  @override
  late final GeneratedColumn<String?> componentId = GeneratedColumn<String?>(
      'component_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _exponentMeta = const VerificationMeta('exponent');
  @override
  late final GeneratedColumn<int?> exponent = GeneratedColumn<int?>(
      'exponent', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, componentId, exponent];
  @override
  String get aliasedName => _alias ?? 'dimensions';
  @override
  String get actualTableName => 'dimensions';
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
  int get hashCode => Object.hash(id, unitsId);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedColumn<String?> unitsId = GeneratedColumn<String?>(
      'units_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES units(id)');
  @override
  List<GeneratedColumn> get $columns => [id, unitsId];
  @override
  String get aliasedName => _alias ?? 'measurables';
  @override
  String get actualTableName => 'measurables';
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
  int get hashCode => Object.hash(id, contains, amount, unitsId);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedColumn<String?> contains = GeneratedColumn<String?>(
      'contains', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES measurables(id)');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedColumn<String?> unitsId = GeneratedColumn<String?>(
      'units_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES units(id)');
  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  String get aliasedName => _alias ?? 'basic_ingredient_contents';
  @override
  String get actualTableName => 'basic_ingredient_contents';
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
  final String label;
  final bool isBasic;
  final double portions;
  _Edible(
      {required this.id,
      required this.label,
      required this.isBasic,
      required this.portions});
  factory _Edible.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Edible(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
      isBasic: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_basic'])!,
      portions: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}portions'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['is_basic'] = Variable<bool>(isBasic);
    map['portions'] = Variable<double>(portions);
    return map;
  }

  _EdiblesCompanion toCompanion(bool nullToAbsent) {
    return _EdiblesCompanion(
      id: Value(id),
      label: Value(label),
      isBasic: Value(isBasic),
      portions: Value(portions),
    );
  }

  factory _Edible.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Edible(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      isBasic: serializer.fromJson<bool>(json['isBasic']),
      portions: serializer.fromJson<double>(json['portions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'isBasic': serializer.toJson<bool>(isBasic),
      'portions': serializer.toJson<double>(portions),
    };
  }

  _Edible copyWith(
          {String? id, String? label, bool? isBasic, double? portions}) =>
      _Edible(
        id: id ?? this.id,
        label: label ?? this.label,
        isBasic: isBasic ?? this.isBasic,
        portions: portions ?? this.portions,
      );
  @override
  String toString() {
    return (StringBuffer('_Edible(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('isBasic: $isBasic, ')
          ..write('portions: $portions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, isBasic, portions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Edible &&
          other.id == this.id &&
          other.label == this.label &&
          other.isBasic == this.isBasic &&
          other.portions == this.portions);
}

class _EdiblesCompanion extends UpdateCompanion<_Edible> {
  final Value<String> id;
  final Value<String> label;
  final Value<bool> isBasic;
  final Value<double> portions;
  const _EdiblesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.isBasic = const Value.absent(),
    this.portions = const Value.absent(),
  });
  _EdiblesCompanion.insert({
    required String id,
    required String label,
    required bool isBasic,
    required double portions,
  })  : id = Value(id),
        label = Value(label),
        isBasic = Value(isBasic),
        portions = Value(portions);
  static Insertable<_Edible> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<bool>? isBasic,
    Expression<double>? portions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (isBasic != null) 'is_basic': isBasic,
      if (portions != null) 'portions': portions,
    });
  }

  _EdiblesCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<bool>? isBasic,
      Value<double>? portions}) {
    return _EdiblesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      isBasic: isBasic ?? this.isBasic,
      portions: portions ?? this.portions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isBasic.present) {
      map['is_basic'] = Variable<bool>(isBasic.value);
    }
    if (portions.present) {
      map['portions'] = Variable<double>(portions.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_EdiblesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('isBasic: $isBasic, ')
          ..write('portions: $portions')
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _isBasicMeta = const VerificationMeta('isBasic');
  @override
  late final GeneratedColumn<bool?> isBasic = GeneratedColumn<bool?>(
      'is_basic', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _portionsMeta = const VerificationMeta('portions');
  @override
  late final GeneratedColumn<double?> portions = GeneratedColumn<double?>(
      'portions', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, label, isBasic, portions];
  @override
  String get aliasedName => _alias ?? 'edibles';
  @override
  String get actualTableName => 'edibles';
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
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('is_basic')) {
      context.handle(_isBasicMeta,
          isBasic.isAcceptableOrUnknown(data['is_basic']!, _isBasicMeta));
    } else if (isInserting) {
      context.missing(_isBasicMeta);
    }
    if (data.containsKey('portions')) {
      context.handle(_portionsMeta,
          portions.isAcceptableOrUnknown(data['portions']!, _portionsMeta));
    } else if (isInserting) {
      context.missing(_portionsMeta);
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
  int get hashCode => Object.hash(id, contains, amount, unitsId);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedColumn<String?> contains = GeneratedColumn<String?>(
      'contains', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedColumn<String?> unitsId = GeneratedColumn<String?>(
      'units_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES units(id)');
  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  String get aliasedName => _alias ?? 'dish_contents';
  @override
  String get actualTableName => 'dish_contents';
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
  final String label;
  final String notes;
  final DateTime timestamp;
  _Meal(
      {required this.id,
      required this.label,
      required this.notes,
      required this.timestamp});
  factory _Meal.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Meal(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
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
    map['label'] = Variable<String>(label);
    map['notes'] = Variable<String>(notes);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  _MealsCompanion toCompanion(bool nullToAbsent) {
    return _MealsCompanion(
      id: Value(id),
      label: Value(label),
      notes: Value(notes),
      timestamp: Value(timestamp),
    );
  }

  factory _Meal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Meal(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      notes: serializer.fromJson<String>(json['notes']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'notes': serializer.toJson<String>(notes),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  _Meal copyWith(
          {String? id, String? label, String? notes, DateTime? timestamp}) =>
      _Meal(
        id: id ?? this.id,
        label: label ?? this.label,
        notes: notes ?? this.notes,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('_Meal(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, notes, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Meal &&
          other.id == this.id &&
          other.label == this.label &&
          other.notes == this.notes &&
          other.timestamp == this.timestamp);
}

class _MealsCompanion extends UpdateCompanion<_Meal> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> notes;
  final Value<DateTime> timestamp;
  const _MealsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.notes = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  _MealsCompanion.insert({
    required String id,
    required String label,
    required String notes,
    required DateTime timestamp,
  })  : id = Value(id),
        label = Value(label),
        notes = Value(notes),
        timestamp = Value(timestamp);
  static Insertable<_Meal> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? notes,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (notes != null) 'notes': notes,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  _MealsCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String>? notes,
      Value<DateTime>? timestamp}) {
    return _MealsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
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
    if (label.present) {
      map['label'] = Variable<String>(label.value);
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
          ..write('label: $label, ')
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String?> notes = GeneratedColumn<String?>(
      'notes', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime?> timestamp = GeneratedColumn<DateTime?>(
      'timestamp', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, label, notes, timestamp];
  @override
  String get aliasedName => _alias ?? 'meals';
  @override
  String get actualTableName => 'meals';
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
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
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
  int get hashCode => Object.hash(id, contains, amount, unitsId);
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
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES meals(id)');
  final VerificationMeta _containsMeta = const VerificationMeta('contains');
  @override
  late final GeneratedColumn<String?> contains = GeneratedColumn<String?>(
      'contains', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES edibles(id)');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _unitsIdMeta = const VerificationMeta('unitsId');
  @override
  late final GeneratedColumn<String?> unitsId = GeneratedColumn<String?>(
      'units_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES units(id)');
  @override
  List<GeneratedColumn> get $columns => [id, contains, amount, unitsId];
  @override
  String get aliasedName => _alias ?? 'meal_contents';
  @override
  String get actualTableName => 'meal_contents';
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

class _Label extends DataClass implements Insertable<_Label> {
  final String id;
  final String label;
  _Label({required this.id, required this.label});
  factory _Label.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return _Label(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    return map;
  }

  _LabelsCompanion toCompanion(bool nullToAbsent) {
    return _LabelsCompanion(
      id: Value(id),
      label: Value(label),
    );
  }

  factory _Label.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return _Label(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
    };
  }

  _Label copyWith({String? id, String? label}) => _Label(
        id: id ?? this.id,
        label: label ?? this.label,
      );
  @override
  String toString() {
    return (StringBuffer('_Label(')
          ..write('id: $id, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _Label && other.id == this.id && other.label == this.label);
}

class _LabelsCompanion extends UpdateCompanion<_Label> {
  final Value<String> id;
  final Value<String> label;
  const _LabelsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
  });
  _LabelsCompanion.insert({
    required String id,
    required String label,
  })  : id = Value(id),
        label = Value(label);
  static Insertable<_Label> custom({
    Expression<String>? id,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
    });
  }

  _LabelsCompanion copyWith({Value<String>? id, Value<String>? label}) {
    return _LabelsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('_LabelsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $_LabelsTable extends _Labels with TableInfo<$_LabelsTable, _Label> {
  final GeneratedDatabase _db;
  final String? _alias;
  $_LabelsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String?> label = GeneratedColumn<String?>(
      'label', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, label];
  @override
  String get aliasedName => _alias ?? 'labels';
  @override
  String get actualTableName => 'labels';
  @override
  VerificationContext validateIntegrity(Insertable<_Label> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  _Label map(Map<String, dynamic> data, {String? tablePrefix}) {
    return _Label.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $_LabelsTable createAlias(String alias) {
    return $_LabelsTable(_db, alias);
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
  late final $_LabelsTable labels = $_LabelsTable(this);
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
        mealContents,
        labels
      ];
}
