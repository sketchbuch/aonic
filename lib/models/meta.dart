import 'package:xml/xml.dart';

import '../utils/xml/helpers.dart';

class Meta {
  late DateTime? date;
  late String publisher = 'Project Aon';
  late String title = '';

  Meta(this.title);

  Meta.fromXml(XmlElement xml) {
    title = getValue('title', xml);
  }
}
