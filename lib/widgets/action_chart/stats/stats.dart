import 'package:flutter/material.dart';

import '../../../action_chart/models/stats/stats_model.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../utils/i18n/split_translation.dart';
import '../chart_box/chart_box.dart';

class Stats extends StatelessWidget {
  final StatsModel stats;

  const Stats(this.stats, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stats.items.map((stat) {
        return ChartBox(
          description: splitTranslation(t['actionChart.stats.${stat.key}.description']),
          label: t['actionChart.stats.${stat.key}.label'],
          value: stat.value.toString(),
        );
      }).toList(),
    );
  }
}
