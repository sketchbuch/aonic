import 'package:flutter/material.dart';

import '../../action_chart/models/action_chart_model.dart';
import 'stats/stats.dart';

class ActionChart extends StatelessWidget {
  final ActionChartModel actionChart;

  const ActionChart(this.actionChart, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (actionChart.stats.items.isNotEmpty) Stats(actionChart.stats),
      ],
    );
  }
}
