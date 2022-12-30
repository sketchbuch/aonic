import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';

enum DisplayType {
  bold,
  bookref,
  cite,
  dd,
  dt,
  footref,
  italic,
  link,
  plain,
  quote,
  typ;
}

class TextElementNew {
  final List<TextElementNew> subelements = [];
  late BookText text;
  late final Attrs attrs;
  late final DisplayType displayType;

  // ignore: unused_element
  TextElementNew._();

  TextElementNew.fromXml(XmlElement xml, [DisplayType? type]) {
    final hasChildren = xml.childElements.isNotEmpty;

    displayType = type ?? _getDisplayType(xml);
    attrs = _getAttrs(xml, displayType);
    text = hasChildren ? '' : xml.text;

    if (hasChildren) {
      final childNodes = [...xml.childElements];
      for (var child in xml.children) {
        if (child.nodeType == XmlNodeType.ELEMENT) {
          subelements.add(TextElementNew.fromXml(childNodes.removeAt(0)));
        } else {
          subelements.add(TextElementNew.fromTxt(child.text));
        }
      }
    }
  }

  TextElementNew.fromTxt(String txt, {DisplayType? type, Attrs? attributes}) {
    attrs = attributes ?? {};
    displayType = type ?? DisplayType.plain;
    text = txt;
  }

  Attrs _getAttrs(XmlElement xml, DisplayType displayType) {
    var attrs = getAttributes(xml);

    /* if (displayType == DisplayType.citeBookref) {
      if (xml.childElements.isNotEmpty && xml.childElements.elementAt(0).name.toString() == 'bookref') {
        attrs = {...attrs, ...getAttributes(xml.childElements.elementAt(0))};
      }
    }

    if (displayType == DisplayType.citeBookref || displayType == DisplayType.bookref) {
      final book = attrs['book'];
      final series = attrs['series'];

      attrs['href'] = 'https://www.projectaon.org/en/xhtml/$series/$book/title.htm';
    } */

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
        'subelements': subelements.map((subelement) => subelement.toJson()).toList(),
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
