import 'package:aonic/action_chart/models/stats/stat_item_model.dart';
import 'package:collection/collection.dart';

import '../../../types/types.dart';
import '../../ac_constants.dart';

/// A generic container for attributes like combat skill, endurance pointes, etc.
class StatsModel {
  final List<StatItemModel> items = [];

  StatsModel();

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
    items
        .add(StatItemModel(key, value, maxValue: maxValue, minValue: minValue));
  }

  StatItemModel? get(String key) {
    return items.firstWhereOrNull((stat) => stat.key == key);
  }

  int? getValue(String key) {
    return get(key)?.value;
  }

  void remove(String key) {
    items.removeWhere((stat) => stat.key == key);
  }
}
