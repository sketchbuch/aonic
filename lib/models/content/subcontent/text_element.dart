import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';

enum DisplayType {
  bold,
  bookref,
  cite,
  italic,
  link,
  plain,
  quote,
  typ;
}

class TextElement {
  late final Attrs attrs;
  late final DisplayType displayType;
  late final String text;

  TextElement(this.text, this.displayType, this.attrs);

  TextElement.fromXml(XmlElement xml) {
    attrs = getAttributes(xml);
    displayType = _getDisplayType(xml.name.toString());
    text = xml.text;
  }

  TextElement.fromTxt(String txt) {
    attrs = {};
    displayType = DisplayType.plain;
    text = txt;
  }

  DisplayType _getDisplayType(String elementName) {
    switch (elementName) {
      case 'b':
      case 'strong':
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

      case 'quote':
        return DisplayType.quote;

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
