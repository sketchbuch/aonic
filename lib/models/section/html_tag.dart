import 'package:xml/xml.dart';

import '../../types/types.dart';

enum HtmlTagType { element, text }

class HtmlTag {
  late final HtmlTagType type;
  late final List<HtmlTag> content;
  late final Attrs attrs;
  late final String name;
  late final String text;

  HtmlTag(this.name, this.type, this.text, this.content, this.attrs);

  HtmlTag.fromXml(XmlElement xml) {
    attrs = {};
    content = [];
    name = xml.name.toString();
    text = xml.nodeType == XmlNodeType.TEXT ? xml.text : '';

    if (xml.nodeType == XmlNodeType.ELEMENT) {
      type = HtmlTagType.element;
    } else {
      type = HtmlTagType.text;
    }

    if (xml.attributes.isNotEmpty) {
      for (var attr in xml.attributes) {
        attrs[attr.name.toString()] = attr.value;
      }
    }

    var elementCount = 0;

    for (var child in xml.children) {
      if (child.nodeType == XmlNodeType.ELEMENT) {
        content.add(HtmlTag.fromXml(xml.childElements.elementAt(elementCount)));
        elementCount += 1;
      } else if (child.nodeType == XmlNodeType.TEXT) {
        content.add(HtmlTag('text-tag', HtmlTagType.text, child.text, [], {}));
      }
    }
  }

  Json toJson() => {
        'attrs': attrs,
        'content': content.map((tag) => tag.toJson()),
        'name': name,
        'text': text,
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
