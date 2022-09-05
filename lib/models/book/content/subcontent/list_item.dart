import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import 'text_element.dart';

class ListItem {
  final List<TextElement> texts = [];

  // ignore: unused_element
  ListItem._();

  ListItem.fromXml(XmlElement xml) {
    texts.addAll(getTextElementList(xml));
  }

  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
