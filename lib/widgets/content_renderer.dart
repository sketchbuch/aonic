import 'package:flutter/material.dart';

import '../models/content/subcontent/text_element.dart';

mixin ContentRenderer {
  void getStyle(DisplayType displayType) {}

  Widget wrapContent(Widget content, {double bottomPadding = 16.0}) {
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: content,
    );
  }

  FontStyle getTextElementStyle(TextElement text) {
    if (text.displayType == DisplayType.italic) {
      return FontStyle.italic;
    }

    return FontStyle.normal;
  }

  FontWeight getTextElementWeight(TextElement text) {
    if (text.displayType == DisplayType.bold || text.displayType == DisplayType.link) {
      return FontWeight.bold;
    }

    return FontWeight.normal;
  }
}
