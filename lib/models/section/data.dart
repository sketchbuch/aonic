import 'package:xml/xml.dart';

import '../../types/types.dart';

class Data {
  late String text = '';

  Data(this.text);

  Data.fromXml(XmlElement xml) {
    text = xml.text;
  }

  Json toJson() => {
        'text': text,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
