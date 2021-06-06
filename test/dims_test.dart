import 'package:test/test.dart';
import 'package:diabetic_diary/unit.dart';

const meters = Distance.meters;
const kilometers = Distance.kilometers;

void main() {
  group('Dimensions index', () {
    test('List dimensions', () {
      expect(Dimensions.index, {1:1});
    });
  });
}
