import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';

import '../../models/book/content/paragraph_tag.dart';
import '../content.dart';
import '../content_renderer.dart';

class Paragraph extends StatelessWidget with ContentRenderer {
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
            GestureRecognizer? recognizer;

            if (text.displayType == DisplayType.link) {
              recognizer = TapGestureRecognizer()
                ..onTap = () {
                  return print('### Tap Here onTap ${text.attrs['href'] ?? text.attrs['idref'] ?? 'No link'}');
                };
            }

            return TextSpan(
              text: text.text,
              recognizer: recognizer,
              style: TextStyle(fontWeight: weight, fontStyle: style),
            );
          }).toList(),
        ),
      ),
    );
  }
}
