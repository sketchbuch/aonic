import 'package:flutter/material.dart';

import '../../action_chart/models/action_chart_model.dart';
import 'stats/stats.dart';

class ActionChart extends StatelessWidget {
  final ActionChartModel data;

  const ActionChart(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stats(data.stats),
      ],
    );
  }
}
