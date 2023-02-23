import 'package:flutter/material.dart';

import 'stats/stats.dart';

class ActionChart extends StatelessWidget {
  final bool _show;

  const ActionChart(this._show, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _show ? const Stats() : const Text('HIDDEN');
  }
}
