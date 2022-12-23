import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/section/footnote.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

class FootnotesListItem extends StatefulWidget with ContentRenderer {
  final transBook = t.book;
  final Footnote footnote;
  final int footnoteNumber;
  final OnNavigate onNavigate;

  FootnotesListItem(this.footnote, this.footnoteNumber, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<FootnotesListItem> createState() => _FootnotesListItemState();
}

class _FootnotesListItemState extends State<FootnotesListItem> with HoverableTextElement {
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
                  final int textIndex = chldren.indexOf(text);
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
            ),
          ), //text
        ),
      ],
    );
  }
}
