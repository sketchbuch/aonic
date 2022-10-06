import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'index/book_index_item.dart';
import 'meta/meta.dart';
import 'section/section.dart';

typedef BookIndex = List<BookIndexItem>;

class Book {
  BookIndex? _bookIndex;
  late BookText numberedPageTitle = '';
  late BookText title = '';
  late BookText titlePageTitle = '';
  late List<Section> backmatter = [];
  late List<Section> frontmatter = [];
  late List<Section> numbered = [];
  late Meta meta;
  late String lang = '';
  late String version = '';

  // ignore: unused_element
  Book._();

  Book.fromXml(XmlElement xml) {
    lang = getAttribute('xml:lang', xml);
    version = getAttribute('version', xml);

    final metaXml = xml.getElement('meta');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
      title = meta.title;
    }

    final baseSection = xml
        .findElements('section')
        .where((element) => element.getAttribute('id') == 'title');

    if (baseSection.isEmpty) {
      throw BookXmlException('Title section not found');
    }

    final titleSection = baseSection.elementAt(0);
    final titleData = titleSection.getElement('data');
    final titleMeta = titleSection.getElement('meta');

    titlePageTitle = titleMeta != null ? getValue('title', titleMeta) : '';

    if (titleData == null) {
      throw BookXmlException("Title section's data not found");
    }

    final sections = titleData.findElements('section');

    backmatter = sections
        .where(
            (sec) => sec.getAttribute('class') == SectionType.backmatter.name)
        .map((xml) => Section.fromXml(xml))
        .toList();

    frontmatter = sections
        .where((sec) {
          final className = sec.getAttribute('class');
          return className == SectionType.frontmatter.name ||
              className == SectionType.frontmatterSeparate.value;
        })
        .map((xml) => Section.fromXml(xml))
        .toList();

    final numberedBaseSection = sections.where((sec) =>
        sec.getAttribute('class') == SectionType.numbered.name &&
        sec.getAttribute('id') == SectionType.numbered.name);

    if (numberedBaseSection.isEmpty) {
      throw BookXmlException('Numbered base section not found');
    }

    final numberedBaseMeta = numberedBaseSection.first.getElement('meta');
    final numberedBaseData = numberedBaseSection.first.getElement('data');

    if (numberedBaseData == null) {
      throw BookXmlException('Numbered base data not found');
    }

    final numberedBaseSections = numberedBaseData.findElements('section');

    numberedPageTitle =
        numberedBaseMeta != null ? getValue('title', numberedBaseMeta) : '';

    numbered = numberedBaseSections.map((xml) => Section.fromXml(xml)).toList();
  }

  Json toJson() => {
        'backmatter': backmatter.map((section) => section.toJson()).toList(),
        'frontmatter': frontmatter.map((section) => section.toJson()).toList(),
        'lang': lang,
        'meta': meta.toJson(),
        'numbered': numbered.map((section) => section.toJson()).toList(),
        'numberedPageTitle': numberedPageTitle,
        'title': title,
        'titlePageTitle': titlePageTitle,
        'version': version,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  BookIndex _buildBookIndex() {
    final BookIndex bookIndex = [];

    bookIndex.add(BookIndexItem(
        titlePageTitle, SectionType.title.name, SectionType.title, false));

    for (var section in frontmatter) {
      bookIndex.add(BookIndexItem.fromSection(section, false));

      if (section.sections.isNotEmpty) {
        for (var subSection in section.sections) {
          if (subSection.type == SectionType.frontmatterSeparate) {
            bookIndex.add(BookIndexItem.fromSection(subSection, true));
          }
        }
      }
    }

    bookIndex.add(BookIndexItem(numberedPageTitle, SectionType.numbered.name,
        SectionType.numbered, false));

    for (var section in backmatter) {
      bookIndex.add(BookIndexItem.fromSection(section, false));
    }

    _bookIndex = [...bookIndex];
    return bookIndex;
  }

  BookIndex getBookIndex() {
    return _bookIndex ??= _buildBookIndex();
  }
}
