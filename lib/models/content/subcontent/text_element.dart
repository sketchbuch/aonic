import 'package:xml/xml.dart';

import '../../../types/types.dart';

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
  late final DisplayType displayType;
  late final String text;

  TextElement(this.text, this.displayType);

  TextElement.fromXml(XmlElement xml) {
    text = xml.text;
    displayType = _getDisplayType(xml.name.toString());
  }

  TextElement.fromTxt(String txt) {
    text = txt;
    displayType = DisplayType.plain;
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
        'displayType': displayType.name,
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
