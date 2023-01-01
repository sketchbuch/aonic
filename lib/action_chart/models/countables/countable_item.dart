import '../../../types/types.dart';
import '../../constants.dart';

class CountableItem {
  final String key;
  int max;
  int min;
  int value;

  CountableItem(this.key, this.value, {this.max = countableDefaultMax, this.min = countableDefaultMin});

  Json toJson() => {
        "key": key,
        "max": max,
        "min": min,
        "value": value,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void decrease() {
    if (value > min) {
      value = value -= 1;
    }
  }

  void increase() {
    if (value < max) {
      value = value += 1;
    }
  }

  void maximise() {
    value = max;
  }

  void minimise() {
    value = min;
  }

  void set(int newalue) {
    if (newalue >= min && newalue <= max) {
      value = newalue;
    }
  }
}
