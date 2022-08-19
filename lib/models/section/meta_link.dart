import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

enum MetaLinkType {
  next,
  prev,
  uknown;
}

class MetaLink {
  late String idRef;
  late MetaLinkType type;

  MetaLink(this.type, this.idRef);

  MetaLink.fromXml(XmlElement xml) {
    idRef = getAttribute('idref', xml);

    try {
      final typeName = getAttribute('class', xml);
      type = MetaLinkType.values.byName(typeName);
    } on ArgumentError {
      type = MetaLinkType.uknown;
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
