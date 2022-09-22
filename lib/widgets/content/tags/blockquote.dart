import 'package:flutter/material.dart';

import '../../../models/book/content/blockquote.dart';
import '../../mixins/content_renderer.dart';
import '../content_container.dart';

class Blockquote extends StatelessWidget with ContentRenderer {
  final BlockquoteTag tag;

  const Blockquote(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
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
