import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

class ParagraphTag extends Tag {
  // ignore: unused_element
  ParagraphTag._();

  ParagraphTag.fromNode(XmlNode node) {
    final nodeXml = XmlDocument.parse(node.outerXml).rootElement;
    final String className = getAttribute('class', nodeXml);
    texts.addAll(getTextElementList(nodeXml, _getType(className)));
  }

  ParagraphTag.fromTxt(String text, {Attrs? attributes, DisplayType? parentDisplayType, DisplayType? type}) {
    texts.add(TextElement.fromTxt(
      text,
      attributes: attributes,
      parentDisplayType: parentDisplayType,
      type: type,
    ));
  }

  ParagraphTag.fromXml(XmlElement xml) {
    final String className = getAttribute('class', xml);
    texts.addAll(getTextElementList(xml, _getType(className)));
  }

  DisplayType? _getType(String className) {
    if (className == 'dedication') {
      return DisplayType.italic;
    }

    return null;
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
