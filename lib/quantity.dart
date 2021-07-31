import 'package:diabetic_diary/translation.dart';
import 'package:flutter/foundation.dart';

import 'units.dart';

/// Represents a quantity expressed with some measurement Dimensions
class Quantity {
  final Units units;
  final num amount;

  const Quantity(this.amount, this.units);

//  Quantity operator* (num n) => Quantity(this.dims, amount * n);
//  Quantity operator+ (Quantity that) => Quantity(dims, amount+that.amount);

  // Add an amount in a an optionally different unit
  Quantity add(num amount, [Units? units]) {
    if (units == null) { // Simple case
      debugPrint("Quantity = ${this.amount} + $amount = ${this.amount + amount} (${symbolToString(this.units.id)})");
      return Quantity(this.amount + amount, this.units);
    }
    assert(units.dimensionsId == this.units.dimensionsId);
    final adjustedAmount = amount * units.multiplier / this.units.multiplier;

    debugPrint("Quantity = ${this.amount} + $amount (${symbolToString(units.id)}) * ${units.multiplier / this.units.multiplier} = ${this
        .amount + adjustedAmount} (${symbolToString(this.units.id)})");
    return Quantity(this.amount + adjustedAmount, this.units);
  }
  Quantity addQuantity(Quantity q) {
    assert(q.units.dimensionsId == units.dimensionsId);
    return add(q.amount, q.units);
  }
  Quantity subtract(num amount, [Units? units]) {
    if (units == null)
      units = this.units;
    else
      assert(units.dimensionsId == this.units.dimensionsId);
    return Quantity(this.amount - amount*units.multiplier, units);
  }
  Quantity subtractQuantity(Quantity q) {
    assert(units.dimensionsId == this.units.dimensionsId);
    return subtract(q.amount, q.units);
  }
  Quantity multiply(num amount) {
    debugPrint("Quantity = ${this.amount} * $amount = ${this.amount*amount}");
    return Quantity(this.amount * amount, units);
  }
  Quantity divide(num amount) {
    return Quantity(this.amount / amount, units);
  }
  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Quantity &&
        that.runtimeType == this.runtimeType) {
      if (units.dimensionsId != that.units.dimensionsId) return false;
      debugPrint("${amount*units.multiplier} != ${that.amount*that.units.multiplier}?");
      return (amount*units.multiplier - that.amount*that.units.multiplier).abs() < 0.000000000001;
    }
    return false;
  }
  int get hashCode => units.hashCode ^ amount.hashCode;

  @override
  String toString() => "Quantity(amount: $amount, units: $units)";
}
