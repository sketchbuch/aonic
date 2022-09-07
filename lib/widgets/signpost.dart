import 'package:flutter/material.dart';

import '../models/book/content/signpost_tag.dart';
import 'content_renderer.dart';

class Signpost extends StatelessWidget with ContentRenderer {
  final SignpostTag tag;

  const Signpost(this.tag, {Key? key}) : super(key: key);

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