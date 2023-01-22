import 'package:flutter/material.dart';

class ActionChart extends StatelessWidget {
  final bool _show;

  const ActionChart(this._show, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _show ? const Text('AC Widget') : const Text('HIDDEN');
  }
}
