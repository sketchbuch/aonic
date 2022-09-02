import 'package:recase/recase.dart';
import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'section/data.dart';
import 'section/footnote.dart';
import 'section/meta.dart';

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
  late Meta meta;
  late List<Footnote> footnotes;
  late SectionType type;
  late String id;

  // ignore: unused_element
  Section._();

  Section.fromXml(XmlElement xml) {
    id = getAttribute('id', xml);

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = SectionType.none;
      } else {
        type = SectionType.values.byName(ReCase(typeName).camelCase);
      }
    } on ArgumentError {
      type = SectionType.unknown;
    }

    final dataXml = xml.getElement('data');
    final metaXml = xml.getElement('meta');

    if (metaXml != null) {
      meta = Meta.fromXml(metaXml);
    }

    if (dataXml != null) {
      data = Data.fromXml(dataXml);
    }

    footnotes = xml.findElements('footnotes').map((footnote) => Footnote.fromXml(footnote)).toList();
  }

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
}
