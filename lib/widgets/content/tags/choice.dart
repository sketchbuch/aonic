import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../models/book/content/choice_tag.dart';
import '../../../types/types.dart';
import '../../layout/content_container.dart';
import '../../mixins/content_renderer.dart';
import '../../mixins/hoverable_text_element.dart';

class Choice extends StatefulWidget with ContentRenderer {
  final ChoiceTag tag;
  final OnNavigate onNavigate;

  const Choice(this.tag, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> with HoverableTextElement {
  @override
  Widget build(BuildContext context) {
    int linkTextIndex = -1;

    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: widget.tag.texts.map((text) {
            final int textIndex = widget.tag.texts.indexOf(text);
            final isHover = isHoverIndex(textIndex);
            final isLink = isHoverable(text);
            var style = widget.getTextElementTextStyle(text, isHover: isHover);

            linkTextIndex += 1;

            if (widget.tag.linkTextIndex == linkTextIndex) {
              style = style.copyWith(fontWeight: FontWeight.bold);
            }

            return TextSpan(
              onEnter: isLink ? (_) => handleOnEnter(textIndex) : null,
              onExit: isLink ? (_) => handleOnExit() : null,
              recognizer: isLink
                  ? (TapGestureRecognizer()
                    ..onTap = () {
                      final route = widget.tag.idref;
                      widget.onNavigate(route);
                    })
                  : null,
              style: style,
              text: text.text,
            );
          }).toList(),
        ),
      ),
    );
  }
}
