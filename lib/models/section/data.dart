import 'package:lonewolf_new/xml/content_parser.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';

class Data {
  late Json content = {};

  Data(this.content);

  Data.fromXml(XmlElement xml) {
    final parser = ContentParser();
    content = parser.toJson(xml);
  }

  Json toJson() => {
        'content': content,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
