import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element_model.dart';
import '../../theme/theme.dart';

const hoverBackgroundColour = Color(0xffcce0c1);

mixin ContentRenderer on Widget {
  TextElements _flattenTexts(TextElements textElements) {
    final TextElements flattenedTexts = [];

    for (var text in textElements) {
      if (text.isNode()) {
        flattenedTexts.addAll(_flattenTexts(text.subelements));
      } else {
        flattenedTexts.add(text);
      }
    }

    return flattenedTexts;
  }

  TextElements getFlattenedTexts(TextElements textElements) {
    if (textElements.isEmpty) {
      return [];
    }

    return _flattenTexts(textElements);
  }

  TextStyle getTextElementTextStyle(TextElementModel text,
      {bool isHover = false}) {
    Color? backgroundColor;
    Color? foregrondColor;
    double? size;
    FontStyle style = FontStyle.normal;
    FontWeight weight = FontWeight.normal;
    TextDecoration decoration = TextDecoration.none;
    List<FontFeature>? fontFeatures = [];

    if (text.displayType == DisplayType.cite ||
        text.displayType == DisplayType.italic ||
        text.parentType == DisplayType.italic) {
      style = FontStyle.italic;
    }

    if (text.displayType == DisplayType.bold ||
        text.displayType == DisplayType.bookref ||
        text.displayType == DisplayType.footref ||
        text.displayType == DisplayType.link ||
        text.parentType == DisplayType.bold) {
      weight = FontWeight.bold;
    }

    if (text.displayType == DisplayType.bookref ||
        text.displayType == DisplayType.link) {
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
