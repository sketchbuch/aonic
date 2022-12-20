import 'package:flutter/material.dart';

import '../../../models/book/content/subcontent/description_list_item.dart';
import '../../mixins/content_renderer.dart';

class DescriptionTermListItem extends StatelessWidget with ContentRenderer {
  final DescriptionListItem item;

  const DescriptionTermListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: item.texts.map((text) {
                final FontStyle style = getTextElementStyle(text);
                const FontWeight weight = FontWeight.bold;

                return TextSpan(text: wrapText(text), style: TextStyle(fontWeight: weight, fontStyle: style));
              }).toList(),
            ),
          ), //text
        ),
      ],
    );
  }
}
