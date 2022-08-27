import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum CreatorType {
  author,
  illustrator,
  long,
  medium,
  none,
  short,
  unknown;
}

class Creator {
  late CreatorType type;
  late String? sortText = '';
  late String text = '';

  // ignore: unused_element
  Creator._();

  Creator.fromXml(XmlElement xml) {
    sortText = getAttribute('sort-name', xml, text);
    text = xml.text;

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = CreatorType.none;
      } else {
        type = CreatorType.values.byName(typeName);
      }
    } on ArgumentError {
      type = CreatorType.unknown;
    }
  }

  Json toJson() => {
        'text': text,
        'type': type.name,
        'sortText': sortText,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
