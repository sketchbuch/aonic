import 'package:flutter/material.dart';

import '../models/content/choice_tag.dart';

class Choice extends StatelessWidget {
  final ChoiceTag tag;

  const Choice(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: tag.texts.map((text) => TextSpan(text: text.text)).toList()),
    );
  }
}
