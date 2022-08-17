import 'dart:convert';

import 'package:xml2json/xml2json.dart';

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
    final json = _getJsonFromXml(xml);

    if (json.containsKey('gamebook')) {
      final Json gb = json['gamebook'];

      lang = _getValue('_xml:lang', gb);
      version = _getValue('_version', gb);

      if (gb.containsKey('meta')) {
        final Json meta = gb['meta'];

        title = _getValue('title', meta);
      }
    }
  }

  Json _getJsonFromXml(String xml) {
    final Xml2Json xml2Json = Xml2Json();
    xml2Json.parse(xml);

    return jsonDecode(xml2Json.toParkerWithAttrs());
  }

  String _getValue(String key, Json json) {
    return json.containsKey(key) ? json[key] : '';
  }
}
