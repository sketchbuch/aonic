import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

class ParagraphTag extends Tag {
  late final List<TextElement> texts;

  ParagraphTag(this.texts);

  ParagraphTag.fromXml(XmlElement xml) {
    texts = [];

    final childCount = xml.children.length;

    if (childCount < 1) {
      throw ContentXmlException('Too few children');
    } else {
      for (var index = 0; index < childCount; index++) {
        final child = xml.children.elementAt(index);

        if (child.nodeType == XmlNodeType.ELEMENT) {
          final childElement = xml.childElements.elementAt(0);
          texts.add(TextElement.fromXml(childElement));
        } else if (child.nodeType == XmlNodeType.TEXT) {
          texts.add(TextElement.fromTxt(child.text));
        } else {
          throw ContentXmlException('Unknown nodeType: ${child.nodeType}');
        }
      }
    }
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
