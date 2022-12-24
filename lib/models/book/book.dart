import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'content/plain_list_tag.dart';
import 'content/section_tag.dart';
import 'content/subcontent/book_section_item.dart';
import 'helpers/section_cache.dart';
import 'meta/meta.dart';
import 'section/footnote.dart';

class Book {
  final _sectionCache = SectionCache();
  final List<Footnote> footnoteSections = [];
  final List<SectionTag> sections = [];
  late BookText title = '';
  late Meta meta;
  late PlainListTag? numberedSectionList;
  late PlainListTag toc;
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

    _createSections(xml);
    _collectFootnotes();
    //numberedSectionList = _createNumberedSectionList();
    toc = _createToc();
  }

// TODO - Add toc
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

  void _collectFootnotes() {
    for (var section in sections) {
      if (section.footnotes.isNotEmpty) {
        footnoteSections.addAll(section.footnotes);
      }

      final subsections = section.getSubsections();

      if (subsections.isEmpty) {
        for (var subsection in subsections) {
          if (subsection.footnotes.isNotEmpty) {
            footnoteSections.addAll(subsection.footnotes);
          }
        }
      }
    }
  }

  PlainListTag _createNumberedSectionList() {
    final numberedSections = sections.where((section) => section.type == SectionType.numbered).toList();

    if (numberedSections.isNotEmpty) {
      const blockSize = 10;
      final blocks = numberedSections.slices(blockSize);

      for (var block in blocks) {}
    }

    return {} as PlainListTag;
  }

  void _createSections(XmlElement xml) {
    final titleSection = _getTitleSection(xml);
    final titleSubsections = _getTitleSubsections(titleSection);
    final numberedSection = _getNumberedSection(titleSubsections);
    final numberedBaseData = _getNumberedData(numberedSection);

    final frontmatter = titleSubsections
        .where((sec) {
          final className = sec.getAttribute('class');
          return className == SectionType.frontmatter.name || className == SectionType.frontmatterSeparate.name;
        })
        .map((xml) => SectionTag.fromXml(xml))
        .toList();

    frontmatter.insert(0, SectionTag.fromXml(titleSection, addSubcontent: false, forcedType: SectionType.frontmatter));
    frontmatter.add(SectionTag.fromXml(numberedSection, addSubcontent: false, forcedType: SectionType.frontmatter));

    final numbered = numberedBaseData.findElements('section').map((xml) => SectionTag.fromXml(xml)).toList();

    final backmatter = titleSubsections
        .where((sec) => sec.getAttribute('class') == SectionType.backmatter.name)
        .map((xml) => SectionTag.fromXml(xml))
        .toList();

    sections.addAll(frontmatter);
    sections.addAll(numbered);
    sections.addAll(backmatter);
  }

  PlainListTag _createToc() {
    final BookSectionItems tocIndexSections = [];

    for (var section in sections) {
      if (section.canAddToIndex()) {
        tocIndexSections.add(BookSectionItem(section, 1));

        if (section.isFrontmatter() && section.hasSubsections()) {
          final List<SectionTag> subsections = section.getSubsections();

          for (var subsection in subsections) {
            if (subsection.canAddToIndex(true)) {
              tocIndexSections.add(BookSectionItem(subsection, 2));
            }
          }
        }
      }
    }

    return PlainListTag.fromBookSectionItems(tocIndexSections);
  }

  Iterable<XmlElement> _getTitleSubsections(XmlElement titleSection) {
    final titleData = titleSection.getElement('data');

    if (titleData == null) {
      throw BookXmlException("Title section's data not found");
    }

    return titleData.findElements('section');
  }

  XmlElement _getNumberedSection(Iterable<XmlElement> titleSubsections) {
    final numberedBaseSection = titleSubsections.where((sec) =>
        sec.getAttribute('class') == SectionType.numbered.name && sec.getAttribute('id') == SectionType.numbered.name);

    if (numberedBaseSection.isEmpty) {
      throw BookXmlException('Numbered base section not found');
    }

    return numberedBaseSection.first;
  }

  XmlElement _getNumberedData(XmlElement numberedSection) {
    final numberedBaseData = numberedSection.getElement('data');

    if (numberedBaseData == null) {
      throw BookXmlException('Numbered base data not found');
    }
    return numberedBaseData;
  }

  XmlElement _getTitleSection(XmlElement bookXml) {
    final baseSection = bookXml.findElements('section').where((element) => element.getAttribute('id') == 'title');

    if (baseSection.isEmpty) {
      throw BookXmlException('Title section not found');
    }

    return baseSection.first;
  }

  SectionTag? getSection(String sectionId) {
    // TODO - check cache is working
    if (_sectionCache.contains(sectionId)) {
      return _sectionCache.get(sectionId);
    }

    SectionTag? requiredSection;

    for (var section in sections) {
      if (requiredSection != null) {
        break;
      }

      if (section.id == sectionId) {
        requiredSection = section;
        break;
      } else if (section.hasSubsections()) {
        final List<SectionTag> subsections = section.getSubsections();

        for (var subsection in subsections) {
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

  List<SectionTag> getNumberedSections() {
    return sections.where((section) => section.type == SectionType.numbered).toList();
  }
}
