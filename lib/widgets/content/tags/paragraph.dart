import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';

import '../../../models/book/content/paragraph_tag.dart';
import '../../../types/types.dart';
import '../../mixins/content_renderer.dart';
import '../content_container.dart';

class Paragraph extends StatefulWidget with ContentRenderer {
  final ParagraphTag tag;
  final OnNavigate onNavigate;

  const Paragraph(this.tag, this.onNavigate, {Key? key}) : super(key: key);

  @override
  State<Paragraph> createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: widget.tag.texts.map((text) {
            final int index = widget.tag.texts.indexOf(text);

            GestureRecognizer? recognizer;

            final style = widget.getTextElementStyle(text);
            final weight = widget.getTextElementWeight(text);
            final decoration = widget.getTextElementDecoration(text);
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
                decoration: decoration,
                fontStyle: style,
                fontWeight: weight,
              ),
              text: widget.wrapText(text),
            );
          }).toList(),
        ),
      ),
    );
  }
}
