import 'package:lonewolf_new/utils/xml/helpers.dart';
import 'package:xml/xml.dart';

XmlElement getRootXmlElement(String xml) {
  final cleanedXml = cleanXmlString(xml);
  final xmlTag = XmlDocument.parse(cleanedXml);
  return xmlTag.rootElement;
}
