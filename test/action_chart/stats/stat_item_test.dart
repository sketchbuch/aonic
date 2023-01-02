import 'package:aonic/action_chart/ac_constants.dart';
import 'package:aonic/action_chart/models/stats/stat_item.dart';
import 'package:flutter_test/flutter_test.dart';

const statItemKey = 'skill';
const statItemValue = 20;
final statItemJson = {
  "key": statItemKey,
  "maxValue": statDefaultMax,
  "minValue": statDefaultMin,
  "value": statItemValue,
};

const statMaxValue = 30;
const statMinValue = 2;
final statItemOptionalJson = {
  "key": statItemKey,
  "maxValue": statMaxValue,
  "minValue": statMinValue,
  "value": statItemValue,
};

void main() {
  group('Action Chart Model - Stat()', () {
    late StatItem statItem;

    setUp(() {
      statItem = StatItem(statItemKey, statItemValue);
    });

    test('Returns expected JSON', () {
      expect(statItem.toJson(), equals(statItemJson));
    });

    test('Returns expected string', () {
      expect(statItem.toString(), statItemJson.toString());
    });

    group('Optional args', () {
      late StatItem statItem;

      setUp(() {
        statItem = StatItem(
          statItemKey,
          statItemValue,
          minValue: statMinValue,
          maxValue: statMaxValue,
        );
      });

      test('Returns expected JSON', () {
        expect(statItem.toJson(), equals(statItemOptionalJson));
      });
      test('Returns expected string', () {
        expect(statItem.toString(), statItemOptionalJson.toString());
      });
    });

    test('decrease() changes value as expected', () {
      expect(statItem.value, statItemValue);

      statItem.decrease();
      expect(statItem.value, statItemValue - 1);

      statItem.decrease(amount: 2);
      expect(statItem.value, statItemValue - 3);
    });

    test('increase() changes value as expected', () {
      expect(statItem.value, statItemValue);

      statItem.increase();
      expect(statItem.value, statItemValue + 1);

      statItem.increase(amount: 2);
      expect(statItem.value, statItemValue + 3);
    });

    test('maximise() sets value to max', () {
      expect(statItem.value, statItemValue);

      statItem.maximise();
      expect(statItem.value, statDefaultMax);
    });

    test('minimise() sets value to min', () {
      expect(statItem.value, statItemValue);

      statItem.minimise();
      expect(statItem.value, statDefaultMin);
    });

    test('set() sets value to min if newValue is less than min', () {
      expect(statItem.value, statItemValue);

      statItem.set(statDefaultMin - 1);
      expect(statItem.value, statDefaultMin);
    });

    test('set() sets value to max if newValue is greater than max', () {
      expect(statItem.value, statItemValue);

      statItem.set(statDefaultMax + 1);
      expect(statItem.value, statDefaultMax);
    });

    test('set() sets value to new value if within bounds', () {
      expect(statItem.value, statItemValue);

      statItem.set(15);
      expect(statItem.value, 15);
    });
  });
}
