import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'content/plain_list_tag.dart';
import 'content/section_tag.dart';
import 'content/subcontent/numbered_section_item.dart';
import 'content/subcontent/text_element.dart';
import 'content/subcontent/toc_item.dart';
import 'content/tag.dart';
import 'helpers/section_cache.dart';
import 'meta/meta.dart';
import 'section/footnote.dart';

class Book {
  final _sectionCache = SectionCache();
  final List<Footnote> footnoteSections = [];
  final List<NumberedSectionItem> numberedSectionItems = [];
  final List<SectionTag> sections = [];
  late BookText title = '';
  late Meta meta;
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

    final numberedSections = _createSections(xml);
    _collectFootnotes();
    _updateFootnoteRefs();
    _createNumberedSectionList(numberedSections);
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

      if (subsections.isNotEmpty) {
        for (var subsection in subsections) {
          if (subsection.footnotes.isNotEmpty) {
            footnoteSections.addAll(subsection.footnotes);
          }
        }
      }
    }

    int footnoteNumber = 1;

    for (var footnote in footnoteSections) {
      footnote.footnoteNumber = footnoteNumber;
      footnoteNumber += 1;
    }
  }

  void _updateFootnoteRefs() {
    for (var section in sections) {
      if (section.footnotes.isNotEmpty && section.data.content.isNotEmpty) {
        _updateFootnoteRefsLinks(section.data.content, section.footnotes);

        final subsections = section.getSubsections();

        if (subsections.isNotEmpty) {
          for (var subsection in subsections) {
            if (subsection.footnotes.isNotEmpty && subsection.data.content.isNotEmpty) {
              _updateFootnoteRefsLinks(subsection.data.content, subsection.footnotes);
            }
          }
        }
      }
    }
  }

  void _updateFootnoteRefsLinks(List<Tag> content, List<Footnote> footnotes) {
    for (var tag in content) {
      if (tag.texts.isNotEmpty) {
        final footnoteRefs = tag.texts.where((text) => text.displayType == DisplayType.footref).toList();

        if (footnoteRefs.isNotEmpty) {
          for (var text in footnoteRefs) {
            final footnote = footnotes.firstWhereOrNull((footnote) => footnote.idRef == text.attrs['id']);

            if (footnote != null) {
              text.text = footnote.footnoteNumber.toString();
            }
          }
        }
      }
    }
  }

  void _createNumberedSectionList(List<SectionTag> numberedSections) {
    for (var section in numberedSections) {
      numberedSectionItems.add(NumberedSectionItem(section.meta.title, section.id));
    }
  }

  List<SectionTag> _createSections(XmlElement xml) {
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

    return numbered;
  }

  PlainListTag _createToc() {
    final List<TocItem> tocIndexSections = [];

    for (var section in sections) {
      if (section.canAddToIndex()) {
        tocIndexSections.add(TocItem(section, 1));

        if (section.isFrontmatter() && section.hasSubsections()) {
          final List<SectionTag> subsections = section.getSubsections();

          for (var subsection in subsections) {
            if (subsection.canAddToIndex(true)) {
              tocIndexSections.add(TocItem(subsection, 2));
            }
          }
        }
      }
    }

    return PlainListTag.fromTocItems(tocIndexSections);
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
