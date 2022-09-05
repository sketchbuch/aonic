import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'meta_link.dart';

class SectionMeta {
  late final List<MetaLink> links = [];
  late final String title;

  // ignore: unused_element
  SectionMeta._();

  SectionMeta.fromXml(XmlElement xml) {
    title = getValue('title', xml);

    xml.findElements('link').forEach((elementXml) {
      links.add(MetaLink.fromXml(elementXml));
    });
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
