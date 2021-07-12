// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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
    return GeneratedTextColumn(
      'dimensions_id',
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
  late final $_UnitsTable units = $_UnitsTable(this);
  late final $_DimensionsTable dimensions = $_DimensionsTable(this);
  late final $_MeasurablesTable measurables = $_MeasurablesTable(this);
  late final $_EdiblesTable edibles = $_EdiblesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [units, dimensions, measurables, edibles];
}
