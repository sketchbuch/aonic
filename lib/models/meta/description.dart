import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum DescriptionType {
  blurb,
  publication,
  unknown;
}

class Description {
  late DescriptionType type;
  late String text = '';

  Description(this.text, this.type);

  Description.fromXml(XmlElement xml) {
    text = xml.text;

    try {
      final typeName = getAttribute('class', xml);
      type = DescriptionType.values.byName(typeName);
    } on ArgumentError {
      type = DescriptionType.unknown;
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
