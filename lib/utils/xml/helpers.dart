import 'package:xml/xml.dart';

import '../../constants/characters.dart';
import '../../models/book/content/subcontent/text_element_model.dart';
import '../../types/types.dart';
import 'replace_include_links.dart';
import 'replace_typographic_tags.dart';

final whitespaceBetweenTags = RegExp(r'>\s*<');
final htmlComments = RegExp(r"<\!--.+?-->");

String cleanXmlString(String xmlString, Map<String, String> includeLinks) {
  String cleanedString = xmlString
      .trim()
      .replaceAll(whitespaceBetweenTags, '><')
      .replaceAll(newLine, '');
  cleanedString = replaceTypographicTags(cleanedString);
  cleanedString = replaceIncludeLinks(cleanedString, includeLinks);
  cleanedString = cleanedString.replaceAll(htmlComments, '');

  return cleanedString;
}

String getAttribute(String name, dynamic xml, [String fallbackValue = '']) {
  if (xml is XmlElement || xml is XmlNode) {
    return xml.getAttribute(name) ?? fallbackValue;
  }

  return fallbackValue;
}

Attrs getAttributes(XmlElement element) {
  final Attrs attrs = {};

  if (element.attributes.isNotEmpty) {
    for (var attr in element.attributes) {
      attrs[attr.name.toString()] = attr.value;
    }
  }

  return attrs;
}

DateTime getDate(String year, String month, String day) {
  return DateTime.parse(
      '$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
}

TextElements getTextElementList(XmlElement xml, [DisplayType? type]) {
  final childNodes = [...xml.childElements];

  return xml.children.map((child) {
    if (child.nodeType == XmlNodeType.ELEMENT) {
      try {
        return TextElementModel.fromXml(childNodes.removeAt(0), type: type);
      } on RangeError {
        return TextElementModel.fromTxt(child.text);
      }
    } else {
      return TextElementModel.fromTxt(child.text, type: type);
    }
  }).toList();
}

String getValue(String element, XmlElement xmlNode,
    [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}
