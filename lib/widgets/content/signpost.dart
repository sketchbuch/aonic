import 'package:flutter/material.dart';

import '../../../models/book/content/signpost_tag.dart';
import '../layout/content_container.dart';
import '../mixins/content_renderer.dart';

class Signpost extends StatelessWidget with ContentRenderer {
  final SignpostTag tag;

  const Signpost(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flattenedTexts = getFlattenedTexts(tag.texts);

    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: flattenedTexts.map((text) {
            final style = getTextElementTextStyle(text);

            return TextSpan(style: style, text: text.text);
          }).toList(),
        ),
      ),
    );
  }
}
