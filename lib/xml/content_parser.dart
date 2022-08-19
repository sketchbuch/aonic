import 'package:xml/xml.dart';

import '../types/types.dart';

typedef Attrs = Map<String, String>;

class ContentParser {
  Json toJson(XmlElement xml) {
    try {
      return _transform(xml, {});
    } on RangeError {
      rethrow;
    } catch (e) {
      throw Exception('Transfrom Error: ${e.toString()}');
    }
  }

  Json _transform(XmlElement xml, Json json) {
    final name = xml.name.toString();

    json[name] = {};

    if (xml.attributes.isNotEmpty) {
      json[name]['attrs'] = _getAttrs(xml);
    }

    if (xml.children.isNotEmpty) {
      json[name]['content'] = [];

      final childCount = xml.children.length;
      final childElementCount = xml.childElements.length;

      if (childCount == 1 && childElementCount == 1) {
        // Single tag
        json[name]['content'].add(_transform(xml.childElements.first, {}));
      } else {
        // Text and Tag mix
        var elementCount = 0;

        for (var child in xml.children) {
          if (child.nodeType == XmlNodeType.ELEMENT) {
            json[name]['content'].add(_transform(xml.childElements.elementAt(elementCount), {}));
            elementCount += 1;
          } else {
            json[name]['content'].add(child.text);
          }
        }
      }
    }

    return json;
  }

  Attrs _getAttrs(XmlElement xml) {
    Attrs attrs = {};

    if (xml.attributes.isNotEmpty) {
      for (var attr in xml.attributes) {
        attrs[attr.name.toString()] = attr.value;
      }
    }

    return attrs;
  }
}
