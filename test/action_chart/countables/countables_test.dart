import 'package:aonic/action_chart/models/countables/countable_item.dart';
import 'package:aonic/action_chart/models/countables/countables.dart';
import 'package:test/test.dart';

import 'countable_item_test.dart';

final countablesJson = {"items": []};

void main() {
  group('Action Chart Model - Countables()', () {
    late Countables countables;

    setUp(() {
      countables = Countables();
    });

    test('Returns expected JSON', () {
      expect(countables.toJson(), equals(countablesJson));
    });

    test('Returns expected string', () {
      expect(countables.toString(), equals(countablesJson.toString()));
    });

    test('add() creates expected item', () {
      expect(countables.items.length, equals(0));
      countables.add(countableItemKey, countableItemValue);
      expect(countables.items.length, equals(1));
      expect(countables.items.first.toJson(), equals(countableItemJson));
    });

    test('add() with optional args creates expected item', () {
      expect(countables.items.length, equals(0));
      countables.add(
        countableItemKey,
        countableItemValue,
        maxValue: countableItemMaxValue,
        minValue: countableItemMinValue,
      );
      expect(countables.items.length, equals(1));
      expect(countables.items.first.toJson(), equals(countableOptionalJson));
    });

    test('remove() deletes an item', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.items.length, equals(1));

      countables.remove(countableItemKey);
      expect(countables.items.length, equals(0));
    });

    test('get() returns the item', () {
      countables.add(countableItemKey, countableItemValue);
      final item = countables.get(countableItemKey);

      expect(item is CountableItem, equals(true));
      expect(item?.toJson(), equals(countableItemJson));
    });

    test('get() returns null if no item with key is found', () {
      countables.add(countableItemKey, countableItemValue);
      final item = countables.get('a-nonexistant-key');

      expect(item, equals(null));
    });

    test('getValue() returns item value', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.getValue(countableItemKey), equals(countableItemValue));
    });

    test('getValue() returns null if no item with key is found', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.getValue('a-nonexistant-key'), equals(null));
    });
  });
}
