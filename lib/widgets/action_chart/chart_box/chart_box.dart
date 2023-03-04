import 'package:flutter/material.dart';

import '../../typography/headline_text.dart';

const chartBoxBorderWidth = 2.0;
const chartBoxHeight = 80.0;
const chartBoxWidth = 160.0;

class ChartBox extends StatelessWidget {
  final String label;
  final int? labelLevel;
  final String value;
  final List<String> description;

  const ChartBox({
    Key? key,
    required this.label,
    required this.value,
    this.description = const [],
    this.labelLevel = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineText(label, level: 2),
        Container(
          height: chartBoxHeight,
          padding: const EdgeInsets.all(8),
          width: chartBoxWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orangeAccent,
              width: chartBoxBorderWidth,
            ),
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
