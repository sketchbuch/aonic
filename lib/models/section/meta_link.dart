import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum MetaLinkType {
  next,
  none,
  prev,
  unknown,
}

class MetaLink {
  late final String idRef;
  late final MetaLinkType type;

  // ignore: unused_element
  MetaLink._();

  MetaLink.fromXml(XmlElement xml) {
    idRef = getAttribute('idref', xml);

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = MetaLinkType.none;
      } else {
        type = MetaLinkType.values.byName(typeName);
      }
    } on ArgumentError {
      type = MetaLinkType.unknown;
    }
  }

  Json toJson() => {
        'idRef': idRef,
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
