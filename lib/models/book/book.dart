import 'package:lonewolf_new/models/book/helpers/section_cache.dart';
import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'index/book_index_item.dart';
import 'meta/meta.dart';
import 'section/section.dart';

typedef BookIndex = List<BookIndexItem>;

class Book {
  final _sectionCache = SectionCache();
  final List<Section> sections = [];
  late BookIndex bookIndex;
  late BookIndex bookIndex2;
  late BookText title = '';
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

    final baseSection = xml.findElements('section').where((element) => element.getAttribute('id') == 'title');

    if (baseSection.isEmpty) {
      throw BookXmlException('Title section not found');
    }

    final titleSection = baseSection.elementAt(0);
    final titleData = titleSection.getElement('data');

    if (titleData == null) {
      throw BookXmlException("Title section's data not found");
    }

    final allSections = titleData.findElements('section');

    final numberedBaseSection = allSections.where((sec) =>
        sec.getAttribute('class') == SectionType.numbered.name && sec.getAttribute('id') == SectionType.numbered.name);

    if (numberedBaseSection.isEmpty) {
      throw BookXmlException('Numbered base section not found');
    }

    final numberedSection = numberedBaseSection.first;
    final numberedBaseData = numberedSection.getElement('data');

    if (numberedBaseData == null) {
      throw BookXmlException('Numbered base data not found');
    }

    final frontmatter = allSections
        .where((sec) {
          final className = sec.getAttribute('class');
          return className == SectionType.frontmatter.name;
        })
        .map((xml) => Section.fromXml(xml))
        .toList();

    frontmatter.insert(0, Section.fromXml(titleSection, addSubsections: false, forcedType: SectionType.frontmatter));
    frontmatter.add(Section.fromXml(numberedSection, addSubsections: false, forcedType: SectionType.frontmatter));

    final numbered = numberedBaseData.findElements('section').map((xml) => Section.fromXml(xml)).toList();

    final backmatter = allSections
        .where((sec) => sec.getAttribute('class') == SectionType.backmatter.name)
        .map((xml) => Section.fromXml(xml))
        .toList();

    sections.addAll(frontmatter);
    sections.addAll(numbered);
    sections.addAll(backmatter);

    bookIndex = _buildBookIndex();
  }

// TODO - Add bookIndex
  Json toJson() => {
        'lang': lang,
        'meta': meta.toJson(),
        'sections': sections.map((section) => section.toJson()).toList(),
        'title': title,
        'version': version,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  BookIndex _buildBookIndex() {
    final BookIndex bookIndex = [];

    for (var section in sections) {
      if (section.canAddToIndex()) {
        bookIndex.add(BookIndexItem.fromSection(section, false));

        if (section.isFrontmatter() && section.hasSubsections()) {
          for (var subsection in section.subsections) {
            if (subsection.canAddToIndex(isSubsection: true)) {
              bookIndex.add(BookIndexItem.fromSection(subsection, true));
            }
          }
        }
      }
    }

    return bookIndex;
  }

  Section? getSection(String sectionId) {
    // TODO - check cache is working
    if (_sectionCache.contains(sectionId)) {
      return _sectionCache.get(sectionId);
    }

    Section? requiredSection;

    for (var section in sections) {
      if (requiredSection != null) {
        break;
      }

      if (section.id == sectionId) {
        requiredSection = section;
        break;
      } else if (section.hasSubsections()) {
        for (var subsection in section.subsections) {
          if (subsection.id == sectionId) {
            requiredSection = subsection;
            break;
          }
        }
      }
    }

    if (requiredSection != null) {
      _sectionCache.set(sectionId, requiredSection);
      return requiredSection;
    }

    return null;
  }
}
