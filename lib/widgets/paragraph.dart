import 'package:flutter/material.dart';

import '../models/content/paragraph_tag.dart';

class Paragraph extends StatelessWidget {
  final ParagraphTag tag;

  const Paragraph(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: tag.texts.map((text) => TextSpan(text: text.text)).toList()),
    );
  }
}
