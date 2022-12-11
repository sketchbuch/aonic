import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'data.dart';
import 'footnote.dart';
import 'section_meta.dart';

enum SectionType {
  backmatter('backmatter'),
  frontmatter('frontmatter'),
  frontmatterSeparate('frontmatter-separate'),
  none('none'),
  numbered('numbered'),
  unknown('unknown');

  const SectionType(this.value);
  final String value;
}

class Section {
  late Data data;
  late List<Footnote> footnotes;
  late List<Section> subsections;
  late SectionMeta meta;
  late SectionType type;
  late String id;

  // ignore: unused_element
  Section._();

  Section.fromXml(
    XmlElement xml, {
    bool addSubsections = true,
    SectionType? forcedType,
  }) {
    id = getAttribute('id', xml);

    try {
      if (forcedType != null) {
        type = forcedType;
      } else {
        final typeName = getAttribute('class', xml);

        if (typeName.isEmpty) {
          type = SectionType.none;
        } else {
          type = SectionType.values.byName(ReCase(typeName).camelCase);
        }
      }
    } on ArgumentError {
      type = SectionType.unknown;
    }

    final dataXml = xml.getElement('data');
    final metaXml = xml.getElement('meta');
    final footnotesXml = xml.getElement('footnotes');

    if (metaXml != null) {
      meta = SectionMeta.fromXml(metaXml);
    }

    if (dataXml != null) {
      data = Data.fromXml(dataXml);

      if (addSubsections) {
        subsections = dataXml.findElements('section').map((section) => Section.fromXml(section)).toList();
      } else {
        subsections = [];
      }
    }

    footnotes = footnotesXml != null
        ? footnotesXml.findElements('footnote').map((footnote) => Footnote.fromXml(footnote)).toList()
        : [];
  }

  Json toJson() => {
        'data': data.toJson(),
        'footnotes': footnotes.map((footnote) => footnote.toJson()).toList(),
        'id': id,
        'meta': meta.toJson(),
        'subsections': subsections.map((section) => section.toJson()).toList(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool canAddToIndex({bool isSubsection = false}) {
    final isIndexableSub = isSubsection && isFrontmatterSeperate();
    final isIndexableMain = !isSubsection && (isFrontmatter() || isBackmatter());

    return isIndexableSub || isIndexableMain;
  }

  List<Section> getVisibleSubsections() {
    return subsections.where((section) => !section.isFrontmatterSeperate()).toList();
  }

  bool hasSubsections() {
    return subsections.isNotEmpty;
  }

  bool isBackmatter() {
    return type == SectionType.backmatter;
  }

  bool isFrontmatter() {
    return type == SectionType.frontmatter;
  }

  bool isFrontmatterSeperate() {
    return type == SectionType.frontmatterSeparate;
  }

  bool isNumbered() {
    return type == SectionType.numbered;
  }
}
