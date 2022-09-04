import 'package:flutter/material.dart';

import '../i18n/_generated_/translations.g.dart';
import '../models/book/content/combat_tag.dart';
import 'content_renderer.dart';

class Combat extends StatelessWidget with ContentRenderer {
  final CombatTag tag;
  final trans = t.numbered; // get translation

  Combat(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wrapContent(
      RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: 8.0), child: Text('${tag.enemy}:')),
            ),
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: 8.0), child: Text(trans.combatSkill)),
            ),
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: 16.0), child: Text(tag.combatskill.toString())),
            ),
            WidgetSpan(
              child: Padding(padding: const EdgeInsets.only(right: 8.0), child: Text(trans.endurance)),
            ),
            TextSpan(text: tag.endurance.toString()),
          ],
        ),
      ),
    );
  }
}
