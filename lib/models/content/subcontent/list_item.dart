import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'text_element.dart';

class ListItem {
  late final List<TextElement> texts;

  ListItem._();

  ListItem.fromXml(XmlElement xml) {
    texts = getTextElementList(xml);
  }

  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
