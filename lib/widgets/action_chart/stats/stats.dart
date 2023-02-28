import 'package:flutter/material.dart';

import '../../../action_chart/models/stats/stats_model.dart';

class Stats extends StatelessWidget {
  final StatsModel data;

  const Stats(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Stats');
  }
}
