import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'meta_link_model.dart';

class SectionMetaModel {
  late final BookText title;
  late final List<MetaLinkModel> links = [];

  // ignore: unused_element
  SectionMetaModel._();

  SectionMetaModel.fromXml(XmlElement xml) {
    title = getValue('title', xml);

    xml.findElements('link').forEach((elementXml) {
      links.add(MetaLinkModel.fromXml(elementXml));
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
