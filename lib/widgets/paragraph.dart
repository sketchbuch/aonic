import 'package:flutter/material.dart';

import '../models/content/paragraph_tag.dart';
import 'content_renderer.dart';

class Paragraph extends StatelessWidget with ContentRenderer {
  final ParagraphTag tag;

  const Paragraph(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wrapContent(
      RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: tag.texts.map((text) {
              final style = getTextElementStyle(text);
              final weight = getTextElementWeight(text);

              return TextSpan(text: text.text, style: TextStyle(fontWeight: weight, fontStyle: style));
            }).toList()),
      ),
    );
  }
}
