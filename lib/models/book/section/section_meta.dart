import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'meta_link.dart';

class SectionMeta {
  late List<MetaLink> links = [];
  late String title = '';

  // ignore: unused_element
  SectionMeta._();

  SectionMeta.fromXml(XmlElement xml) {
    title = getValue('title', xml);
    links = xml.findElements('link').map((elementXml) => MetaLink.fromXml(elementXml)).toList();
  }

  Json toJson() => {
        'links': links.map((link) => link.toJson()).toList(),
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
