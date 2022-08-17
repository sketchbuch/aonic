import 'package:xml/xml.dart';

import '../utils/xml/helpers.dart';
import 'meta.dart';
import 'section.dart';

typedef Json = Map<String, dynamic>;

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

    final m = xml.getElement('meta');

    if (m != null) {
      meta = Meta.fromXml(m);
      title = meta.title;
    }
  }
}
