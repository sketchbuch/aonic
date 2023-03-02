import 'package:flutter/material.dart';

class ChartBox extends StatelessWidget {
  final String label;
  final String value;
  final List<String> description;

  const ChartBox({
    Key? key,
    required this.label,
    required this.value,
    this.description = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Container(
          height: 80.0,
          padding: const EdgeInsets.all(8),
          width: 160.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.orangeAccent, width: 4)),
          child: Text(value),
        ),
      ],
    );
  }
}
