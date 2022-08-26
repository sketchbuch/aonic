import 'package:xml/xml.dart';

import '../types/types.dart';
import '../utils/xml/helpers.dart';
import 'meta.dart';
import 'section.dart';

class Book {
  late List<Section> backmatter = [];
  late List<Section> frontmatter = [];
  late List<Section> numbered = [];
  late Meta meta;
  late String lang = '';
  late String title = '';
  late String version = '';

  Book(this.title, this.lang, this.version, this.meta, this.backmatter, this.frontmatter, this.numbered);

  Book.fromXml(XmlElement xml) {
    lang = getAttribute('version', xml);
    version = getAttribute('xml:lang', xml);

    final metaXml = xml.getElement('meta');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
      title = meta.title;
    }

    /* final backtmatterXml =
        xml.findAllElements('section').where((sec) => sec.getAttribute('class') == SectionType.backmatter.name);

    if (backtmatterXml.isNotEmpty) {
      backmatter = backtmatterXml.map((xml) => Section.fromXml(xml)).toList();
    }

    final frontmatterXml = xml.findAllElements('section').where((sec) {
      final className = sec.getAttribute('class');
      return className == SectionType.frontmatter.name || className == SectionType.frontmatterSeparate.value;
    });

    if (frontmatterXml.isNotEmpty) {
      frontmatter = frontmatterXml.map((xml) => Section.fromXml(xml)).toList();
    } */

    final numberedXml = xml.findAllElements('section').where((sec) =>
        sec.getAttribute('class') == SectionType.numbered.name && sec.getAttribute('id') != SectionType.numbered.name);

    if (numberedXml.isNotEmpty) {
      //numbered = numberedXml.map((xml) => Section.fromXml(xml)).toList();
      numbered = [Section.fromXml(numberedXml.elementAt(112))];
    }
  }

  Json toJson() => {
        'backmatter': backmatter.map((section) => section.toJson()).toList(),
        'frontmatter': frontmatter.map((section) => section.toJson()).toList(),
        'lang': lang,
        'meta': meta.toJson(),
        'numbered': numbered.map((section) => section.toJson()).toList(),
        'title': title,
        'version': version,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
