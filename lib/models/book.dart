import 'package:xml/xml.dart';

import '../types/types.dart';
import '../utils/xml/helpers.dart';
import 'meta.dart';
import 'section.dart';

class Book {
  late List<Section> sections = [];
  late String lang = '';
  late String title = '';
  late String version = '';
  late Meta meta;

  Book(this.title, this.lang, this.version, this.meta, this.sections);

  Book.fromXml(XmlElement xml) {
    lang = getAttribute('version', xml);
    version = getAttribute('xml:lang', xml);

    final metaXml = xml.getElement('meta');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
      title = meta.title;
    }
  }

  Json toJson() => {
        'sections': sections.map((section) => section.toJson()),
        'lang': lang,
        'meta': meta.toJson(),
        'title': title,
        'version': version,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
