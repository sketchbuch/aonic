import 'package:xml/xml.dart';

import '../../types/types.dart';

abstract class Tag {
  Tag();

  Tag.fromXml(XmlElement xml);

  Json toJson() => {};

  @override
  String toString() {
    return toJson().toString();
  }
}
