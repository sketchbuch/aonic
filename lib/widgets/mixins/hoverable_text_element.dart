// ignore_for_file: unused_field, unused_element

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element_model.dart';

mixin HoverableTextElement<T extends StatefulWidget> on State<T> {
  int? hoverIndex;
  final List<TapGestureRecognizer> hoverRecognizers = [];

  @override
  void dispose() {
    for (var recognizer in hoverRecognizers) {
      recognizer.dispose();
    }

    super.dispose();
  }

  void handleOnEnter(int textIndex) {
    setState(() => hoverIndex = textIndex);
  }

  void handleOnExit() {
    if (mounted) {
      setState(() => hoverIndex = null);
    }
  }

  bool isHoverIndex(int textIndex) {
    return hoverIndex == textIndex;
  }

  bool isHoverable(TextElementModel textElement) {
    return textElement.displayType == DisplayType.link ||
        textElement.displayType == DisplayType.bookref;
  }
}
