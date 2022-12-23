import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../models/book/content/subcontent/plain_list_item.dart';
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
  final PlainListItem item;

  const NumberedListItem(this.item, this.onNavigate, this.depth, this.listSize, this.itemNumber, {Key? key})
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
        const SizedBox(width: stdOffset),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: widget.item.texts.map((text) {
                final int textIndex = widget.item.texts.indexOf(text);
                final isHover = isHoverIndex(textIndex);
                final isLink = isHoverable(text);
                final style = widget.getTextElementTextStyle(text, isHover: isHover);

                return TextSpan(
                  onEnter: isLink ? (_) => handleOnEnter(textIndex) : null,
                  onExit: isLink ? (_) => handleOnExit() : null,
                  recognizer: isLink
                      ? (TapGestureRecognizer()
                        ..onTap = () {
                          final route = text.attrs['href'] ?? text.attrs['idref'] ?? '';
                          widget.onNavigate(route);
                        })
                      : null,
                  style: style,
                  text: text.text,
                );
              }).toList(),
            ),
          ), //text
        ),
      ],
    );
  }
}
