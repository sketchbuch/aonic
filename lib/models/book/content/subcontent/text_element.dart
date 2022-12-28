import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';

enum DisplayType {
  bold,
  boldCite,
  bookref,
  cite,
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
    attrs = getAttributes(xml);
    displayType = type ?? _getDisplayType(xml);
    text = xml.text;
  }

  TextElement.fromTxt(String txt, {DisplayType? type, Attrs? attributes}) {
    attrs = attributes ?? {};
    displayType = type ?? DisplayType.plain;
    text = txt;
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
