import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'meta_link.dart';

class Meta {
  late List<MetaLink> links = [];
  late String title = '';

  Meta(this.title, this.links);

  Meta.fromXml(XmlElement xml) {
    title = getValue('title', xml);

    final linksXml = xml.findElements('link');

    if (linksXml.isNotEmpty) {
      links = linksXml.map((elementXml) => MetaLink.fromXml(elementXml)).toList();
    }
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
