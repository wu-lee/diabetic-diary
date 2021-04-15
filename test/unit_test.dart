import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';

const meters = Distance.meters;
const kilometers = Distance.kilometers;

void main() {
  group('Quantity addition', () {
    test('Adding meters', () {
      expect(meters(1), meters(1));
    });
    test('Adding meters and kilometers', () {
      expect((meters(1) + kilometers(1)).amount, meters(1001).amount);
    });
  });
}
