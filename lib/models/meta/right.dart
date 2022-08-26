import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum RightType {
  copyrights,
  licenseNotification,
  none,
  unknown,
}

class Right {
  late RightType type;
  late String text = '';

  Right._();

  Right.fromXml(XmlElement xml) {
    text = xml.text;

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
  }

  Json toJson() => {
        'text': text,
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
