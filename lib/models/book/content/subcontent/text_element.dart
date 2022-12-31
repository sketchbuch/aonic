import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';

typedef TextElements = List<TextElement>;

enum DisplayType {
  bold,
  bookref,
  cite,
  dd,
  dt,
  footref,
  italic,
  link,
  none,
  plain,
  quote,
  typ;
}

class TextElement {
  final TextElements subelements = [];
  late BookText text;
  late final Attrs attrs;
  late final DisplayType displayType;
  late final DisplayType parentType;

  // ignore: unused_element
  TextElement._();

  TextElement.fromTxt(String txt, {Attrs? attributes, DisplayType? parentDisplayType, DisplayType? type}) {
    attrs = attributes ?? {};
    displayType = type ?? DisplayType.plain;
    parentType = parentDisplayType ?? DisplayType.none;
    text = txt;
  }

  TextElement.fromXml(XmlElement xml, {Attrs? attributes, DisplayType? parentDisplayType, DisplayType? type}) {
    final hasChildren = xml.childElements.isNotEmpty;

    displayType = type ?? _getDisplayType(xml);
    attrs = attributes ?? _getAttrs(xml, displayType);
    parentType = parentDisplayType ?? DisplayType.none;
    text = hasChildren ? '' : xml.text;

    if (hasChildren) {
      final childNodes = [...xml.childElements];
      for (var child in xml.children) {
        if (child.nodeType == XmlNodeType.ELEMENT) {
          subelements.add(TextElement.fromXml(childNodes.removeAt(0), parentDisplayType: displayType));
        } else {
          subelements.add(TextElement.fromTxt(child.text, parentDisplayType: displayType));
        }
      }
    }
  }

  Attrs _getAttrs(XmlElement xml, DisplayType displayType) {
    var attrs = getAttributes(xml);

    if (displayType == DisplayType.bookref) {
      final book = attrs['book'];
      final series = attrs['series'];

      attrs['href'] = 'https://www.projectaon.org/en/xhtml/$series/$book/title.htm';
    }

    return attrs;
  }

  DisplayType _getDisplayType(XmlElement xml) {
    final String elementName = xml.name.toString();

    switch (elementName) {
      case 'a':
      case 'link-text':
        return DisplayType.link;

      case 'b':
      case 'strong':
        return DisplayType.bold;

      case 'bookref':
        return DisplayType.bookref;

      case 'cite':
        return DisplayType.cite;

      case 'dt':
        return DisplayType.dt;

      case 'dd':
        return DisplayType.dd;

      case 'em':
      case 'i':
      case 'onomatopoeia':
        return DisplayType.italic;

      case 'footref':
        return DisplayType.footref;

      case 'typ':
        return DisplayType.typ;

      default:
        return DisplayType.plain;
    }
  }

  Json toJson() => {
        'attrs': attrs,
        'displayType': displayType.name,
        'parentType': parentType.name,
        'subelements': subelements.map((subelement) => subelement.toJson()).toList(),
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool isNode() {
    return text.isEmpty && subelements.isNotEmpty;
  }
}
