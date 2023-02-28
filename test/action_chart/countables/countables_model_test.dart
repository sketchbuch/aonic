import 'package:aonic/action_chart/models/countables/countable_item_model.dart';
import 'package:aonic/action_chart/models/countables/countables_model.dart';
import 'package:test/test.dart';

import 'countable_item_model_test.dart';

final countablesJson = {"items": []};

void main() {
  group('Action Chart Model - Countables()', () {
    late CountablesModel countables;

    setUp(() {
      countables = CountablesModel();
    });

    test('Returns expected JSON', () {
      expect(countables.toJson(), equals(countablesJson));
    });

    test('Returns expected string', () {
      expect(countables.toString(), countablesJson.toString());
    });

    test('add() creates expected item', () {
      expect(countables.items, isEmpty);
      countables.add(countableItemKey, countableItemValue);
      expect(countables.items, hasLength(1));
      expect(countables.items.first.toJson(), equals(countableItemJson));
    });

    test('add() with optional args creates expected item', () {
      expect(countables.items, isEmpty);
      countables.add(
        countableItemKey,
        countableItemValue,
        maxValue: countableItemMaxValue,
        minValue: countableItemMinValue,
      );
      expect(countables.items, hasLength(1));
      expect(countables.items.first.toJson(), equals(countableOptionalJson));
    });

    test('remove() deletes an item', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.items, hasLength(1));

      countables.remove(countableItemKey);
      expect(countables.items, isEmpty);
    });

    test('get() returns the item', () {
      countables.add(countableItemKey, countableItemValue);
      final item = countables.get(countableItemKey);

      expect(item, isA<CountableItemModel>());
      expect(item?.toJson(), equals(countableItemJson));
    });

    test('get() returns null if no item with key is found', () {
      countables.add(countableItemKey, countableItemValue);
      final item = countables.get('a-nonexistant-key');

      expect(item, isNull);
    });

    test('getValue() returns item value', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.getValue(countableItemKey), countableItemValue);
    });

    test('getValue() returns null if no item with key is found', () {
      countables.add(countableItemKey, countableItemValue);
      expect(countables.getValue('a-nonexistant-key'), isNull);
    });
  });
}
