import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

enum ParagraphType {
  dedication,
  none,
  unknown,
}

class ParagraphTag extends Tag {
  final List<TextElement> texts = [];
  late final ParagraphType type;

  // ignore: unused_element
  ParagraphTag._();

  ParagraphTag.fromXml(XmlElement xml) {
    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = ParagraphType.none;
      } else {
        type = ParagraphType.values.byName(typeName);
      }
    } on ArgumentError {
      type = ParagraphType.unknown;
    }

    if (type == ParagraphType.dedication) {
      texts.addAll(getTextElementList(xml, DisplayType.italic));
    } else {
      texts.addAll(getTextElementList(xml));
    }
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
        'type': type.name,
      };
}
