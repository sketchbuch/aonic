import 'package:aonic/action_chart/models/levels/level_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

const levelItemKey = 'acolyte';
const levelItemLevel = 4;
const levelItemJson = {
  "key": levelItemKey,
  "level": levelItemLevel,
};

void main() {
  group('Action Chart Model - LevelItem()', () {
    late LevelItemModel levelItem;

    setUp(() {
      levelItem = LevelItemModel(levelItemKey, levelItemLevel);
    });

    test('Returns expected JSON', () {
      expect(levelItem.toJson(), equals(levelItemJson));
    });

    test('Returns expected string', () {
      expect(levelItem.toString(), levelItemJson.toString());
    });
  });
}
