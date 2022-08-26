import 'package:xml/xml.dart';

import '../../../types/types.dart';
import 'text_element.dart';

class ListItem {
  late final List<TextElement> texts;

  ListItem(this.texts);

  ListItem.fromXml(XmlElement xml) {
    texts = [];

    var elementCount = 0;

    for (var index = 0; index < xml.children.length; index++) {
      final child = xml.children.elementAt(index);

      if (child.nodeType == XmlNodeType.ELEMENT) {
        final childElement = xml.childElements.elementAt(elementCount);
        texts.add(TextElement.fromXml(childElement));
        elementCount += 1;
      } else {
        texts.add(TextElement.fromTxt(child.text));
      }
    }
  }

  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
