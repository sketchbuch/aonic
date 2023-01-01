import 'package:collection/collection.dart';

import '../../../types/types.dart';
import 'collectable_item.dart';

/// A generic container for tracking things like backpack items an weapons.
class Collectables {
  final List<CollectableItem> items = [];

  Collectables();

  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(String key, int maxElements) {
    items.add(CollectableItem(key, maxElements));
  }

  CollectableItem? get(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  void remove(String key) {
    items.removeWhere((item) => item.key == key);
  }
}
