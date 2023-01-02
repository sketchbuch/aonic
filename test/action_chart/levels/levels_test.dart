import 'package:aonic/action_chart/models/levels/level_item.dart';
import 'package:aonic/action_chart/models/levels/levels.dart';
import 'package:flutter_test/flutter_test.dart';

import 'level_item_test.dart';

final levelsJson = {"items": []};

void main() {
  group('Action Chart Model - Levels()', () {
    late Levels levels;

    setUp(() {
      levels = Levels();
    });

    test('Returns expected JSON', () {
      expect(levels.toJson(), equals(levelsJson));
    });

    test('Returns expected string', () {
      expect(levels.toString(), levelsJson.toString());
    });

    test('add() creates expected item', () {
      expect(levels.items, isEmpty);
      levels.add(levelItemKey, levelItemLevel);
      expect(levels.items, hasLength(1));
      expect(levels.items.first.toJson(), equals(levelItemJson));
    });

    test('remove() deletes an item', () {
      levels.add(levelItemKey, levelItemLevel);
      expect(levels.items, hasLength(1));

      levels.remove(levelItemKey);
      expect(levels.items, isEmpty);
    });

    test('get() returns the item', () {
      levels.add(levelItemKey, levelItemLevel);
      final item = levels.get(levelItemKey);

      expect(item, isA<LevelItem>());
      expect(item?.toJson(), equals(levelItemJson));
    });

    test('get() returns null if no item with key is found', () {
      levels.add(levelItemKey, levelItemLevel);
      final item = levels.get('a-nonexistant-key');

      expect(item, isNull);
    });
  });
}
