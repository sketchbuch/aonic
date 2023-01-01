import 'package:collection/collection.dart';

import '../../../types/types.dart';
import 'level_item.dart';

/// A generic container for things like experience levels.
class Levels {
  final List<LevelItem> items = [];

  Levels();

  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(String key, int level) {
    items.add(LevelItem(key, level));
  }

  LevelItem? get(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  void remove(String key) {
    items.removeWhere((item) => item.key == key);
  }
}
