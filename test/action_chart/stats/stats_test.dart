import 'package:aonic/action_chart/models/stats/stat_item.dart';
import 'package:aonic/action_chart/models/stats/stats.dart';
import 'package:test/test.dart';

import 'stat_item_test.dart';

final statsJson = {"items": []};

void main() {
  group('Action Chart Model - Stats()', () {
    late Stats stats;

    setUp(() {
      stats = Stats();
    });

    test('Returns expected JSON', () {
      expect(stats.toJson(), equals(statsJson));
    });

    test('Returns expected string', () {
      expect(stats.toString(), statsJson.toString());
    });

    test('add() creates expected item', () {
      expect(stats.items, isEmpty);
      stats.add(statItemKey, statItemValue);
      expect(stats.items, hasLength(1));
      expect(stats.items.first.toJson(), equals(statItemJson));
    });

    test('add() with optional args creates expected item', () {
      expect(stats.items, isEmpty);
      stats.add(
        statItemKey,
        statItemValue,
        maxValue: statMaxValue,
        minValue: statMinValue,
      );
      expect(stats.items, hasLength(1));
      expect(stats.items.first.toJson(), equals(statItemOptionalJson));
    });

    test('remove() deletes an item', () {
      stats.add(statItemKey, statItemValue);
      expect(stats.items, hasLength(1));

      stats.remove(statItemKey);
      expect(stats.items, isEmpty);
    });

    test('get() returns the item', () {
      stats.add(statItemKey, statItemValue);
      final item = stats.get(statItemKey);

      expect(item, isA<StatItem>());
      expect(item?.toJson(), equals(statItemJson));
    });

    test('get() returns null if no item with key is found', () {
      stats.add(statItemKey, statItemValue);
      final item = stats.get('a-nonexistant-key');

      expect(item, isNull);
    });

    test('getValue() returns item value', () {
      stats.add(statItemKey, statItemValue);
      expect(stats.getValue(statItemKey), statItemValue);
    });

    test('getValue() returns null if no item with key is found', () {
      stats.add(statItemKey, statItemValue);
      expect(stats.getValue('a-nonexistant-key'), isNull);
    });
  });
}
