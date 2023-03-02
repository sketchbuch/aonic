import 'package:flutter/material.dart';

class ChartBox extends StatelessWidget {
  final String label;

  const ChartBox({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(label)],
    );
  }
}
