import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element.dart';
import '../../theme/theme.dart';

const hoverBackgroundColour = Color(0xffcce0c1);

mixin ContentRenderer on Widget {
  void getStyle(DisplayType displayType) {}

  TextStyle getTextElementTextStyle(TextElement text, {bool isHover = false}) {
    Color? backgroundColor;
    Color? foregrondColor;
    FontStyle style = FontStyle.normal;
    FontWeight weight = FontWeight.normal;
    TextDecoration decoration = TextDecoration.none;

    if (text.displayType == DisplayType.cite ||
        text.displayType == DisplayType.italic ||
        text.displayType == DisplayType.quoteCite) {
      style = FontStyle.italic;
    }

    if (text.displayType == DisplayType.bold ||
        text.displayType == DisplayType.boldCite ||
        text.displayType == DisplayType.bookref ||
        text.displayType == DisplayType.citeBookref ||
        text.displayType == DisplayType.link) {
      weight = FontWeight.bold;
    }

    if (text.displayType == DisplayType.bookref ||
        text.displayType == DisplayType.citeBookref ||
        text.displayType == DisplayType.link) {
      decoration = TextDecoration.underline;
      foregrondColor = colourPrimary;

      if (isHover) {
        backgroundColor = hoverBackgroundColour;
      }
    }

    return TextStyle(
      backgroundColor: backgroundColor,
      color: foregrondColor,
      decoration: decoration,
      fontStyle: style,
      fontWeight: weight,
    );
  }
}
