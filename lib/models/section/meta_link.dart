import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum MetaLinkType {
  next,
  prev,
  unknown;
}

class MetaLink {
  late final String idRef;
  late final MetaLinkType type;

  MetaLink(this.type, this.idRef);

  MetaLink.fromXml(XmlElement xml) {
    idRef = getAttribute('idref', xml);

    try {
      final typeName = getAttribute('class', xml);
      type = MetaLinkType.values.byName(typeName);
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
