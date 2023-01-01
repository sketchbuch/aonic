import 'package:aonic/action_chart/ac_constants.dart';
import 'package:aonic/action_chart/models/countables/countable_item.dart';
import 'package:flutter_test/flutter_test.dart';

const countableItemKey = 'money';
const countableItemValue = 10;

final countableItem = CountableItem(countableItemKey, countableItemValue);
final countableItemJson = {
  "key": countableItemKey,
  "maxValue": countableDefaultMax,
  "minValue": countableDefaultMin,
  "value": countableItemValue,
};

const countableItemMaxValue = 20;
const countableItemMinValue = 2;

final countableOptionalItem = CountableItem(
  countableItemKey,
  countableItemValue,
  minValue: countableItemMinValue,
  maxValue: countableItemMaxValue,
);
final countableOptionalJson = {
  "key": countableItemKey,
  "maxValue": countableItemMaxValue,
  "minValue": countableItemMinValue,
  "value": countableItemValue,
};

void main() {
  group('Action Chart Model - CountableItem()', () {
    test('Returns expected JSON', () {
      expect(countableItem.toJson(), equals(countableItemJson));
    });

    test('Returns expected string', () {
      expect(countableItem.toString(), equals(countableItemJson.toString()));
    });

    group('Optional args', () {
      test('Returns expected JSON', () {
        expect(countableOptionalItem.toJson(), equals(countableOptionalJson));
      });
      test('Returns expected string', () {
        expect(countableOptionalItem.toString(), equals(countableOptionalJson.toString()));
      });
    });
  });
}
