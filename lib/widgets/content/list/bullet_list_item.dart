import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/typography.dart';
import '../../../models/book/content/subcontent/plain_list_item.dart';
import '../../../models/book/content/subcontent/text_element.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';

const bulletSymbol = '\u2022';

class BulletListItem extends StatefulWidget with ContentRenderer {
  final int depth;
  final OnNavigate onNavigate;
  final PlainListItem item;

  const BulletListItem(this.item, this.onNavigate, this.depth, {Key? key}) : super(key: key);

  @override
  State<BulletListItem> createState() => _BulletListItemState();
}

class _BulletListItemState extends State<BulletListItem> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    final depthIndent = widget.depth * listIndent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.depth > 1) SizedBox(width: depthIndent),
        const Text(bulletSymbol),
        const SizedBox(width: stdOffset),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: widget.item.texts.map((text) {
                final int index = widget.item.texts.indexOf(text);

                GestureRecognizer? recognizer;

                final FontStyle style = widget.getTextElementStyle(text);
                final FontWeight weight = widget.getTextElementWeight(text);
                final TextDecoration decoration = widget.getTextElementDecoration(text);
                final Color? foregrondColor = widget.getTextElementLinkColor(text);
                Color? backgroundColor = widget.getTextElementBackroundColor(text);

                if (text.displayType == DisplayType.link) {
                  recognizer = TapGestureRecognizer()
                    ..onTap = () {
                      final route = text.attrs['href'] ?? text.attrs['idref'] ?? '';
                      widget.onNavigate(route);
                    };

                  if (_hoverIndex != null && _hoverIndex == index) {
                    backgroundColor = widget.getTextElementHoverBackroundColor(text);
                  }
                }

                return TextSpan(
                  onEnter: (_) => setState(() => _hoverIndex = index),
                  onExit: (_) {
                    if (mounted) {
                      setState(() => _hoverIndex = null);
                    }
                  },
                  recognizer: recognizer,
                  style: TextStyle(
                    backgroundColor: backgroundColor,
                    color: foregrondColor,
                    decoration: decoration,
                    fontStyle: style,
                    fontWeight: weight,
                  ),
                  text: widget.wrapText(text),
                );
              }).toList(),
            ),
          ), //text
        ),
      ],
    );
  }
}
