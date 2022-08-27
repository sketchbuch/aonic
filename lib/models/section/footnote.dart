import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';

class Footnote {
  late String id = '';
  late String idRef = '';
  late String text = '';

  // ignore: unused_element
  Footnote._();

  Footnote.fromXml(XmlElement xml) {
    id = getAttribute('id', xml);
    idRef = getAttribute('idref', xml);
  }

  Json toJson() => {
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
