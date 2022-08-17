import 'package:xml/xml.dart';

import '../utils/xml/helpers.dart';
import 'section.dart';

typedef Json = Map<String, dynamic>;

class Book {
  late DateTime? date;
  late List<Section> sections = [];
  late String lang = '';
  late String publisher = 'Project Aon';
  late String title = '';
  late String version = '';

  Book(this.title, this.lang, this.version, this.date);

  Book.fromXml(String xml) {
    final document = XmlDocument.parse(xml);
    final gb = document.getElement('gamebook');

    if (gb != null) {
      lang = getAttribute('version', gb);
      version = getAttribute('xml:lang', gb);

      final meta = gb.getElement('meta');

      if (meta != null) {
        title = getValue('title', meta);
      }
    }
  }
}
