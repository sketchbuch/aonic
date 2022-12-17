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
            FontStyle style = getTextElementStyle(text);
            FontWeight weight = getTextElementWeight(text);

            return TextSpan(text: wrapText(text), style: TextStyle(fontWeight: weight, fontStyle: style));
          }).toList(),
        ),
      ),
    );
  }
}
