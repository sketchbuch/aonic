import 'package:flutter/services.dart';

class LimitRange extends TextInputFormatter {
  final bool fallbackToOldValue;
  final int maxRange;
  final int minRange;

  LimitRange(this.minRange, this.maxRange, [this.fallbackToOldValue = true])
      : assert(
          minRange < maxRange,
        );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    var value = int.parse(newValue.text);

    if (value < minRange) {
      return fallbackToOldValue ? oldValue : TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      return fallbackToOldValue ? oldValue : TextEditingValue(text: maxRange.toString());
    }

    return newValue;
  }
}
