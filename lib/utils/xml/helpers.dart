import 'package:lonewolf_new/utils/xml/replace_include_links.dart';
import 'package:xml/xml.dart';

import '../../models/book/content/subcontent/text_element.dart';
import '../../types/types.dart';
import 'replace_character_tags.dart';

String cleanXmlString(String xmlString, Map<String, String> includeLinks) {
  var cleanedString = xmlString.trim().replaceAll(RegExp(r'>\s*<'), '><').replaceAll('\n', '');
  cleanedString = replaceCharacterTags(cleanedString);
  cleanedString = replaceIncludeLinks(cleanedString, includeLinks);

  return '$cleanedString&link.';
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
  var elementCount = -1;

  return xml.children.map((child) {
    if (child.nodeType == XmlNodeType.ELEMENT) {
      elementCount += 1;

      try {
        final childElement = xml.childElements.elementAt(elementCount);
        return TextElement.fromXml(childElement);
      } on RangeError {
        return TextElement.fromTxt(child.text);
      }
    } else {
      return TextElement.fromTxt(child.text);
    }
  }).toList();
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}
