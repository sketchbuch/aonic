import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element.dart';
import '../../utils/rendering/text_style.dart';
import '../content.dart';

class ParagraphTextList extends StatelessWidget {
  final List<TextElement> textList;

  const ParagraphTextList(this.textList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Content(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: textList.map((text) {
            final style = getTextElementStyle(text);
            final weight = getTextElementWeight(text);

            return TextSpan(text: text.text, style: TextStyle(fontWeight: weight, fontStyle: style));
          }).toList(),
        ),
      ),
    );
  }
}
