import 'package:xml/xml.dart';

import '../../types/types.dart';
import 'replace_character_tags.dart';

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

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}

String cleanXmlString(String xmlString) {
  var cleanedString = xmlString.trim().replaceAll(RegExp(r'>\s*<'), '><').replaceAll('\n', '');
  return replaceCharacterTags(cleanedString);
}
