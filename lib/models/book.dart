import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import 'section.dart';

typedef Json = Map<String, dynamic>;

class Book {
  late List<Section> sections = [];
  late final String lang;
  late final String title;
  late final String version;

  Book(this.title, this.lang, this.version);

  Book.fromXml(String xml) {
    final json = _getJsonFromXml(xml);

    if (json.containsKey('gamebook')) {
      final Json gb = json['gamebook'];

      lang = gb.containsKey('_xml:lang') ? gb['_xml:lang'] : '';
      title = gb.containsKey('meta') && gb['meta'].containsKey('title') ? gb['meta']['title'] : '';
      version = gb.containsKey('_version') ? gb['_version'] : '';
    } else {
      lang = '';
      title = '';
      version = '';
    }

    sections = [];
  }

  Json _getJsonFromXml(String xml) {
    final Xml2Json xml2Json = Xml2Json();
    xml2Json.parse(xml);

    return jsonDecode(xml2Json.toParkerWithAttrs());
  }
}
