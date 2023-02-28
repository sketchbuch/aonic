import 'package:aonic/action_chart/ac_constants.dart';
import 'package:aonic/action_chart/models/countables/countable_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

const countableItemKey = 'money';
const countableItemValue = 10;
final countableItemJson = {
  "key": countableItemKey,
  "maxValue": countableDefaultMax,
  "minValue": countableDefaultMin,
  "value": countableItemValue,
};

const countableItemMaxValue = 20;
const countableItemMinValue = 2;
final countableOptionalJson = {
  "key": countableItemKey,
  "maxValue": countableItemMaxValue,
  "minValue": countableItemMinValue,
  "value": countableItemValue,
};

void main() {
  group('Action Chart Model - CountableItem()', () {
    late CountableItemModel countableItem;

    setUp(() {
      countableItem = CountableItemModel(countableItemKey, countableItemValue);
    });

    test('Returns expected JSON', () {
      expect(countableItem.toJson(), equals(countableItemJson));
    });

    test('Returns expected string', () {
      expect(countableItem.toString(), countableItemJson.toString());
    });

    group('Optional args', () {
      late CountableItemModel countableItem;

      setUp(() {
        countableItem = CountableItemModel(
          countableItemKey,
          countableItemValue,
          minValue: countableItemMinValue,
          maxValue: countableItemMaxValue,
        );
      });

      test('Returns expected JSON', () {
        expect(countableItem.toJson(), equals(countableOptionalJson));
      });
      test('Returns expected string', () {
        expect(countableItem.toString(), countableOptionalJson.toString());
      });
    });

    test('decrease() changes value as expected', () {
      expect(countableItem.value, countableItemValue);

      countableItem.decrease();
      expect(countableItem.value, countableItemValue - 1);

      countableItem.decrease(amount: 2);
      expect(countableItem.value, countableItemValue - 3);
    });

    test('increase() changes value as expected', () {
      expect(countableItem.value, countableItemValue);

      countableItem.increase();
      expect(countableItem.value, countableItemValue + 1);

      countableItem.increase(amount: 2);
      expect(countableItem.value, countableItemValue + 3);
    });

    test('maximise() sets value to max', () {
      expect(countableItem.value, countableItemValue);

      countableItem.maximise();
      expect(countableItem.value, countableDefaultMax);
    });

    test('minimise() sets value to min', () {
      expect(countableItem.value, countableItemValue);

      countableItem.minimise();
      expect(countableItem.value, countableDefaultMin);
    });

    test('set() sets value to min if newValue is less than min', () {
      expect(countableItem.value, countableItemValue);

      countableItem.set(countableDefaultMin - 1);
      expect(countableItem.value, countableDefaultMin);
    });

    test('set() sets value to max if newValue is greater than max', () {
      expect(countableItem.value, countableItemValue);

      countableItem.set(countableDefaultMax + 1);
      expect(countableItem.value, countableDefaultMax);
    });

    test('set() sets value to new value if within bounds', () {
      expect(countableItem.value, countableItemValue);

      countableItem.set(15);
      expect(countableItem.value, 15);
    });
  });
}
