import 'package:flutter/material.dart';

import '../../models/book/content/paragraph_tag.dart';
import '../../utils/rendering/text_style.dart';
import '../content.dart';

class Paragraph extends StatelessWidget {
  final ParagraphTag tag;

  const Paragraph(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: tag.texts.map((text) {
            final style = getTextElementStyle(text);
            final weight = getTextElementWeight(text);

            return TextSpan(text: text.text, style: TextStyle(fontWeight: weight, fontStyle: style));
          }).toList(),
        ),
      ),
    );
  }
}
