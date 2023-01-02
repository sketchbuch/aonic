import 'package:aonic/action_chart/models/stats/stat_item.dart';
import 'package:collection/collection.dart';

import '../../../types/types.dart';
import '../../ac_constants.dart';

/// A generic container for tracking values like combat skill, endurance pointes, etc.
class Stats {
  final List<StatItem> items = [];

  Stats();

  Json toJson() => {
        'items': items.map((stat) => stat.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(
    String key,
    int value, {
    int maxValue = statDefaultMax,
    int minValue = statDefaultMin,
  }) {
    items.add(StatItem(key, value, maxValue: maxValue, minValue: minValue));
  }

  StatItem? get(String key) {
    return items.firstWhereOrNull((stat) => stat.key == key);
  }

  int? getValue(String key) {
    return get(key)?.value;
  }

  void remove(String key) {
    items.removeWhere((stat) => stat.key == key);
  }
}
