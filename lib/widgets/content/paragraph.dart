import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/layout.dart';
import '../../models/book/content/paragraph_tag_model.dart';
import '../../../types/types.dart';
import '../layout/content_container.dart';
import '../mixins/content_renderer.dart';
import '../mixins/hoverable_text_element.dart';

class Paragraph extends StatefulWidget with ContentRenderer {
  final double bottomPadding;
  final OnNavigate onNavigate;
  final ParagraphTagModel tag;

  const Paragraph(this.tag, this.onNavigate,
      {Key? key, this.bottomPadding = paddingLarge})
      : super(key: key);

  @override
  State<Paragraph> createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    final flattenedTexts = widget.getFlattenedTexts(widget.tag.texts);

    return ContentContainer(
      bottomPadding: widget.bottomPadding,
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: flattenedTexts.map((text) {
            final int textIndex = widget.tag.texts.indexOf(text);
            final isHover = isHoverIndex(textIndex);
            final isLink = isHoverable(text);
            final style =
                widget.getTextElementTextStyle(text, isHover: isHover);

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
    );
  }
}
