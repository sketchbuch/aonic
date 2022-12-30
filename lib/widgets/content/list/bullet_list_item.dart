import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../models/book/content/subcontent/plain_list_item.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

const bulletSymbol = '\u2022';

class BulletListItem extends StatefulWidget with ContentRenderer {
  final int depth;
  final OnNavigate onNavigate;
  final PlainListItem item;

  const BulletListItem(this.item, this.onNavigate, this.depth, {Key? key}) : super(key: key);

  @override
  State<BulletListItem> createState() => _BulletListItemState();
}

class _BulletListItemState extends State<BulletListItem> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    final flattenedTexts = widget.getFlattenedTexts(widget.item.texts);
    final depthIndent = widget.depth * listIndent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.depth > 1) SizedBox(width: depthIndent),
        const Text(bulletSymbol),
        const SizedBox(width: offsetMedium),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: flattenedTexts.map((text) {
                final int textIndex = widget.item.texts.indexOf(text);
                final isHover = isHoverIndex(textIndex);
                final isLink = isHoverable(text);
                final style = widget.getTextElementTextStyle(text, isHover: isHover);

                TapGestureRecognizer? recognizer;

                if (isLink) {
                  recognizer = TapGestureRecognizer()
                    ..onTap = () {
                      final route = text.attrs['href'] ?? text.attrs['idref'] ?? '';
                      widget.onNavigate(route);
                    };

                  hoverRecognizers.add(recognizer);
                }

                return TextSpan(
                  onEnter: isLink ? (_) => handleOnEnter(textIndex) : null,
                  onExit: isLink ? (_) => handleOnExit() : null,
                  recognizer: recognizer,
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
