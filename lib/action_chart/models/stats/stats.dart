import 'package:aonic/action_chart/models/stats/stat.dart';
import 'package:collection/collection.dart';

import '../../../types/types.dart';
import '../../ac_constants.dart';

/// A generic container for tracking values like combat skill, endurance pointes, etc.
class Stats {
  final List<Stat> stats = [];

  Stats();

  Json toJson() => {
        'stats': stats.map((stat) => stat.toJson()).toList(),
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
    stats.add(Stat(key, value, maxValue: maxValue, minValue: minValue));
  }

  Stat? get(String key) {
    return stats.firstWhereOrNull((stat) => stat.key == key);
  }

  int? getValue(String key) {
    return get(key)?.value;
  }

  void remove(String key) {
    stats.removeWhere((stat) => stat.key == key);
  }
}
