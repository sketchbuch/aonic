import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../models/book/content/subcontent/text_element.dart';
import '../../mixins/content_renderer.dart';

class DescriptionDetailTextListItem extends StatelessWidget with ContentRenderer {
  final TextElement text;

  const DescriptionDetailTextListItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FontStyle style = getTextElementStyle(text);
    final FontWeight weight = getTextElementWeight(text);

    final TextSpan textSpan = TextSpan(text: wrapText(text), style: TextStyle(fontWeight: weight, fontStyle: style));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: stdIndent),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [textSpan],
            ),
          ), //text
        ),
      ],
    );
  }
}
