import 'package:flutter/material.dart';

import '../../../models/book/content/signpost_tag.dart';
import '../../mixins/content_renderer.dart';
import '../content_container.dart';

class Signpost extends StatelessWidget with ContentRenderer {
  final SignpostTag tag;

  const Signpost(this.tag, {Key? key}) : super(key: key);

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
          }).toList(),
        ),
      ),
    );
  }
}
