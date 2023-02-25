import 'package:flutter/material.dart';

import 'stats/stats.dart';

class ActionChart extends StatelessWidget {
  const ActionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Stats()],
    );
  }
}
