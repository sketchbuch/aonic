import 'package:flutter/material.dart';

import '../../../action_chart/models/levels/levels_model.dart';
import '../../../i18n/_generated_/translations.g.dart';
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
            TableRow(
              children: [
                Text('Level', style: Theme.of(context).textTheme.bodyText2),
                Text('Discipline', style: Theme.of(context).textTheme.bodyText2),
                Text('Rank', style: Theme.of(context).textTheme.bodyText2),
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
                  Text(level.level.toString(), style: Theme.of(context).textTheme.bodyText2),
                  const Text(''),
                  Text(levelLabel, style: Theme.of(context).textTheme.bodyText2),
                ],
              );
            })
          ],
        )
      ],
    );
  }
}
