import 'package:xml/xml.dart';

import '../../types/types.dart';
import 'tag.dart';

const defaultAttrValue = 1;

class DeadendTag extends Tag {
  late final String text;

  DeadendTag(this.text);

  DeadendTag.fromXml(XmlElement xml) {
    text = xml.text;
  }

  @override
  Json toJson() => {'text': text};
}
