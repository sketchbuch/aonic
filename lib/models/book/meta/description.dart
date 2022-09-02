import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/subcontent/text_element.dart';

enum DescriptionType {
  blurb,
  none,
  publication,
  unknown;
}

class Description {
  late DescriptionType type;
  late final List<List<TextElement>> texts;

  // ignore: unused_element
  Description._();

  Description.fromXml(XmlElement xml) {
    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = DescriptionType.none;
      } else {
        type = DescriptionType.values.byName(typeName);
      }
    } on ArgumentError {
      type = DescriptionType.unknown;
    }

    texts = [];

    final paragraphs = xml.findElements('p');

    if (paragraphs.isNotEmpty) {
      for (var p in paragraphs) {
        texts.add(getTextElementList(p));
      }
    }
  }

  Json toJson() => {
        'texts': texts.map((line) => line.map((text) => text.toJson()).toList()).toList(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
