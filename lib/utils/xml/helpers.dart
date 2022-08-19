import 'package:xml/xml.dart';

String getAttribute(String name, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getAttribute(name) ?? fallbackValue;
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}

DateTime getDate(String year, String month, String day) {
  return DateTime.parse('$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
}
