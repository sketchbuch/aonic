import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element.dart';
import '../../theme/theme.dart';

const hoverBackgroundColour = Color(0xffcce0c1);

mixin ContentRenderer on Widget {
  TextStyle getTextElementTextStyle(TextElement text, {bool isHover = false}) {
    Color? backgroundColor;
    Color? foregrondColor;
    double? size;
    FontStyle style = FontStyle.normal;
    FontWeight weight = FontWeight.normal;
    TextDecoration decoration = TextDecoration.none;
    List<FontFeature>? fontFeatures = [];

    if (text.displayType == DisplayType.cite || text.displayType == DisplayType.italic) {
      style = FontStyle.italic;
    }

    if (text.displayType == DisplayType.bold ||
        text.displayType == DisplayType.bookref ||
        text.displayType == DisplayType.footref ||
        text.displayType == DisplayType.link) {
      weight = FontWeight.bold;
    }

    if (text.displayType == DisplayType.bookref || text.displayType == DisplayType.link) {
      decoration = TextDecoration.underline;
      foregrondColor = colourPrimary;

      if (isHover) {
        backgroundColor = hoverBackgroundColour;
      }
    }

    if (text.displayType == DisplayType.footref) {
      size = fontSizeS;
      fontFeatures = [const FontFeature.superscripts()];
    }

    return TextStyle(
      backgroundColor: backgroundColor,
      color: foregrondColor,
      decoration: decoration,
      fontStyle: style,
      fontWeight: weight,
      fontSize: size,
      fontFeatures: fontFeatures,
    );
  }
}
