import 'package:flutter/material.dart';

import '../models/content/choice_tag.dart';
import '../models/content/tag.dart';

class Choice extends StatelessWidget {
  final Tag tag;

  const Choice(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceTag = tag as ChoiceTag;

    return Row(children: choiceTag.texts.map((text) => Text(text.text)).toList());
  }
}
