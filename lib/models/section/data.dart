import 'package:xml/xml.dart';

import '../../types/types.dart';
import 'html_tag.dart';

class Data {
  late final HtmlTag html;

  Data(this.html);

  Data.fromXml(XmlElement xml) {
    html = HtmlTag.fromXml(xml);
  }

  Json toJson() => {
        'html': html.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
