import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

const double oneDigitWidth = 20;
const double twoDigitWidth = 25;
const double threeDigitWidth = 30;

class NumberedListItem extends StatefulWidget with ContentRenderer {
  final int depth;
  final int itemNumber;
  final int listSize;
  final OnNavigate onNavigate;
  final List<Widget> content;

  const NumberedListItem(this.content, this.onNavigate, this.depth, this.listSize, this.itemNumber, {Key? key})
      : super(key: key);

  @override
  State<NumberedListItem> createState() => _NumberedListItemState();
}

class _NumberedListItemState extends State<NumberedListItem> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    double numberWidth = oneDigitWidth;

    if (widget.listSize >= 10) {
      numberWidth = twoDigitWidth;
    } else if (widget.listSize >= 100) {
      numberWidth = threeDigitWidth;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: numberWidth,
          child: Text(
            '${widget.itemNumber}.',
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: offsetMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.content,
          ), //text
        ),
      ],
    );
  }
}
