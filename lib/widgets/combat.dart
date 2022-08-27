import 'package:flutter/material.dart';

import '../models/content/combat_tag.dart';

class Combat extends StatelessWidget {
  final CombatTag tag;

  const Combat(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: [
        TextSpan(text: tag.enemy),
        TextSpan(text: tag.combatskill.toString()),
        TextSpan(text: tag.endurance.toString()),
      ],
    ));
  }
}
