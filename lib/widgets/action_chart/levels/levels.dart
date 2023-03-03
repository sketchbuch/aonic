import 'package:flutter/material.dart';
import '../../../i18n/_generated_/translations.g.dart';

import '../../../action_chart/models/levels/levels_model.dart';
import '../../typography/headline_text.dart';

class Levels extends StatelessWidget {
  final LevelsModel levels;

  const Levels(this.levels, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeadlineText(
          'Levels',
          level: 2,
        ),
        Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
              children: [
                Text('Level'),
                Text('Discipline'),
                Text('Rank'),
              ],
            ),
            ...levels.items.map((level) {
              final levelNumber = level.level - 1;
              String levelLabel;

              try {
                levelLabel = t.actionChart.levels.labels[levelNumber];
              } on RangeError catch (_) {
                levelLabel = '${level.key} - Unknown Level: $levelNumber';
              }

              return TableRow(
                children: [
                  Text(level.level.toString()),
                  const Text(''),
                  Text(levelLabel),
                ],
              );
            })
          ],
        )
      ],
    );
  }
}
