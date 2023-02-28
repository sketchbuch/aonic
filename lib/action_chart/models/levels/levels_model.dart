import 'package:collection/collection.dart';

import '../../../types/types.dart';
import 'level_item_model.dart';

/// A generic container for things like experience levels.
class LevelsModel {
  final List<LevelItemModel> items = [];

  LevelsModel();

  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(String key, int level) {
    items.add(LevelItemModel(key, level));
  }

  LevelItemModel? get(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  void remove(String key) {
    items.removeWhere((item) => item.key == key);
  }
}
