import 'package:xml/xml.dart';

String getAttribute(String name, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getAttribute(name) ?? fallbackValue;
}

String getValue(String element, XmlElement xmlNode, [String fallbackValue = '']) {
  return xmlNode.getElement(element)?.text ?? fallbackValue;
}
