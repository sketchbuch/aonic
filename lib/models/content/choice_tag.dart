import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

class ChoiceTag extends Tag {
  late final String idref;
  late final int linkTextIndex;
  late final List<TextElement> texts;

  ChoiceTag(this.texts, this.linkTextIndex, this.idref);

  ChoiceTag.fromXml(XmlElement xml) {
    idref = getAttribute('idref', xml);
    texts = [];

    final childCount = xml.children.length;
    final childElementCount = xml.childElements.length;

    if (childElementCount < 1) {
      throw ContentXmlException('Too few child elements');
    } else if (childElementCount > 1) {
      throw ContentXmlException('Too many child elements: "$childElementCount"');
    } else if (childCount < 2) {
      throw ContentXmlException('Too few children');
    } else {
      for (var index = 0; index < childCount; index++) {
        final child = xml.children.elementAt(index);

        if (child.nodeType == XmlNodeType.ELEMENT) {
          final childElement = xml.childElements.elementAt(0);
          texts.add(TextElement.fromXml(childElement));
          linkTextIndex = index;
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
        'idref': idref,
        'linkTextIndex': linkTextIndex,
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
