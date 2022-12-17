import 'package:flutter/material.dart';

import '../../../models/book/content/subcontent/plain_list_item.dart';
import '../../mixins/content_renderer.dart';

const double oneDigitWidth = 20;
const double twoDigitWidth = 25;
const double threeDigitWidth = 30;

class NumberedListItem extends StatelessWidget with ContentRenderer {
  final int itemNumber;
  final int listSize;
  final PlainListItem item;

  const NumberedListItem(this.item, this.listSize, this.itemNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double numberWidth = oneDigitWidth;

    if (listSize >= 10) {
      numberWidth = twoDigitWidth;
    } else if (listSize >= 100) {
      numberWidth = threeDigitWidth;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: numberWidth,
          child: Text(
            '$itemNumber.'.toString(),
            textAlign: TextAlign.right,
          ),
        ),
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
