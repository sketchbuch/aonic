import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../models/book/content/choice_tag.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../content_container.dart';

class Choice extends StatefulWidget with ContentRenderer {
  final ChoiceTag tag;
  final OnNavigate onNavigate;

  const Choice(this.tag, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    int textIndex = -1;

    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: widget.tag.texts.map((text) {
            final int index = widget.tag.texts.indexOf(text);

            GestureRecognizer? recognizer;
            textIndex += 1;

            final style = widget.getTextElementStyle(text);
            var weight = widget.getTextElementWeight(text);
            final decoration = widget.getTextElementDecoration(text);
            Color? backgroundColor = widget.getTextElementBackroundColor(text);

            if (widget.tag.linkTextIndex == textIndex) {
              weight = FontWeight.bold;

              recognizer = TapGestureRecognizer()
                ..onTap = () {
                  final route = widget.tag.idref;
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
                decoration: decoration,
                fontStyle: style,
                fontWeight: weight,
              ),
              text: text.text,
            );
          }).toList(),
        ),
      ),
    );
  }
}
