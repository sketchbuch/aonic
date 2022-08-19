import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum RightType {
  copyrights('copyrights'),
  licenseNotification('license-notification'),
  uknown('uknown');

  const RightType(this.value);
  final String value;
}

class Right {
  late RightType type;
  late String text = '';

  Right(this.text, this.type);

  Right.fromXml(XmlElement xml) {
    text = xml.text;

    try {
      final typeName = getAttribute('class', xml);
      type = RightType.values.byName(ReCase(typeName).camelCase);
    } on ArgumentError {
      type = RightType.uknown;
    }
  }

  Json toJson() => {
        'text': text,
        'type': type.value,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
