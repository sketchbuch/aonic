import 'package:xml/xml.dart';

import '../../models/content/subcontent/text_element.dart';
import '../../types/types.dart';
import 'replace_character_tags.dart';

String cleanXmlString(String xmlString) {
  var cleanedString = xmlString.trim().replaceAll(RegExp(r'>\s*<'), '><').replaceAll('\n', '');
  return replaceCharacterTags(cleanedString);
}

String getAttribute(String name, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getAttribute(name) ?? fallbackValue;
}

Attrs getAttributes(XmlElement xmlNode) {
  final Attrs attrs = {};

  if (xmlNode.attributes.isNotEmpty) {
    for (var attr in xmlNode.attributes) {
      attrs[attr.name.toString()] = attr.value;
    }
  }

  return attrs;
}

DateTime getDate(String year, String month, String day) {
  return DateTime.parse('$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
}

List<TextElement> getTextElementList(XmlElement xml) {
  var elementCount = 0;

  return xml.children.map((child) {
    if (child.nodeType == XmlNodeType.ELEMENT) {
      final childElement = xml.childElements.elementAt(elementCount);
      elementCount += 1;
      return TextElement.fromXml(childElement);
    } else {
      return TextElement.fromTxt(child.text);
    }
  }).toList();
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}
