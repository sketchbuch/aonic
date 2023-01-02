import 'package:collection/collection.dart';

import '../../../types/types.dart';
import '../../ac_constants.dart';
import 'countable_item.dart';

/// A generic container for tracking numeric values that can increase/decerase, like gold crowns or meals..
class Countables {
  final List<CountableItem> items = [];

  Countables();

  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(
    String key,
    int value, {
    int maxValue = countableDefaultMax,
    int minValue = countableDefaultMin,
  }) {
    items.add(CountableItem(key, value, maxValue: maxValue, minValue: minValue));
  }

  CountableItem? get(String key) {
    return items.firstWhereOrNull((item) => item.key == key);
  }

  int? getValue(String key) {
    return get(key)?.value;
  }

  void remove(String key) {
    items.removeWhere((item) => item.key == key);
  }
}
