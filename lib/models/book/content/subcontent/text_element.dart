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
      case 'b':
      case 'strong':
        if (xml.childElements.isNotEmpty && xml.childElements.elementAt(0).name.toString() == 'cite') {
          return DisplayType.boldCite;
        }

        return DisplayType.bold;

      case 'em':
      case 'i':
        return DisplayType.italic;

      case 'cite':
        return DisplayType.cite;

      case 'a':
      case 'link-text':
        return DisplayType.link;

      case 'typ':
        return DisplayType.typ;

      case 'bookref':
        return DisplayType.bookref;

      case 'dt':
        return DisplayType.dt;

      case 'dd':
        return DisplayType.dd;

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
