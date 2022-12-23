// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';

mixin HoverableTextElement<T extends StatefulWidget> on State<T> {
  int? hoverIndex;

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

  bool isHoverable(TextElement textElement) {
    return textElement.displayType == DisplayType.link;
  }
}
