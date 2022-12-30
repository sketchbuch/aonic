import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../../constants/typography.dart';
import '../../../i18n/_generated_/translations.g.dart';
import '../../../models/book/section/footnote.dart';
import '../../../theme/theme.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

class FootnotesListItem extends StatefulWidget with ContentRenderer {
  final transBook = t.book;
  final bool isInSection;
  final Footnote footnote;
  final OnNavigate onNavigate;

  FootnotesListItem(this.footnote, this.onNavigate, {Key? key, this.isInSection = false}) : super(key: key);

  @override
  State<FootnotesListItem> createState() => _FootnotesListItemState();
}

class _FootnotesListItemState extends State<FootnotesListItem> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    final flattenedTexts = widget.getFlattenedTexts(widget.footnote.texts);
    final fontSize = widget.isInSection ? fontSizeS : fontSizeM;

    final itemPadding = widget.footnote.footnoteNumber > 1 ? const EdgeInsets.only(top: paddingLarge) : EdgeInsets.zero;
    final chldren = [
      if (!widget.isInSection) ...widget.footnote.getSectionPrefix(widget.transBook.footnotePrefix),
      ...flattenedTexts,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: itemPadding,
          child: Text(widget.footnote.footnoteNumber.toString(), style: TextStyle(fontSize: fontSize)),
        ),
        const SizedBox(width: offsetSmall),
        Expanded(
          child: Padding(
            padding: itemPadding,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: chldren.map((text) {
                  final int textIndex = chldren.indexOf(text);
                  final isHover = isHoverIndex(textIndex);
                  final isLink = isHoverable(text);
                  var style = widget.getTextElementTextStyle(text, isHover: isHover);
                  style = style.copyWith(fontSize: fontSize);

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
            ),
          ),
        ),
      ],
    );
  }
}
