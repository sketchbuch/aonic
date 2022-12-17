import 'package:flutter/material.dart';

import '../../../models/book/content/subcontent/plain_list_item.dart';
import '../../mixins/content_renderer.dart';

class NumberedListItem extends StatelessWidget with ContentRenderer {
  final int listNumber;
  final PlainListItem item;

  const NumberedListItem(this.item, this.listNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$listNumber.'.toString()), //bullet text
        const SizedBox(width: 10), //space between bullet and text
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
