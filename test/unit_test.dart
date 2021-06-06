import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';

const Distance = Dimensions(id: #Distance, units: {#m: 1, #km: 1000});
final meters = Distance.units(#m);
final  kilometers = Distance.units(#km);

void main() {
  group('Quantity addition', () {
    test('Equating meters', () {
      expect(meters.of(1), meters.of(1));
    });
/*    test('Adding meters and kilometers', () {
      expect((meters.of(1) + kilometers.of(1)).amount, meters.of(1001).amount);
    });*/
  });
}
