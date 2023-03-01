import 'package:xml/xml.dart';

import '../../../types/types.dart';
import 'tag.dart';

// TODO - Use a texelementlist
class DeadendTagModel extends TagModel {
  late final BookText text;

  // ignore: unused_element
  DeadendTagModel._();

  DeadendTagModel.fromXml(XmlElement xml) {
    text = xml.text;
  }

  @override
  Json toJson() => {'text': text};
}
