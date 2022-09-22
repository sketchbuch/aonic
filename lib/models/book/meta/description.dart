import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/paragraph_tag.dart';

enum DescriptionType {
  blurb,
  none,
  publication,
  unknown;
}

class Description {
  late final DescriptionType type;
  @override
  final List<ParagraphTag> paragraphs = [];

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

    final paragraphsXml = xml.findElements('p');

    if (paragraphsXml.isNotEmpty) {
      for (var p in paragraphsXml) {
        paragraphs.add(ParagraphTag.fromXml(p));
      }
    }
  }

  Json toJson() => {
        'paragraphs': paragraphs.map((paragraph) => paragraph.toJson()).toList().toList(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
