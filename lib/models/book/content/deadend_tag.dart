import 'package:xml/xml.dart';

import '../../../types/types.dart';
import 'tag.dart';

// TODO - Use a texelementlist
class DeadendTag extends Tag {
  late final BookText text;

  // ignore: unused_element
  DeadendTag._();

  DeadendTag.fromXml(XmlElement xml) {
    text = xml.text;
  }

  @override
  Json toJson() => {'text': text};
}
