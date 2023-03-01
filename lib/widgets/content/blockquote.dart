import 'package:flutter/material.dart';

import '../../models/book/content/blockquote_model.dart';
import '../../constants/layout.dart';
import '../layout/content_container.dart';
import '../mixins/content_renderer.dart';

class Blockquote extends StatelessWidget with ContentRenderer {
  final double bottomPadding;
  final BlockquoteTagModel tag;

  const Blockquote(this.tag, {Key? key, this.bottomPadding = paddingLarge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flattenedTexts = getFlattenedTexts(tag.texts);

    return ContentContainer(
      bottomPadding: bottomPadding,
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: flattenedTexts.map((text) {
              final style = getTextElementTextStyle(text);

              return TextSpan(text: text.text, style: style);
            }).toList()),
      ),
    );
  }
}
