import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

class ParagraphTag extends Tag {
  final List<TextElement> texts = [];

  // ignore: unused_element
  ParagraphTag._();

  ParagraphTag.fromXml(XmlElement xml) {
    texts.addAll(getTextElementList(xml));
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
