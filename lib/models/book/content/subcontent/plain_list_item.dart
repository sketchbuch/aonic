import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import 'text_element.dart';

class PlainListItem {
  final List<TextElement> texts = [];

  // ignore: unused_element
  PlainListItem._();

  PlainListItem.fromXml(XmlElement xml) {
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
