import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';

enum DisplayType {
  bold,
  boldCite,
  bookref,
  cite,
  citeBookref,
  dd,
  dt,
  footref,
  italic,
  link,
  plain,
  quote,
  quoteCite,
  typ;
}

class TextElement {
  late final Attrs attrs;
  late final DisplayType displayType;
  late final BookText text;

  // ignore: unused_element
  TextElement._();

  TextElement.fromXml(XmlElement xml, [DisplayType? type]) {
    displayType = type ?? _getDisplayType(xml);
    attrs = _getAttrs(xml, displayType);
    text = xml.text;
  }

  TextElement.fromTxt(String txt, {DisplayType? type, Attrs? attributes}) {
    attrs = attributes ?? {};
    displayType = type ?? DisplayType.plain;
    text = txt;
  }

  Attrs _getAttrs(XmlElement xml, DisplayType displayType) {
    var attrs = getAttributes(xml);

    if (displayType == DisplayType.citeBookref) {
      if (xml.childElements.isNotEmpty && xml.childElements.elementAt(0).name.toString() == 'bookref') {
        attrs = {...attrs, ...getAttributes(xml.childElements.elementAt(0))};
      }
    }

    if (displayType == DisplayType.citeBookref || displayType == DisplayType.bookref) {
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
        if (xml.childElements.isNotEmpty && xml.childElements.elementAt(0).name.toString() == 'cite') {
          return DisplayType.boldCite;
        }

        return DisplayType.bold;

      case 'bookref':
        return DisplayType.bookref;

      case 'cite':
        if (xml.childElements.isNotEmpty && xml.childElements.elementAt(0).name.toString() == 'bookref') {
          return DisplayType.citeBookref;
        }

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
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
