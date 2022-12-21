import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/content/subcontent/text_element.dart';
import '../../../models/book/section/footnote.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';

class FootnotesListItem extends StatefulWidget with ContentRenderer {
  final transBook = t.book;
  final Footnote footnote;
  final int footnoteNumber;
  final OnNavigate onNavigate;

  FootnotesListItem(this.footnote, this.footnoteNumber, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<FootnotesListItem> createState() => _FootnotesListItemState();
}

class _FootnotesListItemState extends State<FootnotesListItem> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    final chldren = [
      ...widget.footnote.getFootnoteNumber(widget.footnoteNumber),
      ...widget.footnote.getSectionPrefix(widget.transBook.footnotePrefix),
      ...widget.footnote.texts,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: widget.footnoteNumber > 1 ? const EdgeInsets.only(top: paddingLarge) : EdgeInsets.zero,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: chldren.map((text) {
                  final int index = chldren.indexOf(text);

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
            ),
          ), //text
        ),
      ],
    );
  }
}
