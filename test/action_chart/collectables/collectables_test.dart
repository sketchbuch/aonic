import 'package:aonic/action_chart/models/collectables/collectable_item.dart';
import 'package:aonic/action_chart/models/collectables/collectables.dart';
import 'package:flutter_test/flutter_test.dart';

import 'collectable_item_test.dart';

final collectablesJson = {'items': []};

void main() {
  group('Action Chart Model - Collectables()', () {
    late Collectables collectables;

    setUp(() {
      collectables = Collectables();
    });

    test('Returns expected JSON', () {
      expect(collectables.toJson(), equals(collectablesJson));
    });

    test('Returns expected string', () {
      expect(collectables.toString(), collectablesJson.toString());
    });

    test('add() creates expected item', () {
      expect(collectables.items, isEmpty);
      collectables.add(collectableItemKey, collectableItemMaxElements);
      expect(collectables.items, hasLength(1));
      expect(collectables.items.first.toJson(), equals(collectableItemJson));
    });

    test('remove() deletes an item', () {
      collectables.add(collectableItemKey, collectableItemMaxElements);
      expect(collectables.items, hasLength(1));

      collectables.remove(collectableItemKey);
      expect(collectables.items, isEmpty);
    });

    test('get() returns the item', () {
      collectables.add(collectableItemKey, collectableItemMaxElements);
      final item = collectables.get(collectableItemKey);

      expect(item, isA<CollectableItem>());
      expect(item?.toJson(), equals(collectableItemJson));
    });

    test('get() returns null if no item with key is found', () {
      collectables.add(collectableItemKey, collectableItemMaxElements);
      final item = collectables.get('a-nonexistant-key');

      expect(item, isNull);
    });
  });
}
