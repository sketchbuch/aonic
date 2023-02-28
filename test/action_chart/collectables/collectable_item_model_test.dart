import 'package:aonic/action_chart/models/collectables/collectable_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'collectable_element_model_test.dart';

const collectableItemKey = 'weapons';
const collectableItemMaxElements = 2;
final collectableItemJson = {
  'elements': [],
  'key': collectableItemKey,
  'maxElements': collectableItemMaxElements,
};

void main() {
  group('Action Chart Model - CollectableItem()', () {
    late CollectableItemModel collectableItem;

    setUp(() {
      collectableItem =
          CollectableItemModel(collectableItemKey, collectableItemMaxElements);
    });

    test('Returns expected JSON', () {
      expect(collectableItem.toJson(), equals(collectableItemJson));
    });

    test('Returns expected string', () {
      expect(collectableItem.toString(), collectableItemJson.toString());
    });

    test('add() creates expected element', () {
      expect(collectableItem.elements, isEmpty);
      collectableItem.add(
        collectableElementKey,
        collectableElementName,
        collectableElementDescription,
      );
      expect(collectableItem.elements, hasLength(1));
      expect(collectableItem.elements.first.toJson(),
          equals(collectableElementJson));
    });

    test('remove() deletes an element', () {
      collectableItem.add(
        collectableElementKey,
        collectableElementName,
        collectableElementDescription,
      );
      expect(collectableItem.elements, hasLength(1));

      collectableItem.remove(collectableElementKey);
      expect(collectableItem.elements, isEmpty);
    });
  });
}
