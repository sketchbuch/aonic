import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../models/book/content/subcontent/description_list_item.dart';
import '../../mixins/content_renderer.dart';

class DescriptionDetailListItem extends StatelessWidget with ContentRenderer {
  final DescriptionListItem item;

  const DescriptionDetailListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flattenedTexts = getFlattenedTexts(item.texts);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: stdIndent),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: flattenedTexts.map((text) {
                final style = getTextElementTextStyle(text);

                return TextSpan(text: text.text, style: style);
              }).toList(),
            ),
          ), //text
        ),
      ],
    );
  }
}
