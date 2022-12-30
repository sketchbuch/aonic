import 'package:lonewolf_new/utils/xml/replace_include_links.dart';
import 'package:xml/xml.dart';

import '../../constants/characters.dart';
import '../../models/book/content/subcontent/text_element.dart';
import '../../types/types.dart';
import 'replace_typographic_tags.dart';

final whitespaceBetweenTags = RegExp(r'>\s*<');
final htmlComments = RegExp(r"<\!--.+?-->");

String cleanXmlString(String xmlString, Map<String, String> includeLinks) {
  String cleanedString = xmlString.trim().replaceAll(whitespaceBetweenTags, '><').replaceAll(newLine, '');
  cleanedString = replaceTypographicTags(cleanedString);
  cleanedString = replaceIncludeLinks(cleanedString, includeLinks);
  cleanedString = cleanedString.replaceAll(htmlComments, '');

  return cleanedString;
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

TextElements getTextElementList(XmlElement xml, [DisplayType? type]) {
  int elementCount = -1;

  return xml.children.map((child) {
    if (child.nodeType == XmlNodeType.ELEMENT) {
      elementCount += 1;

      try {
        final childElement = xml.childElements.elementAt(elementCount);
        return TextElement.fromXml(childElement, type: type);
      } on RangeError {
        return TextElement.fromTxt(child.text);
      }
    } else {
      return TextElement.fromTxt(child.text, type: type);
    }
  }).toList();
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}
