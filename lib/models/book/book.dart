import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
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

  // ignore: unused_element
  Book._();

  Book.fromXml(XmlElement xml) {
    lang = getAttribute('version', xml);
    version = getAttribute('xml:lang', xml);

    final metaXml = xml.getElement('meta');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
      title = meta.title;
    }

    final sections = xml.findAllElements('section');

    backmatter = sections
        .where((sec) => sec.getAttribute('class') == SectionType.backmatter.name)
        .map((xml) => Section.fromXml(xml))
        .toList();

    frontmatter = sections
        .where((sec) {
          final className = sec.getAttribute('class');
          return className == SectionType.frontmatter.name || className == SectionType.frontmatterSeparate.value;
        })
        .map((xml) => Section.fromXml(xml))
        .toList();

    numbered = sections
        .where((sec) =>
            sec.getAttribute('class') == SectionType.numbered.name &&
            sec.getAttribute('id') != SectionType.numbered.name)
        .map((xml) => Section.fromXml(xml))
        .toList();
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