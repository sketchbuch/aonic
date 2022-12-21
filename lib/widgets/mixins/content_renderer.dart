import 'package:flutter/material.dart';

import '../../constants/characters.dart';
import '../../models/book/content/subcontent/text_element.dart';
import '../../theme/theme.dart';

final hoverBackgroundColour = Color(0xffcce0c1);

mixin ContentRenderer {
  void getStyle(DisplayType displayType) {}

  FontStyle getTextElementStyle(TextElement text) {
    if (text.displayType == DisplayType.italic ||
        text.displayType == DisplayType.cite ||
        text.displayType == DisplayType.quoteCite) {
      return FontStyle.italic;
    }

    return FontStyle.normal;
  }

  FontWeight getTextElementWeight(TextElement text) {
    if (text.displayType == DisplayType.bold ||
        text.displayType == DisplayType.link ||
        text.displayType == DisplayType.boldCite) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }

  TextDecoration getTextElementDecoration(TextElement text) {
    if (text.displayType == DisplayType.link) {
      return TextDecoration.underline;
    }

    return TextDecoration.none;
  }

  Color? getTextElementLinkColor(TextElement text) {
    if (text.displayType == DisplayType.link) {
      return colourPrimary;
    }

    return null;
  }

  Color? getTextElementBackroundColor(TextElement text) {
    return null;
  }

  Color? getTextElementHoverBackroundColor(TextElement text) {
    if (text.displayType == DisplayType.link) {
      return hoverBackgroundColour;
    }

    return null;
  }

  String wrapText(TextElement text) {
    if (text.displayType == DisplayType.quote || text.displayType == DisplayType.quoteCite) {
      return '$startQuote${text.text}$endQuote';
    }

    return text.text;
  }
}
