import 'package:xml/xml.dart';

import '../../types/types.dart';
import 'tag.dart';

class DeadendTag extends Tag {
  late final String text;

  DeadendTag._() {}

  DeadendTag.fromXml(XmlElement xml) {
    text = xml.text;
  }

  @override
  Json toJson() => {'text': text};
}
