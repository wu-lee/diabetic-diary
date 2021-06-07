
import 'package:diabetic_diary/indexable.dart';
import 'package:flutter/foundation.dart';

import 'translation.dart';

/// Represents a measurement dimension, in the sense of dimensional analysis of quantities
class Dimensions implements Indexable {

  final Symbol id;

  /// Unit labels mapped to the multipliers they represent
  final Map <Symbol, num> _units;

  const Dimensions({@required this.id, Map<Symbol, num> units = const {}}) :
    _units = units;

/* Commented, we want to allow static keys of this class, so no == for us
  bool operator== (Object that) => that is Dimensions && elements == that.elements;
  int get hashCode => elements.hashCode;
*/

  /// Find the natural units for an amount (the next smallest in the list of defined units)
  Symbol naturalUnitsFor(num amount) =>
      _naturalUnitsFor(amount, _units);

  /// Find the natural units for an amount (the next smallest in the list of defined units)
  static Symbol _naturalUnitsFor(num amount, Map<Symbol, num> units) {
    final inOrder = units.entries
      .toList()
      ..sort((a,b) => b.value.compareTo(a.value));
    final nextSmallest = inOrder
      .firstWhere((element) => (element.value < amount),
        orElse: () => inOrder.first
      );
    return nextSmallest.key;
  }

  Units units(Symbol id) {
    if (_units.containsKey(id))
      return Units(id, this, _units[id]);
    else
      throw Exception("Unknown #{this.id} unit for #{id}");
  }

  Quantity of(num amount, Symbol symbol) {
    return Quantity(amount, units(symbol));
  }

/*
  static int _combine(Dimensions a, Dimensions b, Dimension d) {
    int aPower = a.elements.containsKey(d)? a.elements[d] : 0;
    int bPower = b.elements.containsKey(d)? b.elements[d] : 0;
    return aPower + bPower;
  }

  static Dimensions combine(Dimensions a, Dimensions b) {
    final Set<Dimension> d = a.elements.keys.toSet()
      ..addAll(b.elements.keys);
    final d2 = Map.fromEntries(d.map((e) => MapEntry(e, _combine(a, b, e))));
    return Dimensions(elements: d2..removeWhere((key, value) => value == 0)); // drop any dimensions of degree 0
  }

 */
}

/// Represents a unit in a particular kind of dimensions
class Units extends Indexable {
  final Dimensions dims;
  final num multiplier;

  const Units(Symbol id, this.dims, this.multiplier) : super(id: id);

  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Units &&
        that.runtimeType == this.runtimeType) {
      return dims == that.dims && id == that.id;
    }
    return false;
  }
  int get hashCode => dims.hashCode ^ id.hashCode;

  Quantity times(num amount) {
    return Quantity(amount, this);
  }
}

/// Represents a quantity expressed with some measurement Dimensions
class Quantity {
  final Units units;
  final num amount;

  const Quantity(this.amount, this.units);

//  Quantity operator* (num n) => Quantity(this.dims, amount * n);
//  Quantity operator+ (Quantity that) => Quantity(dims, amount+that.amount);

  Quantity add(num amount, [Units units]) {
    units ??= this.units;
    return Quantity(this.amount + amount*units.multiplier, units);
  }
  Quantity subtract(num amount, [Units units]) {
    units ??= this.units;
    return Quantity(this.amount - amount*units.multiplier, units);
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
      return units == that.units && amount == that.amount;
    }
    return false;
  }
  int get hashCode => units.hashCode ^ amount.hashCode;

  String format() {
    final naturalUnits = units.dims.naturalUnitsFor(amount);
    return "$amount ${TL8(naturalUnits)}";
  }
}


/*



class Time extends Dimension {
  factory Time() => _instance;

  @override
  Map<Dimension, int> get elements => _dims;

  @override
  Map<String, num> get units => _units;

  const Time._internal();

  static const _instance = Time._internal();
  static const _dims = {_instance: 1};
  static const _units = {'s': 1, 'min': 60, 'hr': 3600};

  static seconds(num n) => Quantity(_instance, 1);
  static minutes(num n) => Quantity(_instance, 60);
  static hours(num n) => Quantity(_instance, 60*60);
}


class Distance extends Dimension {
  factory Distance() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;

  const Distance._internal();

  static const _instance = Distance._internal();
  static const _dims = {_instance: 1};
  static const _units = {'µm': 0.000001, 'mm': 0.001, 'cm': 0.01, 'm': 1, 'km': 1000};

  static meters(num n) => Quantity(_instance, n);
  static kilometers([num n = 1]) => Quantity(_instance, 1000*n);
}

class Volume extends Dimension {
  factory Volume() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;

  const Volume._internal();

  static const _instance = Volume._internal();
  static const _dims = {_instance: 1};
  static const _units = {'µl': 0.000001, 'ml': 0.001, 'cl': 0.01, 'l': 1};

  static metersCubed(num n) => Quantity(_instance, n);
  static kilometersCubed(num n) => Quantity(_instance, 1000*1000*n);
}



class Mass extends Dimension {
  factory Mass() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;

  const Mass._internal();

  static const _instance = Mass._internal();
  static const _dims = {_instance: 1};
  static const _units = {'µg': 0.000001, 'mg': 0.001, 'g': 1, 'kg': 1000};

  static micrograms(num n) => Quantity(_instance, n*0.000001);
  static milligrams(num n) => Quantity(_instance, n*0.001);
  static grams(num n) => Quantity(_instance, n);
  static kilograms(num n) => Quantity(_instance, n*1000);
}

class FractionByMass extends Dimension {
  factory FractionByMass() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;

  const FractionByMass._internal();

  static const _instance = FractionByMass._internal();
  static const _dims = {_instance: 1};
  static const _units = {'mg⁻¹': 0.001, 'cg⁻¹': 0.01, 'g⁻¹': 1, 'Dg⁻¹': 100, 'kg⁻¹': 1000};

  static gramsPerHectogram(num n) => Quantity(_instance, n*0.01);
  static gramsPerGram(num n) => Quantity(_instance, n);
}

class FractionByVolume extends Dimension {
  factory FractionByVolume() => _instance;

  Map<String, num> get units => _units;
  Map<Dimension, int> get elements => _dims;

  const FractionByVolume._internal();

  static const _instance = FractionByVolume._internal();
  static const _dims = {_instance: 1};
  static const _units = {'ml⁻¹': 0.001, 'cl⁻¹': 0.01, 'l⁻¹': 1, 'Dl⁻¹': 100, 'kl⁻¹': 1000};

  static litresPerLitre(num n) => Quantity(_instance, n);
}

class MolesByVolume extends Dimension {
  factory MolesByVolume() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;
  static const _units = {'mM⁻¹': 1000, 'cM⁻¹': 100, 'M⁻¹': 1};

  const MolesByVolume._internal();

  static const _instance = MolesByVolume._internal();
  static const _dims = {_instance: 1};

  static molesPerLitre(num n) => Quantity(_instance, n);
  static millimolesPerDecilitre(num n) => Quantity(_instance, n*10*0.001);
}

class Rate extends Dimension {
  factory Rate() => _instance;

  Map<Dimension, int> get elements => _dims;
  Map<String, num> get units => _units;
  static const _units = {'ms⁻¹': 1000, 's⁻¹': 1, 'min⁻¹': 1/60, 'hr⁻¹': 1/3600};

  const Rate._internal();

  static const _instance = Rate._internal();
  static const _dims = {_instance: 1};

  static perSecond(num n) => Quantity(_instance, n);
  static perMinute(num n) => Quantity(_instance, n/60);
}
*/