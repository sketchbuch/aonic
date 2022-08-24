import 'package:xml/xml.dart';

import 'replace_character_tags.dart';

String getAttribute(String name, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getAttribute(name) ?? fallbackValue;
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}

DateTime getDate(String year, String month, String day) {
  return DateTime.parse('$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
}

String cleanXmlString(String xmlString) {
  var cleanedString = xmlString.trim().replaceAll(RegExp(r'>\s*<'), '><').replaceAll('\n', '');
  return replaceCharacterTags(cleanedString);
}
