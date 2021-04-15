
import 'package:diabetic_diary/indexable.dart';

/// Represents a measurement dimension, in the sense of dimensional analysis of quantities
class Dimensions implements Indexable {

  final Map<Dimension, int> elements;

  const Dimensions(this.elements);

/* Commented, we want to allow static keys of this class, so no == for us
  bool operator== (Object that) => that is Dimensions && elements == that.elements;
  int get hashCode => elements.hashCode;
*/

  static int _combine(Dimensions a, Dimensions b, Dimension d) {
    int aPower = a.elements.containsKey(d)? a.elements[d] : 0;
    int bPower = b.elements.containsKey(d)? b.elements[d] : 0;
    return aPower + bPower;
  }

  static Dimensions combine(Dimensions a, Dimensions b) {
    final Set<Dimension> d = a.elements.keys.toSet()
      ..addAll(b.elements.keys);
    final d2 = Map.fromEntries(d.map((e) => MapEntry(e, _combine(a, b, e))));
    return Dimensions(d2..removeWhere((key, value) => value == 0)); // drop any dimensions of degree 0
  }

  @override
  Symbol get name => new Symbol(this.runtimeType.toString());
}

/// A special case of Dimensions, when there is just one element
abstract class Dimension implements Dimensions {

  const Dimension();

/* Commented, we want to allow static keys of this class, so no == for us
  bool operator== (Object that) => that is Dimensions && elements == that.elements;
  int get hashCode => elements.hashCode;
*/

  @override
  Symbol get name => Symbol(this.runtimeType.toString());

  // Can be shared by all Dimensions
  Dimensions operator* (Dimensions that) => Dimensions.combine(this, that);
}

/// Represents a quantity expressed with some measurement Dimensions
class Quantity<D extends Dimensions> {
  final D dims;
  final num amount;

  const Quantity(this.dims, this.amount);

  Quantity<D> operator* (num n) => Quantity(this.dims, amount * n);
  Quantity<D> operator+ (Quantity<D> that) => Quantity(dims, amount+that.amount);

  bool operator== (Object that) {
    if (identical(that, this)) return true;
    if (that is Quantity &&
        that.runtimeType == this.runtimeType) {
      return dims == that.dims && amount == that.amount;
    }
    return false;
  }
  int get hashCode => dims.hashCode ^ amount.hashCode;
}


class Time extends Dimension {
  factory Time() => _instance;

  @override
  Map<Dimension, int> get elements => _dims;

  const Time._internal();

  static const _instance = Time._internal();
  static const _dims = {_instance: 1};

  static seconds(num n) => Quantity(_instance, 1);
  static minutes(num n) => Quantity(_instance, 60);
  static hours(num n) => Quantity(_instance, 60*60);
}


class Distance extends Dimension {
  factory Distance() => _instance;

  Map<Dimension, int> get elements => _dims;

  const Distance._internal();

  static const _instance = Distance._internal();
  static const _dims = {_instance: 1};

  static meters(num n) => Quantity(_instance, n);
  static kilometers([num n = 1]) => Quantity(_instance, 1000*n);
}

class Volume extends Dimension {
  factory Volume() => _instance;

  Map<Dimension, int> get elements => _dims;

  const Volume._internal();

  static const _instance = Volume._internal();
  static const _dims = {_instance: 1};

  static metersCubed(num n) => Quantity(_instance, n);
  static kilometersCubed(num n) => Quantity(_instance, 1000*1000*n);
}



class Mass extends Dimension {
  factory Mass() => _instance;

  Map<Dimension, int> get elements => _dims;

  const Mass._internal();

  static const _instance = Mass._internal();
  static const _dims = {_instance: 1};

  static micrograms(num n) => Quantity(_instance, n*0.000001);
  static milligrams(num n) => Quantity(_instance, n*0.001);
  static grams(num n) => Quantity(_instance, n);
  static kilograms(num n) => Quantity(_instance, n*1000);
}

class FractionByMass extends Dimension {
  factory FractionByMass() => _instance;

  Map<Dimension, int> get elements => _dims;

  const FractionByMass._internal();

  static const _instance = FractionByMass._internal();
  static const _dims = {_instance: 1};

  static gramsPerHectogram(num n) => Quantity(_instance, n*0.01);
  static gramsPerGram(num n) => Quantity(_instance, n);
}

class FractionByVolume extends Dimension {
  factory FractionByVolume() => _instance;

  Map<Dimension, int> get elements => _dims;

  const FractionByVolume._internal();

  static const _instance = FractionByVolume._internal();
  static const _dims = {_instance: 1};

  static litresPerLitre(num n) => Quantity(_instance, n);
}

class MolesByVolume extends Dimension {
  factory MolesByVolume() => _instance;

  Map<Dimension, int> get elements => _dims;

  const MolesByVolume._internal();

  static const _instance = MolesByVolume._internal();
  static const _dims = {_instance: 1};

  static molesPerLitre(num n) => Quantity(_instance, n);
  static millimolesPerDecilitre(num n) => Quantity(_instance, n*10*0.001);
}

class Rate extends Dimension {
  factory Rate() => _instance;

  Map<Dimension, int> get elements => _dims;

  const Rate._internal();

  static const _instance = Rate._internal();
  static const _dims = {_instance: 1};

  static perSecond(num n) => Quantity(_instance, n);
  static perMinute(num n) => Quantity(_instance, n/60);
}
