import 'dart:math';

import '../../../types/types.dart';
import '../../ac_constants.dart';

class StatItem {
  final String key;
  int maxValue;
  int minValue;
  int value;

  StatItem(this.key, this.value, {this.maxValue = statDefaultMax, this.minValue = statDefaultMin});

  Json toJson() => {
        "key": key,
        "maxValue": maxValue,
        "minValue": minValue,
        "value": value,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void decrease({int amount = 1}) {
    value = max(value - amount, minValue);
  }

  void increase({int amount = 1}) {
    value = min(value + amount, maxValue);
  }

  void maximise() {
    value = maxValue;
  }

  void minimise() {
    value = minValue;
  }

  void set(int newValue) {
    if (newValue < minValue) {
      value = minValue;
    } else if (newValue > maxValue) {
      value = maxValue;
    } else {
      value = newValue;
    }
  }
}
