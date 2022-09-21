import 'package:flutter/material.dart';

import '../../models/book/content/blockquote.dart';
import '../../utils/rendering/text_style.dart';
import '../content.dart';

class Blockquote extends StatelessWidget {
  final BlockquoteTag tag;

  const Blockquote(this.tag, {Key? key}) : super(key: key);

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
            }).toList()),
      ),
    );
  }
}
