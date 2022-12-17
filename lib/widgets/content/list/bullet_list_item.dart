import 'package:flutter/material.dart';

import '../../../models/book/content/subcontent/plain_list_item.dart';
import '../../mixins/content_renderer.dart';

const bulletSymbol = '\u2022';

class BulletListItem extends StatelessWidget with ContentRenderer {
  final int listSize;
  final PlainListItem item;

  const BulletListItem(this.item, this.listSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(bulletSymbol),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: item.texts.map((text) {
                FontStyle style = getTextElementStyle(text);
                FontWeight weight = getTextElementWeight(text);

                return TextSpan(text: wrapText(text), style: TextStyle(fontWeight: weight, fontStyle: style));
              }).toList(),
            ),
          ), //text
        ),
      ],
    );
  }
}
