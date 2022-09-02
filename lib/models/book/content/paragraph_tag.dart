import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

// TODO - Add paragraph type
class ParagraphTag extends Tag {
  late final List<TextElement> texts;

  // ignore: unused_element
  ParagraphTag._();

  ParagraphTag.fromXml(XmlElement xml) {
    texts = getTextElementList(xml);
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
