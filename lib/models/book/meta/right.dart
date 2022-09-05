import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/subcontent/text_element.dart';

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
  late final List<List<TextElement>> texts;

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

    texts = [];

    final lines = xml.findAllElements('line');

    if (lines.isNotEmpty) {
      for (var l in lines) {
        texts.add(getTextElementList(l));
      }
    }
  }

  Json toJson() => {
        'texts': texts.map((line) => line.map((text) => text.toJson()).toList()).toList(),
        'type': type.value,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
