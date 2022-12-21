import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/content/combat_tag.dart';
import '../../layout/content_container.dart';

class Combat extends StatelessWidget {
  final CombatTag tag;
  final trans = t.numbered; // get translation

  Combat(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: paddingNormal), child: Text('${tag.enemy}:')),
            ),
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: paddingNormal), child: Text(trans.combatSkill)),
            ),
            WidgetSpan(
              child:
                  Padding(padding: const EdgeInsets.only(right: paddingLarge), child: Text(tag.combatskill.toString())),
            ),
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: paddingNormal), child: Text(trans.endurance)),
            ),
            TextSpan(text: tag.endurance.toString()),
          ],
        ),
      ),
    );
  }
}
