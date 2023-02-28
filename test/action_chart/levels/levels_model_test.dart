import 'package:aonic/action_chart/models/levels/level_item_model.dart';
import 'package:aonic/action_chart/models/levels/levels_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'level_item_model_test.dart';

final levelsJson = {"items": []};

void main() {
  group('Action Chart Model - Levels()', () {
    late LevelsModel levels;

    setUp(() {
      levels = LevelsModel();
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

      expect(item, isA<LevelItemModel>());
      expect(item?.toJson(), equals(levelItemJson));
    });

    test('get() returns null if no item with key is found', () {
      levels.add(levelItemKey, levelItemLevel);
      final item = levels.get('a-nonexistant-key');

      expect(item, isNull);
    });
  });
}
