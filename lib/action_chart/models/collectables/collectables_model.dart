import 'package:collection/collection.dart';

import '../../../types/types.dart';
import 'collectable_item_model.dart';

/// A generic container for tracking things like backpack items an weapons.
class CollectablesModel {
  final List<CollectableItemModel> items = [];

  CollectablesModel();

  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(String key, int maxElements) {
    items.add(CollectableItemModel(key, maxElements));
  }

  CollectableItemModel? get(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  void remove(String key) {
    items.removeWhere((item) => item.key == key);
  }
}
