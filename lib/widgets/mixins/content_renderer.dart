import 'package:flutter/material.dart';

import '../../models/book/content/subcontent/text_element.dart';

mixin ContentRenderer {
  void getStyle(DisplayType displayType) {}

  FontStyle getTextElementStyle(TextElement text) {
    if (text.displayType == DisplayType.italic || text.displayType == DisplayType.cite) {
      return FontStyle.italic;
    }

    return FontStyle.normal;
  }

  FontWeight getTextElementWeight(TextElement text) {
    if (text.displayType == DisplayType.bold ||
        text.displayType == DisplayType.link ||
        text.displayType == DisplayType.cite) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }
}
