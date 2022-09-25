import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/paragraph_tag.dart';

enum RightType {
  copyrights('copyrights'),
  licenseNotification('license-notification'),
  none('none'),
  unknown('unknown');

  const RightType(this.value);
  final String value;
}

class Right {
  late final RightType type;
  final List<ParagraphTag> paragraphs = [];

  // ignore: unused_element
  Right._();

  Right.fromXml(XmlElement xml) {
    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = RightType.none;
      } else {
        type = RightType.values.byName(ReCase(typeName).camelCase);
      }
    } on ArgumentError {
      type = RightType.unknown;
    }

    final lineXml = xml.findAllElements('line');

    if (lineXml.isNotEmpty) {
      for (var l in lineXml) {
        paragraphs.add(ParagraphTag.fromXml(l));
      }
    }
  }

  Json toJson() => {
        'paragraphs': paragraphs.map((paragraph) => paragraph.toJson()).toList().toList(),
        'type': type.value,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
