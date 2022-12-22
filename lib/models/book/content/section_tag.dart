import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../section/data.dart';
import '../section/footnote.dart';
import '../section/section_meta.dart';
import 'tag.dart';

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

class SectionTag extends Tag {
  late Data data;
  late List<Footnote> footnotes;
  late SectionMeta meta;
  late SectionType type;
  late String id;

  // ignore: unused_element
  SectionTag._();

  SectionTag.fromXml(
    XmlElement xml, {
    bool addSubcontent = true,
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
      data = Data.fromXml(dataXml, addSubcontent);
    }

    footnotes = footnotesXml != null
        ? footnotesXml.findElements('footnote').map((footnote) => Footnote.fromXml(footnote, meta.title, id)).toList()
        : [];
  }

  @override
  Json toJson() => {
        'data': data.toJson(),
        'footnotes': footnotes.map((footnote) => footnote.toJson()).toList(),
        'id': id,
        'meta': meta.toJson(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  bool canAddToIndex([bool isSubsection = false]) {
    final isIndexableSub = isSubsection && isFrontmatterSeperate();
    final isIndexableMain = !isSubsection && (isFrontmatter() || isBackmatter());

    return isIndexableSub || isIndexableMain;
  }

  List<SectionTag> getSubsections() {
    return data.content
        .where((element) => element.tagType() == 'SectionTag')
        .map((section) => section as SectionTag)
        .toList();
  }

  List<SectionTag> getVisibleSubsections() {
    return getSubsections().where((section) => !section.isFrontmatterSeperate()).toList();
  }

  bool hasSubsections() {
    return getSubsections().isNotEmpty;
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
