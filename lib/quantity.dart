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
    if (units == null)
      units = this.units;
    else
      assert(units.dimensionsId == this.units.dimensionsId);
    return Quantity(this.amount + amount*units.multiplier, units);
  }
  Quantity addQuantity(Quantity q) {
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
    return subtract(q.amount, q.units);
  }
  Quantity multiply(num amount) {
    return Quantity(this.amount * amount, units);
  }
  Quantity divide(num amount) {
    return Quantity(this.amount / amount, units);
  }

  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Quantity &&
        that.runtimeType == this.runtimeType) {
      return units.dimensionsId == that.units.dimensionsId &&
          amount*units.multiplier == that.amount*units.multiplier;
    }
    return false;
  }
  int get hashCode => units.hashCode ^ amount.hashCode;

  @override
  String toString() => "Quantity(amount: $amount, units: $units)";
}
